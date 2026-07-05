import 'package:permission_handler/permission_handler.dart';

import '../../domain/ports/permission_service.dart';

/// `permission_handler`-backed implementation of [PermissionService].
class PermissionServiceImpl implements PermissionService {
  const PermissionServiceImpl();

  @override
  Future<bool> ensureCameraAndMic() async {
    final statuses = await [Permission.camera, Permission.microphone].request();
    return statuses.values.every((s) => s.isGranted);
  }

  @override
  Future<bool> openSettings() => openAppSettings();
}

/// A no-op permission service for the fake/demo path (used when the SDK is not
/// wired), so the flow is not blocked by platform permission prompts.
class AlwaysGrantedPermissionService implements PermissionService {
  const AlwaysGrantedPermissionService();

  @override
  Future<bool> ensureCameraAndMic() async => true;

  @override
  Future<bool> openSettings() async => true;
}
