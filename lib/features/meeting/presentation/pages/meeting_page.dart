import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/invite_codec.dart';
import '../../domain/entities/meeting_session.dart';
import '../bloc/meeting_bloc.dart';
import '../bloc/meeting_state.dart';
import '../bloc/meeting_ui_event.dart';
import '../widgets/control_bar.dart';
import '../widgets/status_chip.dart';
import '../widgets/video_tile_view.dart';
import 'event_log_page.dart';

/// In-call screen. Shows a spinner while `Joining`, then the two-way video +
/// controls once `Connected`.
class MeetingPage extends StatelessWidget {
  const MeetingPage({super.key});

  void _openLog(BuildContext context) {
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Meeting'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(child: StatusChip(status: state.status)),
          ),
          IconButton(
            tooltip: 'Event log',
            onPressed: () => _openLog(context),
            icon: const Icon(Icons.receipt_long),
          ),
        ],
      ),
      body: switch (state) {
        MeetingJoining() => const _JoiningView(),
        MeetingConnected() => _ConnectedView(state: state),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _JoiningView extends StatelessWidget {
  const _JoiningView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Connecting…', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _ConnectedView extends StatelessWidget {
  const _ConnectedView({required this.state});

  final MeetingConnected state;

  String get _inviteCode =>
      InviteCodec.encode(state.session.meeting.rawMeetingJson);

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _inviteCode));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invite code copied')),
      );
    }
  }

  Future<void> _share() async {
    await SharePlus.instance.share(
      ShareParams(text: 'Join my video call. Invite code:\n$_inviteCode'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MeetingBloc>();
    return Column(
      children: [
        if (state.session.role == MeetingRole.agent) _InviteBar(
          meetingId: state.session.meeting.meetingId,
          onCopy: () => _copy(context),
          onShare: _share,
        ),
        Expanded(
          child: Stack(
            children: [
              // Remote (or waiting) fills the screen.
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: state.remotePresent
                      ? VideoTileView(
                          tileId: state.remoteTileId,
                          label: 'Remote',
                        )
                      : const _WaitingForGuest(),
                ),
              ),
              // Local self-view as a small overlay.
              Positioned(
                right: 16,
                bottom: 16,
                width: 110,
                height: 160,
                child: VideoTileView(
                  tileId: state.cameraOn ? state.localTileId : null,
                  label: 'You',
                  mirror: state.frontCamera,
                ),
              ),
            ],
          ),
        ),
        ControlBar(
          micOn: state.micOn,
          cameraOn: state.cameraOn,
          onToggleMic: () => bloc.add(const MicToggled()),
          onToggleCamera: () => bloc.add(const CameraToggled()),
          onSwitchCamera: () => bloc.add(const CameraSwitched()),
          onLeave: () => bloc.add(const LeaveRequested()),
        ),
      ],
    );
  }
}

class _WaitingForGuest extends StatelessWidget {
  const _WaitingForGuest();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: const ColoredBox(
        color: Color(0xFF1E1E24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.hourglass_empty, color: Colors.white38, size: 40),
              SizedBox(height: 8),
              Text(
                'Waiting for the other participant…',
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InviteBar extends StatelessWidget {
  const _InviteBar({
    required this.meetingId,
    required this.onCopy,
    required this.onShare,
  });

  final String meetingId;
  final VoidCallback onCopy;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF16161C),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.vpn_key, color: Colors.white54, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Share invite code to let a guest join',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  'Meeting $meetingId',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Copy invite code',
            icon: const Icon(Icons.copy, color: Colors.white70, size: 18),
            onPressed: onCopy,
          ),
          IconButton(
            tooltip: 'Share invite code',
            icon: const Icon(Icons.share, color: Colors.white70, size: 18),
            onPressed: onShare,
          ),
        ],
      ),
    );
  }
}
