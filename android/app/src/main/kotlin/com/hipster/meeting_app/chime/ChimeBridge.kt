package com.hipster.meeting_app.chime

import android.content.Context
import android.os.Handler
import android.os.Looper
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AttendeeInfo
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoFacade
import com.amazonaws.services.chime.sdk.meetings.audiovideo.AudioVideoObserver
import com.amazonaws.services.chime.sdk.meetings.audiovideo.SignalUpdate
import com.amazonaws.services.chime.sdk.meetings.audiovideo.VolumeUpdate
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.RemoteVideoSource
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoRenderView
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoTileObserver
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.VideoTileState
import com.amazonaws.services.chime.sdk.meetings.device.DeviceChangeObserver
import com.amazonaws.services.chime.sdk.meetings.device.MediaDevice
import com.amazonaws.services.chime.sdk.meetings.device.MediaDeviceType
import com.amazonaws.services.chime.sdk.meetings.realtime.RealtimeObserver
import com.amazonaws.services.chime.sdk.meetings.session.Attendee
import com.amazonaws.services.chime.sdk.meetings.session.CreateAttendeeResponse
import com.amazonaws.services.chime.sdk.meetings.session.CreateMeetingResponse
import com.amazonaws.services.chime.sdk.meetings.session.DefaultMeetingSession
import com.amazonaws.services.chime.sdk.meetings.session.MediaPlacement
import com.amazonaws.services.chime.sdk.meetings.session.Meeting
import com.amazonaws.services.chime.sdk.meetings.session.MeetingSessionConfiguration
import com.amazonaws.services.chime.sdk.meetings.session.MeetingSessionStatus
import com.amazonaws.services.chime.sdk.meetings.utils.logger.ConsoleLogger
import com.amazonaws.services.chime.sdk.meetings.utils.logger.LogLevel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * Native bridge between Flutter and the Amazon Chime SDK.
 *
 * Commands arrive on the `chime/commands` [MethodChannel]; SDK observer
 * callbacks are pushed to Dart as typed maps on the `chime/events`
 * [EventChannel]. The Dart `ChimeAndroidBridge` maps those maps to `RtcEvent`s.
 */
