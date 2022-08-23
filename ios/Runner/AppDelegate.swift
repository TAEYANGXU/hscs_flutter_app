import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        if let register = self.registrar(forPlugin: "FlutterNativePlugin") {
            FlutterNativePlugin.register(with: register)
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
