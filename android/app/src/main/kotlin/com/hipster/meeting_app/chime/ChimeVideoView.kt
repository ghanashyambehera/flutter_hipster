package com.hipster.meeting_app.chime

import android.content.Context
import android.view.View
import com.amazonaws.services.chime.sdk.meetings.audiovideo.video.DefaultVideoRenderView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

/** A Chime [DefaultVideoRenderView] surfaced to Flutter as a PlatformView. */
class ChimeVideoView(
    context: Context,
    private val bridge: ChimeBridge,
    private val tileId: Int,
) : PlatformView {

    private val renderView = DefaultVideoRenderView(context)

    init {
        if (tileId >= 0) bridge.bindVideoView(renderView, tileId)
    }

    override fun getView(): View = renderView

    override fun dispose() {
        if (tileId >= 0) bridge.unbindVideoView(tileId)
    }
}

/** Builds [ChimeVideoView]s, reading the `tileId` creation parameter. */
class ChimeVideoViewFactory(
    private val bridge: ChimeBridge,
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val params = args as? Map<*, *>
        val tileId = (params?.get("tileId") as? Number)?.toInt() ?: -1
        return ChimeVideoView(context, bridge, tileId)
    }
}
