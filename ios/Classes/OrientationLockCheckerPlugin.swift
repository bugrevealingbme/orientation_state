import Flutter
import UIKit

public class OrientationStateCheckerPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "orientation_state", binaryMessenger: registrar.messenger())
        let instance = OrientationStateCheckerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isDeviceOrientationLocked":
            result(getScreenOrientationStateStatus())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func getScreenOrientationStateStatus() -> Bool {
        let device = UIDevice.current
        return device.orientation.isPortrait
    }
}
