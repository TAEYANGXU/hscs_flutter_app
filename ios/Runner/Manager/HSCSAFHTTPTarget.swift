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
//        File Name:       HSCSAFHTTPTarget.swift
//        Product Name:    TEAYANGPROJECT
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/7/24 9:01 AM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import Alamofire

let infoDictionary = Bundle.main.infoDictionary
let majorVersion: String = infoDictionary!["CFBundleShortVersionString"] as! String//应用版本号
let iOSVersion: String = UIDevice.current.systemVersion as String //iOS版本
let minorVersion: String = infoDictionary!["CFBundleVersion"] as! String //版本号（内部标示）
let HSSecretKey: String = "f9d39537-a9fc-4099-ac88-b2c3105cc81d"
let QZCsecretKey: String = "663f10612c2b2a35e48a3b2e505b459a"
let QSsecretKey: String = "5f2ad63f0ef2"
let HSCSSECRETKey: String = "f9d39537-a9fc-4099-ac88-b2c3105cc81d"
let ProjectID: String = "82"

//MARK: - 当前项目有青松、花生、七指禅等服务接入、并且请求验签方式也不同
enum FTServerType
{
    case QS//青松
    case HS//花生
    case HSCS//财商
    case Client//财商
}

enum FTHTTPMethod
{
    case GET
    case POST
    case POSTBODY//参数放入body
    case UPLOAD//上传文件
}

struct FTHTTPTarget
{
    var path: String
    var pararms: Any
    var method: FTHTTPMethod
    var serverType: FTServerType
    init(path: String, pararms: [String: Any], method: FTHTTPMethod, serverType: FTServerType)
    {
        self.path = path
        self.pararms = pararms
        self.method = method
        self.serverType = serverType
    }
}

protocol FTHttpBase {

    var baseUrl: String { get }
    var headers: HTTPHeaders { get }
}

extension FTHTTPTarget: FTHttpBase
{
    var headers: HTTPHeaders
    {
        var headers = HTTPHeaders.default

        headers["Content-Type"] = "application/x-www-form-urlencoded"
        headers["Accept-Encoding"] = "gzip"
        headers["APPVER"] = majorVersion
        headers["PL"] = "iOS"
        headers["OS"] = "iOS " + iOSVersion
        headers["MODEL"] = UIDevice.current.modeName
        headers["models"] = UIDevice.current.modeNameIdentifier
        headers["buildCode"] = minorVersion
        headers["CHANNEL"] = AppConfig.sharedManager().channel
        headers["ua"] = AppConfig.sharedManager().userAgent
        
        let timestamp = String(format: "\(Int(Date.init().timeIntervalSince1970))"); let uuid = UUID().uuidString;

        if serverType == .HSCS {
            headers["CurTime"] = timestamp
            headers["TIMESTAMP"] = timestamp
            headers["Nonce"] = uuid
            headers["DEVICE"] = NSString.getUUIDByKeyChain()
            headers["token"] = AppUtils.nullEmpty(HSCSUserInfoManager.shared().userInfo.token)
            headers["DEVICETOKEN"] = AppConfig.sharedManager().deviceToken
            headers["PROJECT"] = ProjectID
            let text = String(format: "APPVER=%@&PL=%@&TIMESTAMP=%@%@", majorVersion, "iOS", timestamp, HSCSSECRETKey)
            headers["SIGN"] = text.md5()
        }
        if serverType == .HS
        {
            headers["DEVICE"] = NSString.getUUIDByKeyChain()
            headers["TIMESTAMP"] = timestamp
            let text = String(format: "APPVER=%@&PL=%@&TIMESTAMP=%@%@", majorVersion, "iOS", timestamp, HSSecretKey)
            headers["SIGN"] = text.md5()
            headers["token"] = AppUtils.nullEmpty(HSCSUserInfoManager.shared().userInfo.token)
        }
        if serverType == .Client
        {
            headers["CurTime"] = timestamp
            headers["TIMESTAMP"] = timestamp
            headers["Nonce"] = uuid
            headers["DEVICE"] = NSString.getUUIDByKeyChain()
            headers["token"] = AppUtils.nullEmpty(HSCSUserInfoManager.shared().userInfo.token)
            headers["DEVICETOKEN"] = AppConfig.sharedManager().deviceToken
            headers["PROJECT"] = ProjectID
            let text = String(format: "APPVER=%@&PL=%@&TIMESTAMP=%@%@", majorVersion, "iOS", timestamp, HSCSSECRETKey)
            headers["SIGN"] = text.md5()
        }
        return headers
    }

    var baseUrl: String
    {
        var url: String = ""
        if serverType == .HSCS
        {
            url = AppConfig.sharedManager().clientQSServer
        }
        if serverType == .HS
        {
            url = AppConfig.sharedManager().clientLanyiServer
        }
        if serverType == .Client
        {
            url = AppConfig.sharedManager().clientServer
        }
        return url
    }
}
