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
//        File Name:       HSCSNewLiveActivityModel.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/11 9:57 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import ObjectMapper

class HSCSNewLiveActivityModel: Mappable
{
    var partInNumber: Int32 = 0//参与人数
    var winNumber: Int32 = 0//获奖人数
    var awardsNumber: Int32 = 0//中奖名额
    var activityId: Int32 = 0//活动id
    var notice: String = ""//抽奖预告
    var partInContent: String = ""//参与发送文案
    var isStart: Bool = false//活动是否开启
    var isNoticeOpen: Bool = false//预告是否开启
    var leftTime: Int32 = 0//开奖剩余时间
    var isPartIn: Bool = false//当前用户是否参与
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map)
    {
        partInNumber <- map["partInNumber"]
        winNumber <- map["winNumber"]
        awardsNumber <- map["awardsNumber"]
        activityId <- map["activityId"]
        notice <- map["notice"]
        partInContent <- map["partInContent"]
        isStart <- map["isStart"]
        isNoticeOpen <- map["isNoticeOpen"]
        leftTime <- map["leftTime"]
        isPartIn <- map["isPartIn"]
    }
}


struct HSCSNewLiveActivityResultModel: Mappable
{
    var activityId: Int32 = 0//活动id
    var isChecked: Bool = false//用户是否已查看开奖结果
    var partInNumber: Int32 = 0//参与人数
    var winNumber: Int32 = 0//获奖人数
    var isPartIn: Bool = false//当前用户是否参与
    var isWin: Bool = false//是否中奖
    var nickname: String = ""//当前用户昵称
    var avatar: String = ""//当前用户头像
    var winList: [HSCSNewLiveWinListModel] = []//中奖名单
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        partInNumber <- map["partInNumber"]
        winNumber <- map["winNumber"]
        activityId <- map["activityId"]
        isPartIn <- map["isPartIn"]
        isChecked <- map["isChecked"]
        isWin <- map["isWin"]
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        winList <- map["winList"]
    }
}


struct HSCSNewLiveWinListModel: Mappable
{
    var nickname: String = ""//当前用户昵称
    var avatar: String = ""//当前用户头像
    var phone: String = ""//手机号
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        phone <- map["phone"]
    }
}

struct HSCSNewLiveRoundResultModel: Mappable
{
    var prizeName: String = ""//奖品名称
    var lotteryTime: String = ""//开奖时间
    var winList: [HSCSNewLiveWinListModel] = []//中奖名单
    var cellHeight : CGFloat {
        get {
            return HeightScale(height: 72) + CGFloat(winList.count) * HeightScale(height: 28) + HeightScale(height: 10)
        }
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        prizeName <- map["prizeName"]
        lotteryTime <- map["lotteryTime"]
        winList <- map["winList"]
    }
}
