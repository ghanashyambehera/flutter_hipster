import 'package:equatable/equatable.dart';

/// A member of the call, derived from Chime attendee/tile callbacks.
class Participant extends Equatable {
  const Participant({
    required this.attendeeId,
    required this.isLocal,
    this.videoTileId,
    this.audioMuted = false,
    this.videoEnabled = true,
  });

  final String attendeeId;
  final bool isLocal;
  final int? videoTileId;
  final bool audioMuted;
  final bool videoEnabled;

  bool get hasVideo => videoTileId != null && videoEnabled;

  Participant copyWith({
    int? videoTileId,
    bool clearVideoTile = false,
    bool? audioMuted,
    bool? videoEnabled,
  }) {
    return Participant(
      attendeeId: attendeeId,
      isLocal: isLocal,
      videoTileId: clearVideoTile ? null : (videoTileId ?? this.videoTileId),
      audioMuted: audioMuted ?? this.audioMuted,
      videoEnabled: videoEnabled ?? this.videoEnabled,
    );
  }

  @override
  List<Object?> get props => [attendeeId, isLocal, videoTileId, audioMuted, videoEnabled];
}
