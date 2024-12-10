import 'orientation_lock_checker_platform_interface.dart';

/// Checks if the device orientation is locked.
class OrientationStateChecker {
  /// Returns true if the device orientation is locked.
  Future<bool> isDeviceOrientationLocked() {
    return OrientationStateCheckerPlatform.instance.isDeviceOrientationLocked();
  }

  /// Sets the orientation lock to the desired status.
  Future<void> setOrientationState(bool enabled) {
    return OrientationStateCheckerPlatform.instance
        .setOrientationState(enabled);
  }
}
