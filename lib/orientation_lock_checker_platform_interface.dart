import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'orientation_lock_checker_method_channel.dart';

abstract class OrientationStateCheckerPlatform extends PlatformInterface {
  /// Constructs a OrientationStateCheckerPlatform.
  OrientationStateCheckerPlatform() : super(token: _token);

  static final Object _token = Object();

  static OrientationStateCheckerPlatform _instance =
      MethodChannelOrientationStateChecker();

  /// The default instance of [OrientationStateCheckerPlatform] to use.
  ///
  /// Defaults to [MethodChannelOrientationStateChecker].
  static OrientationStateCheckerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OrientationStateCheckerPlatform] when
  /// they register themselves.
  static set instance(OrientationStateCheckerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Future method to check if the device orientation is locked.
  Future<bool> isDeviceOrientationStateed() {
    throw UnimplementedError(
        'isDeviceOrientationStateed() has not been implemented.');
  }

  /// Future method to set the device orientation lock status.
  Future<void> setOrientationState(bool enabled) {
    throw UnimplementedError('setOrientationState() has not been implemented.');
  }
}