class ChimeBridge(
    private val context: Context,
    messenger: BinaryMessenger,
) : MethodChannel.MethodCallHandler,
    EventChannel.StreamHandler,
    AudioVideoObserver,
    RealtimeObserver,
    VideoTileObserver,
    DeviceChangeObserver {

    private val commandChannel = MethodChannel(messenger, "chime/commands")
    private val eventChannel = EventChannel(messenger, "chime/events")
    private val mainHandler = Handler(Looper.getMainLooper())

    private var eventSink: EventChannel.EventSink? = null
    private var meetingSession: DefaultMeetingSession? = null

    private val audioVideo: AudioVideoFacade?
        get() = meetingSession?.audioVideo

    init {
        commandChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    // region MethodChannel

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "start" -> start(call, result)
            "stop" -> {
                stop()
                result.success(null)
            }
            "setMuted" -> {
                val muted = call.argument<Boolean>("muted") ?: false
                if (muted) audioVideo?.realtimeLocalMute() else audioVideo?.realtimeLocalUnmute()
                result.success(null)
            }
            "setCameraEnabled" -> {
                val enabled = call.argument<Boolean>("enabled") ?: true
                if (enabled) audioVideo?.startLocalVideo() else audioVideo?.stopLocalVideo()
                result.success(null)
            }
            "switchCamera" -> {
                audioVideo?.switchCamera()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun start(call: MethodCall, result: MethodChannel.Result) {
        try {
            val meetingMap = call.argument<Map<String, Any?>>("meeting") ?: emptyMap()
            val attendeeMap = call.argument<Map<String, Any?>>("attendee") ?: emptyMap()

            val configuration = MeetingSessionConfiguration(
                CreateMeetingResponse(buildMeeting(meetingMap)),
                CreateAttendeeResponse(buildAttendee(attendeeMap)),
            )
            val session = DefaultMeetingSession(
                configuration,
                ConsoleLogger(LogLevel.INFO),
                context,
            )
            meetingSession = session

            session.audioVideo.apply {
                addAudioVideoObserver(this@ChimeBridge)
                addRealtimeObserver(this@ChimeBridge)
                addVideoTileObserver(this@ChimeBridge)
                addDeviceChangeObserver(this@ChimeBridge)
                start()
                startLocalVideo()
                startRemoteVideo()
            }
            result.success(null)
        } catch (e: Exception) {
            emit(mapOf("type" to "error", "message" to (e.message ?: "Chime start failed")))
            result.error("CHIME_START_FAILED", e.message, null)
        }
    }

    private fun stop() {
        audioVideo?.apply {
            stopLocalVideo()
            stopRemoteVideo()
            removeAudioVideoObserver(this@ChimeBridge)
            removeRealtimeObserver(this@ChimeBridge)
            removeVideoTileObserver(this@ChimeBridge)
            removeDeviceChangeObserver(this@ChimeBridge)
            stop()
        }
        meetingSession = null
    }

    /**
     * Routes call audio to a sensible loud output. Without an explicit choice
     * Chime plays through the earpiece (inaudible for a hands-free video call),
     * so we prefer a connected headset/Bluetooth device and otherwise fall back
     * to the built-in loudspeaker.
     */
    private fun routeAudioToBestDevice() {
        val av = audioVideo ?: return
        val devices = av.listAudioDevices()
        val preferred = devices.firstOrNull {
            it.type == MediaDeviceType.AUDIO_BLUETOOTH ||
                it.type == MediaDeviceType.AUDIO_WIRED_HEADSET
        } ?: devices.firstOrNull { it.type == MediaDeviceType.AUDIO_BUILTIN_SPEAKER }
        if (preferred != null) av.chooseAudioDevice(preferred)
    }

    /** Builds the SDK [Meeting] from the raw API JSON map (keys preserved). */
    private fun buildMeeting(map: Map<String, Any?>): Meeting {
        @Suppress("UNCHECKED_CAST")
        val mp = map["MediaPlacement"] as? Map<String, Any?> ?: emptyMap()
        val mediaPlacement = MediaPlacement(
            mp["AudioFallbackUrl"] as? String ?: "",
            mp["AudioHostUrl"] as? String ?: "",
            mp["SignalingUrl"] as? String ?: "",
            mp["TurnControlUrl"] as? String ?: "",
            mp["EventIngestionUrl"] as? String ?: "",
        )
        return Meeting(
            map["ExternalMeetingId"] as? String,
            mediaPlacement,
            map["MediaRegion"] as? String ?: "",
            map["MeetingId"] as? String ?: "",
        )
    }

    private fun buildAttendee(map: Map<String, Any?>): Attendee = Attendee(
        map["AttendeeId"] as? String ?: "",
        map["ExternalUserId"] as? String ?: "",
        map["JoinToken"] as? String ?: "",
    )

    // endregion

    // region Video tile binding (used by the PlatformView)

    fun bindVideoView(view: VideoRenderView, tileId: Int) {
        audioVideo?.bindVideoView(view, tileId)
    }

    fun unbindVideoView(tileId: Int) {
        audioVideo?.unbindVideoView(tileId)
    }

    // endregion

    // region EventChannel

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    private fun emit(event: Map<String, Any?>) {
        mainHandler.post { eventSink?.success(event) }
    }

    // endregion

    // region AudioVideoObserver

    override fun onAudioSessionStartedConnecting(reconnecting: Boolean) {}

    override fun onAudioSessionStarted(reconnecting: Boolean) {
        routeAudioToBestDevice()
        emit(mapOf("type" to "connected"))
    }

    override fun onAudioSessionDropped() {
        emit(mapOf("type" to "disconnected", "reason" to "dropped"))
    }

    override fun onAudioSessionStopped(sessionStatus: MeetingSessionStatus) {
        emit(mapOf("type" to "disconnected", "reason" to sessionStatus.statusCode?.name))
    }

    override fun onAudioSessionCancelledReconnect() {}

    override fun onConnectionRecovered() {}

    override fun onConnectionBecamePoor() {}

    override fun onCameraSendAvailabilityUpdated(available: Boolean) {}

    override fun onVideoSessionStartedConnecting() {}

    override fun onVideoSessionStarted(sessionStatus: MeetingSessionStatus) {}

    override fun onVideoSessionStopped(sessionStatus: MeetingSessionStatus) {}

    override fun onRemoteVideoSourceAvailable(sources: List<RemoteVideoSource>) {}

    override fun onRemoteVideoSourceUnavailable(sources: List<RemoteVideoSource>) {}

    // endregion

    // region RealtimeObserver

    override fun onAttendeesJoined(attendeeInfo: Array<AttendeeInfo>) {
        attendeeInfo.forEach {
            emit(mapOf("type" to "attendeeJoined", "attendeeId" to it.attendeeId))
        }
    }

    override fun onAttendeesLeft(attendeeInfo: Array<AttendeeInfo>) {
        attendeeInfo.forEach {
            emit(mapOf("type" to "attendeeLeft", "attendeeId" to it.attendeeId))
        }
    }

    override fun onAttendeesDropped(attendeeInfo: Array<AttendeeInfo>) {
        attendeeInfo.forEach {
            emit(mapOf("type" to "attendeeLeft", "attendeeId" to it.attendeeId))
        }
    }

    override fun onAttendeesMuted(attendeeInfo: Array<AttendeeInfo>) {}

    override fun onAttendeesUnmuted(attendeeInfo: Array<AttendeeInfo>) {}

    override fun onSignalStrengthChanged(signalUpdates: Array<SignalUpdate>) {}

    override fun onVolumeChanged(volumeUpdates: Array<VolumeUpdate>) {}

    // endregion

    // region VideoTileObserver

    override fun onVideoTileAdded(tileState: VideoTileState) {
        emit(
            mapOf(
                "type" to "videoTileAdded",
                "tileId" to tileState.tileId,
                "isLocal" to tileState.isLocalTile,
                "attendeeId" to tileState.attendeeId,
            ),
        )
    }

    override fun onVideoTileRemoved(tileState: VideoTileState) {
        emit(mapOf("type" to "videoTileRemoved", "tileId" to tileState.tileId))
    }

    override fun onVideoTilePaused(tileState: VideoTileState) {}

    override fun onVideoTileResumed(tileState: VideoTileState) {}

    override fun onVideoTileSizeChanged(tileState: VideoTileState) {}

    // endregion

    // region DeviceChangeObserver

    override fun onAudioDeviceChanged(freshAudioDeviceList: List<MediaDevice>) {
        // Re-evaluate routing so plugging in a headset (or unplugging it) keeps
        // audio on the most sensible device rather than reverting to earpiece.
        routeAudioToBestDevice()
    }

    // endregion
}
