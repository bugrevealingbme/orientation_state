import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'orientation_lock_checker_platform_interface.dart';

/// An implementation of [OrientationStateCheckerPlatform] that uses method channels.
class MethodChannelOrientationStateChecker
    extends OrientationStateCheckerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('orientation_state');

  @override
  Future<bool> isDeviceOrientationLocked() async {
    try {
      final bool? value =
          await methodChannel.invokeMethod<bool>('isDeviceOrientationLocked');
      return value ?? false;
    } on PlatformException catch (e) {
      // Error handling for any issues that arise while invoking the method
      log('Error checking orientation lock status: ${e.message}');
      return false;
    }
  }

  @override
  Future<void> setOrientationState(bool enabled) async {
    try {
      await methodChannel
          .invokeMethod('setOrientationState', {'enabled': enabled});
    } on PlatformException catch (e) {
      log('Error setting orientation lock: ${e.message}');
    }
  }
}
