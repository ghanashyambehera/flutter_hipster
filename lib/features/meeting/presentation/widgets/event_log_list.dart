import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/meeting_event.dart';

/// Renders the append-only event log newest-first with a timestamp + type icon.
class EventLogList extends StatelessWidget {
  const EventLogList({super.key, required this.events});

  final List<MeetingEvent> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(
        child: Text('No events yet.', style: TextStyle(color: Colors.grey)),
      );
    }

    final reversed = events.reversed.toList(growable: false);
    final formatter = DateFormat('HH:mm:ss');

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: reversed.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final e = reversed[index];
        final (icon, color) = _visualFor(e.type);
        return ListTile(
          dense: true,
          leading: Icon(icon, color: color),
          title: Text(e.message),
          subtitle: Text(_labelFor(e.type)),
          trailing: Text(
            formatter.format(e.timestamp),
            style: const TextStyle(fontFeatures: [], color: Colors.grey),
          ),
        );
      },
    );
  }

  (IconData, Color) _visualFor(MeetingEventType type) {
    return switch (type) {
      MeetingEventType.meetingStarted => (Icons.play_circle, Colors.green),
      MeetingEventType.meetingEnded => (Icons.stop_circle, Colors.grey),
      MeetingEventType.participantJoined => (Icons.person_add, Colors.blue),
      MeetingEventType.participantLeft => (Icons.person_remove, Colors.orange),
      MeetingEventType.micOn => (Icons.mic, Colors.green),
      MeetingEventType.micOff => (Icons.mic_off, Colors.redAccent),
      MeetingEventType.cameraOn => (Icons.videocam, Colors.green),
      MeetingEventType.cameraOff => (Icons.videocam_off, Colors.redAccent),
      MeetingEventType.error => (Icons.error, Colors.red),
    };
  }

  String _labelFor(MeetingEventType type) => type.name;
}
