/// Abstraction over runtime camera/microphone permissions. The concrete
/// implementation (in the data layer) uses `permission_handler`; the domain and
/// bloc depend only on this port.
abstract class PermissionService {
  /// Requests camera + microphone permissions. Returns true only if both are
  /// granted.
  Future<bool> ensureCameraAndMic();

  /// Opens the OS app settings so the user can grant a denied permission.
  Future<bool> openSettings();
}
