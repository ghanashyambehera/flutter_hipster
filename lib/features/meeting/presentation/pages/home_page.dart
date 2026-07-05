import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/meeting_bloc.dart';
import '../bloc/meeting_state.dart';
import '../bloc/meeting_ui_event.dart';
import '../widgets/status_chip.dart';
import 'event_log_page.dart';

/// Start screen: create a meeting (Host) or join one by id (Guest).
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _meetingIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _meetingIdController.dispose();
    super.dispose();
  }

  void _openLog() {
    final bloc = context.read<MeetingBloc>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(value: bloc, child: const EventLogPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<MeetingBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('1:1 Video Call'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(child: StatusChip(status: state.status)),
          ),
          IconButton(
            tooltip: 'Event log',
            onPressed: _openLog,
            icon: const Icon(Icons.receipt_long),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.duo, size: 72, color: Colors.indigo),
            const SizedBox(height: 24),
            Text(
              'Start a call',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              key: const Key('create_meeting_button'),
              onPressed: () =>
                  context.read<MeetingBloc>().add(const CreateMeetingRequested()),
              icon: const Icon(Icons.add_call),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Create meeting (Host)'),
              ),
            ),
            const SizedBox(height: 32),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: TextFormField(
                key: const Key('meeting_id_field'),
                controller: _meetingIdController,
                decoration: const InputDecoration(
                  labelText: 'Invite code',
                  hintText: 'Paste the invite code shared by the host',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.vpn_key),
                ),
                minLines: 1,
                maxLines: 3,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter an invite code' : null,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              key: const Key('join_meeting_button'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  context
                      .read<MeetingBloc>()
                      .add(JoinMeetingRequested(_meetingIdController.text));
                }
              },
              icon: const Icon(Icons.login),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Join meeting (Guest)'),
              ),
            ),
            if (state is MeetingErrorState) ...[
              const SizedBox(height: 24),
              _ErrorBanner(message: state.failure.message),
            ],
          ],
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
