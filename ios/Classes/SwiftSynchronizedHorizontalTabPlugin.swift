import Flutter
import UIKit

public class SwiftSynchronizedHorizontalTabPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "synchronized_horizontal_tab", binaryMessenger: registrar.messenger())
    let instance = SwiftSynchronizedHorizontalTabPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
