import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'orientation_lock_checker_method_channel.dart';

abstract class OrientationLockCheckerPlatform extends PlatformInterface {
  /// Constructs a OrientationLockCheckerPlatform.
  OrientationLockCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static OrientationLockCheckerPlatform _instance =
      MethodChannelOrientationLockChecker();

  /// The default instance of [OrientationLockCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelOrientationLockChecker].
  static OrientationLockCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OrientationLockCheckerPlatform] when
  /// they register themselves.
  static set instance(OrientationLockCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Future method to check if the device orientation is locked.
  Future<bool> isDeviceOrientationLocked() {
    throw UnimplementedError(
        'isDeviceOrientationLocked() has not been implemented.');
  }

  /// Future method to set the device orientation lock status.
  Future<void> setOrientationLock(bool enabled) {
    throw UnimplementedError('setOrientationLock() has not been implemented.');
  }
}
