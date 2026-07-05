import 'package:flutter/material.dart';

import '../../domain/entities/connection_status.dart';

/// A compact indicator of the live [ConnectionStatus]. Pure function of state.
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final ConnectionStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (status) {
      ConnectionStatus.idle => ('Idle', Colors.blueGrey, Icons.circle_outlined),
      ConnectionStatus.joining => ('Joining…', Colors.orange, Icons.sync),
      ConnectionStatus.connected => ('Connected', Colors.green, Icons.videocam),
      ConnectionStatus.disconnected =>
        ('Disconnected', Colors.grey, Icons.videocam_off),
      ConnectionStatus.error => ('Error', Colors.red, Icons.error_outline),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
