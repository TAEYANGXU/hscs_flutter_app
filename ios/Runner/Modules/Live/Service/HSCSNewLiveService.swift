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
//        File Name:       HSCSNewLiveService.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/8 3:12 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import ObjectMapper

private let liveActURL = AppConfig.sharedManager().clientQSServer + "/v3/room/act-list"

class HSCSNewLiveService: NSObject
{
    //MARK: 获取直播节目
    /**type => 2  当日vip直播节目
     type => 5  理财周课直播间节目
     type => 3或者6  宠粉节直播间节目
     type => 4  当日推广直播节目
     type => 7 花生服务联播**/
    public class func requestHomeVideoAct(parameters: Dictionary<String, Any>, success: ((Bool, HSCSNewLiveActModel?) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/room/act-list", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                if let array: Array = model.data as? Array<Any> {
                    let list: Array<HSCSNewLiveActModel> = Mapper<HSCSNewLiveActModel>().mapArray(JSONObject: array)!
                    HSCSCacheHandle.saveResponseCache(response, forKey: liveActURL)
                    if success != nil {
                        success!(true, list.count > 0 ? list[0] : nil)
                    }
                }
            } else {
                if success != nil {
                    success!(false, nil)
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }

    public class func requestHomeVideoActCache() -> HSCSNewLiveActModel?
    {
        let response = HSCSCacheHandle.getResponseCache(forKey: liveActURL)
        if response != nil {
            let dict: Dictionary = response as! Dictionary<String, Any>
            let list: Array<HSCSNewLiveActModel> = Mapper<HSCSNewLiveActModel>().mapArray(JSONObject: dict["data"] as! Array<Any>)!
            return list.count > 0 ? list[0] : nil
        } else {
            return nil
        }
    }

    //MARK: 当前房间直播节目
    public class func requestLiveLivingList(parameters: Dictionary<String, Any>, success: ((Bool, HSCSNewLiveLivingModel?) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v2/live/living-list", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                let dict = model.data as! Dictionary<String, Any>
                let liveModel = Mapper<HSCSNewLiveLivingModel>().map(JSON: dict)
                if success != nil {
                    success!(true, liveModel)
                }
            } else {
                if success != nil {
                    success!(false, nil)
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }
    //MARK: 设置开播提醒
    public class func doLivingSub(parameters: Dictionary<String, Any>, success: ((Bool) -> ())?, failure: ((String) -> ())?)
    {
//        HSCSWealthLiveService.doSetLivingSub(parameters) { (suc) in
//            if success != nil {
//                success!(suc)
//            }
//        } failure: { (error) in
//            if success != nil {
//                success!(false)
//            }
//        }
    }

    //MARK: 历史记录
    public class func requestChatfeedsall(parameters: Dictionary<String, Any>, success: ((Bool, Array<HSCSNewLiveChatModel>, String) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v1/chat/feedsall", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                let dict = response as! Dictionary<String, Any>
                let sinceKeyOld = dict["sinceKeyOld"] as! String
                let array: Array = model.data as! Array<Any>
                let list: Array<HSCSNewLiveChatModel> = Mapper<HSCSNewLiveChatModel>().mapArray(JSONObject: array)!
                if success != nil {
                    success!(true, list, sinceKeyOld)
                }
            } else {
                if success != nil {
                    success!(false, [], "")
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }

    //聊天记录是否已存在
    public class func isExistChat(chatArray: Array<HSCSNewLiveChatModel>, model: HSCSNewLiveChatModel) -> Bool
    {
        var has: Bool = false
        for chat in chatArray {
            if chat.show?.chatId == model.show?.chatId {
                has = true
                break
            }
        }
        return has
    }

    //MARK: 用户发言
    public class func doChatPost(parameters: Dictionary<String, Any>, success: ((Bool, HSCSNewLiveChatModel?) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.post(target: FTHTTPTarget(path: "/v1/chat/post", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                let dict = model.data as! Dictionary<String, Any>
                let show = Mapper<HSCSNewLiveChatShowModel>().map(JSON: dict)
                var chat = HSCSNewLiveChatModel(JSON: ["rid": parameters["rid"] as! Int])
                chat?.show = show
                if success != nil {
                    success!(true, chat)
                }
            } else {
                if success != nil {
                    HSCSHUD.showText(model.msg)
                    success!(false, nil)
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }

    //MARK: 推荐商品列表
    public class func requestGoodsRecomendList(parameters: Dictionary<String, Any>, success: ((Bool, Array<HSCSGoodsRecomendModel>) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v2/goods/recomend-list", pararms: parameters, method: .GET, serverType: .Client)) { (model, response) in
            if model.code == 200 {
                let array: Array = model.data as! Array<Any>
                let list: Array<HSCSGoodsRecomendModel> = Mapper<HSCSGoodsRecomendModel>().mapArray(JSONObject: array)!
                if success != nil {
                    success!(true, list)
                }
            } else {
                if success != nil {
                    success!(false, [])
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }
}
