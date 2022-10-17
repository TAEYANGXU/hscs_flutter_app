import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UINavigationControllerDelegate {

    var allowRotation: Bool = false;
    var navigationController: UINavigationController?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController

        GeneratedPluginRegistrant.register(with: self)

        self.navigationController = UINavigationController(rootViewController: flutterViewController);
        self.navigationController?.setNavigationBarHidden(true, animated: false);

        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window.rootViewController = self.navigationController;
        self.navigationController?.delegate = self
        self.window.makeKeyAndVisible();

        let channel = FlutterMethodChannel(name: "huasheng/flutter", binaryMessenger: flutterViewController.binaryMessenger)
        channel.setMethodCallHandler { call, result in
            HSPushCenter.pushAppURLPath(path: call.method, params: call.arguments as Any)
        }
        
//        if let register = self.registrar(forPlugin: "FlutterNativePlugin") {
//            FlutterNativePlugin.register(with: register)
//        }
        
        //微吼SDK
        VHallApi.registerApp("5c08f284d0e0f6d0084746bc63c1279d", secretKey: "acd2da2b734725d145ab22f09993c916")
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    //实现UINavigationControllerDelegate代理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        //如果是Flutter页面，导航栏就隐藏
        navigationController.navigationBar.isHidden = viewController.isKind(of: FlutterViewController.self)
    }

    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        if self.allowRotation { //如果设置了allowRotation属性，支持全屏
            return .allButUpsideDown;
        }
        return .portrait;//默认全局不支持横屏
    }
}
