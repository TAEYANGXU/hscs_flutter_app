//
//                         __   _,--="=--,_   __
//                        /  \."    .-.    "./  \
//                       /  ,/  _   : :   _  \/` \
//                       \  `| /o\  :_:  /o\ |\__/
//                        `-'| :="~` _ `~"=: |
//                           \`     (_)     `/
//                    .-"-.   \      |      /   .-"-.
//.------------------{     }--|  /,.-'-.,\  |--{     }-----------------.
// )                 (_)_)_)  \_/`~-===-~`\_/  (_(_(_)                (
//
//        File Name:       FlutterNativePlugin.swift
//        Product Name:    Runner
//        Author:          yanzhangxu@
//        Swift Version:   5.0
//        Created Date:    2022/8/23 3:24 PM
//
//        Copyright © 2022 .
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import Flutter
import YYModel

class FlutterNativePlugin: NSObject, FlutterPlugin {

    // 实现注册函数
    @objc(registerWithRegistrar:) static func register(with registrar: FlutterPluginRegistrar) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let nav : UINavigationController = appDelegate.window.rootViewController as! UINavigationController
        let controller = nav.visibleViewController as! FlutterViewController
        // 方法的通道
        let channel = FlutterMethodChannel(name: "huasheng/flutter", binaryMessenger: controller.binaryMessenger)
        // 创建类对象
        let plugin = FlutterNativePlugin()
        // 添加注册
        registrar.addMethodCallDelegate(plugin, channel: channel)
    }

    // 实现flutter调用
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

        if call.method == "lyitp://diqiu/live_video" {
            let dict: Dictionary = call.arguments as! Dictionary<String, Any>
            let roomId = dict["roomId"] as! Int
//           result("roomId \(roomId)")
//            HSPushCenter.pushAppURLPath(path: call.method, params: dict)
        }
        if call.method == "lyitp://diqiu/userInfo" {
            if let userInfo = HSCSUserInfoModel.yy_model(withJSON: call.arguments as Any) {
                print("userInfo2 = \(userInfo)");
                HSCSUserInfoManager.shared().saveUserInfo(userInfo)
                print("username = \(HSCSUserInfoManager.shared().userInfo.nickname)");
            }
        }
        result("成功\(call.method)")
    }
}


class HSPushCenter {

    static func pushAppURLPath(path: String, params: Any) {
        if path == "lyitp://diqiu/live_video" {
            let dict: Dictionary = params as! Dictionary<String, Any>
            let roomId = dict["roomId"] as! Int
            let liveVC = HSCSNewLiveViewController()
            liveVC.roomId = roomId
            print("token = \(HSCSUserInfoManager.shared().userInfo.token)")
            UIViewController.currentViewController()?.navigationController?.pushViewController(liveVC, animated: true)
        }
        if path == "lyitp://diqiu/userInfo" {
//            let dict: Dictionary = params as! Dictionary<String, Any>
//            print("userInfo2 = \(dict)");
            if let userInfo = HSCSUserInfoModel.yy_model(withJSON: params as Any) {
                
                HSCSUserInfoManager.shared().saveUserInfo(userInfo)
                print("username = \(HSCSUserInfoManager.shared().userInfo.nickname)");
            }
        }
    }
}