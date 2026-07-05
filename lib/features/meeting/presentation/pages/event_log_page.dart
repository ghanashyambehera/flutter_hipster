import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/meeting_bloc.dart';
import '../bloc/meeting_state.dart';
import '../widgets/event_log_list.dart';

/// Full-screen view of the session event log (newest first).
class EventLogPage extends StatelessWidget {
  const EventLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Log')),
      body: BlocBuilder<MeetingBloc, MeetingState>(
        builder: (context, state) => EventLogList(events: state.log),
      ),
    );
  }
}
