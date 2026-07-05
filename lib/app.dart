import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/error/failures.dart';
import 'features/meeting/presentation/bloc/meeting_bloc.dart';
import 'features/meeting/presentation/bloc/meeting_state.dart';
import 'features/meeting/presentation/bloc/meeting_ui_event.dart';
import 'features/meeting/presentation/pages/home_page.dart';
import 'features/meeting/presentation/pages/meeting_page.dart';

class MeetingApp extends StatelessWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1:1 Video Call',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: BlocProvider<MeetingBloc>(
        create: (_) => sl<MeetingBloc>(),
        child: const _MeetingRouter(),
      ),
    );
  }
}

/// Chooses the screen from the current state and surfaces terminal failures as
/// a snackbar. The Bloc instance is shared across Home / Meeting / Event log.
class _MeetingRouter extends StatelessWidget {
  const _MeetingRouter();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeetingBloc, MeetingState>(
      listenWhen: (prev, curr) => curr is MeetingErrorState,
      listener: (context, state) {
        if (state is MeetingErrorState) {
          final isPermission = state.failure is PermissionFailure;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.failure.message),
                backgroundColor: Colors.red.shade700,
                duration: const Duration(seconds: 6),
                action: SnackBarAction(
                  label: isPermission ? 'Settings' : 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () => context.read<MeetingBloc>().add(
                        isPermission
                            ? const OpenAppSettingsRequested()
                            : const MeetingReset(),
                      ),
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        return switch (state) {
          MeetingJoining() || MeetingConnected() => const MeetingPage(),
          _ => const HomePage(),
        };
      },
    );
  }
}
