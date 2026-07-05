import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/meeting/data/datasources/chime_android_bridge.dart';
import '../../features/meeting/data/datasources/fake_rtc_client.dart';
import '../../features/meeting/data/datasources/meeting_api_client.dart';
import '../../features/meeting/data/datasources/permission_service_impl.dart';
import '../../features/meeting/data/repositories/meeting_repository_impl.dart';
import '../../features/meeting/domain/ports/meeting_repository.dart';
import '../../features/meeting/domain/ports/permission_service.dart';
import '../../features/meeting/domain/ports/rtc_client.dart';
import '../../features/meeting/domain/usecases/create_meeting.dart';
import '../../features/meeting/domain/usecases/join_meeting.dart';
import '../../features/meeting/presentation/bloc/meeting_bloc.dart';
import '../config/app_config.dart';
import '../utils/app_logger.dart';

final GetIt sl = GetIt.instance;

/// Manual composition root. `RtcClient`/`PermissionService` are bound based on
/// the runtime `USE_FAKE_RTC` dart-define, which is why we register explicitly
/// rather than using compile-time DI codegen.
void configureDependencies(AppConfig config) {
  sl
    ..registerSingleton<AppConfig>(config)
    ..registerLazySingleton<AppLogger>(() => const AppLogger());

  // Networking
  sl.registerLazySingleton<Dio>(() {
    return Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        headers: {
          'x-api-key': config.apiKey,
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
  });

  sl.registerLazySingleton<MeetingApiClient>(
    () => MeetingApiClient(dio: sl<Dio>()),
  );

  // Repository + use cases
  sl.registerLazySingleton<MeetingRepository>(
    () => MeetingRepositoryImpl(sl<MeetingApiClient>()),
  );
  sl.registerLazySingleton<CreateMeeting>(() => CreateMeeting(sl<MeetingRepository>()));
  sl.registerLazySingleton<JoinMeeting>(() => JoinMeeting(sl<MeetingRepository>()));

  // Real-time client + permissions (runtime-selected)
  if (config.useFakeRtc) {
    sl.registerLazySingleton<RtcClient>(() => FakeRtcClient());
    sl.registerLazySingleton<PermissionService>(
      () => const AlwaysGrantedPermissionService(),
    );
  } else {
    sl.registerLazySingleton<RtcClient>(() => ChimeAndroidBridge());
    sl.registerLazySingleton<PermissionService>(
      () => const PermissionServiceImpl(),
    );
  }

  // Bloc (new instance per screen mount)
  sl.registerFactory<MeetingBloc>(
    () => MeetingBloc(
      createMeeting: sl<CreateMeeting>(),
      joinMeeting: sl<JoinMeeting>(),
      rtcClient: sl<RtcClient>(),
      permissionService: sl<PermissionService>(),
      logger: sl<AppLogger>(),
    ),
  );
}
