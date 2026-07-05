import 'package:flutter/material.dart';

/// In-call control bar: mic, camera, switch-camera, leave. Stateless — it only
/// renders the passed flags and reports taps upward (constitution Article II).
class ControlBar extends StatelessWidget {
  const ControlBar({
    super.key,
    required this.micOn,
    required this.cameraOn,
    required this.onToggleMic,
    required this.onToggleCamera,
    required this.onSwitchCamera,
    required this.onLeave,
  });

  final bool micOn;
  final bool cameraOn;
  final VoidCallback onToggleMic;
  final VoidCallback onToggleCamera;
  final VoidCallback onSwitchCamera;
  final VoidCallback onLeave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: Colors.black87,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _ControlButton(
            key: const Key('control_mic'),
            icon: micOn ? Icons.mic : Icons.mic_off,
            label: micOn ? 'Mute' : 'Unmute',
            active: micOn,
            onPressed: onToggleMic,
          ),
          _ControlButton(
            key: const Key('control_camera'),
            icon: cameraOn ? Icons.videocam : Icons.videocam_off,
            label: cameraOn ? 'Camera' : 'Camera off',
            active: cameraOn,
            onPressed: onToggleCamera,
          ),
          _ControlButton(
            key: const Key('control_switch'),
            icon: Icons.cameraswitch,
            label: 'Flip',
            active: true,
            onPressed: onSwitchCamera,
          ),
          _ControlButton(
            key: const Key('control_leave'),
            icon: Icons.call_end,
            label: 'Leave',
            active: true,
            color: Colors.red,
            onPressed: onLeave,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    super.key,
    required this.icon,
    required this.label,
    required this.active,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bg = color ?? (active ? Colors.white24 : Colors.white10);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: bg,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Icon(icon, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
