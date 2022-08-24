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
//        File Name:       HSCSNewLiveLotterySerice.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/11 3:22 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import ObjectMapper

class HSCSNewLiveLotterySerice: NSObject {

    //MARK: 活动信息
    public class func requestLotteryInfo(parameters: Dictionary<String, Any>, success: ((Bool, HSCSNewLiveActivityModel?) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/lottery/info", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                if let dict = model.data as? Dictionary<String,Any> {
                    let activityModel = Mapper<HSCSNewLiveActivityModel>().map(JSON: dict)
                    if success != nil {
                        success!(true,activityModel)
                    }
                }else{
                    if success != nil {
                        success!(true,nil)
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
    
    
    //MARK: 用户参与抽奖
    public class func requestLotteryPartIn(parameters: Dictionary<String, Any>, success: ((Bool, Bool, Int32) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/lottery/part-in", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                let dict = model.data as! Dictionary<String,Any>
                let isPartIn = dict["isPartIn"] as! Bool
                let partInNumber = dict["partInNumber"] as! Int32
                
                if success != nil {
                    success!(true,isPartIn,partInNumber)
                }
            } else {
                if success != nil {
                    success!(false, false,0)
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }
    
    //MARK: 最近一次抽奖结果
    public class func requestLotteryLastResult(parameters: Dictionary<String, Any>, success: ((Bool, HSCSNewLiveActivityResultModel?) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/lottery/last-result", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                if let dict = model.data as? Dictionary<String,Any> {
                    let resultModel = Mapper<HSCSNewLiveActivityResultModel>().map(JSON: dict)
                    if success != nil {
                        success!(true,resultModel)
                    }
                }else{
                    if success != nil {
                        success!(true,nil)
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
    
    //MARK: 触发抽奖计算
    public class func requestLotteryTriggerRandom(parameters: Dictionary<String, Any>, success: ((Bool) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/lottery/trigger-random", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                if success != nil {
                    success!(true)
                }
            } else {
                if success != nil {
                    success!(false)
                }
            }
        } failure: { (error) in
            if failure != nil {
                failure!(error.errorMsg!)
            }
        }
    }
    
    
    //MARK: 直播间所有中奖名单
    public class func requestLotteryRoundResult(parameters: Dictionary<String, Any>, success: ((Bool, [HSCSNewLiveRoundResultModel]) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/lottery/round-result", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                if let array: Array = model.data as? Array<Any> {
                    let list: Array<HSCSNewLiveRoundResultModel> = Mapper<HSCSNewLiveRoundResultModel>().mapArray(JSONObject: array)!
                    if success != nil {
                        success!(true,list)
                    }
                }else{
                    if success != nil {
                        success!(true,[])
                    }
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
