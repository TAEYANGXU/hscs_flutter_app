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

class FlutterNativePlugin: NSObject,FlutterPlugin {

    // 实现注册函数
    @objc(registerWithRegistrar:) static func register(with registrar: FlutterPluginRegistrar) {
      // 方法的通道
      let channel = FlutterMethodChannel(name: "huasheng/flutter", binaryMessenger: registrar.messenger())
      // 创建类对象
      let plugin = FlutterNativePlugin()
      // 添加注册
      registrar.addMethodCallDelegate(plugin, channel: channel)
   }
    
    // 实现flutter调用
   func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       result("成功了")
   }
}
