import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Renders a single Chime video tile via a native `AndroidView`. On non-Android
/// platforms (or when no tile is bound) it shows a placeholder, so the widget is
/// safe to build everywhere and in tests.
class VideoTileView extends StatelessWidget {
  const VideoTileView({
    super.key,
    required this.tileId,
    this.label,
    this.mirror = false,
  });

  /// The Chime tile id to bind, or null when there is no video to show.
  final int? tileId;
  final String? label;
  final bool mirror;

  static const String _viewType = 'chime/video-tile';

  @override
  Widget build(BuildContext context) {
    final Widget content;
    if (tileId == null || defaultTargetPlatform != TargetPlatform.android) {
      content = _Placeholder(label: label);
    } else {
      content = AndroidView(
        viewType: _viewType,
        creationParams: {'tileId': tileId},
        creationParamsCodec: const StandardMessageCodec(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            content,
            if (label != null)
              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    label!,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF1E1E24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.videocam_off, color: Colors.white38, size: 40),
            const SizedBox(height: 8),
            Text(
              label == null ? 'No video' : '$label — camera off',
              style: const TextStyle(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }
}
