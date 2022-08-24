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
//        File Name:       HSCSNewLiveActModel.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/8 3:17 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import ObjectMapper

struct HSCSNewLiveActModel: Mappable {

    var actName: String = "" //节目名称
    var actId: Int? //节目id
    var actTeacher: String = "" //节目id
    var actTime: String = "" //节目时间
    var startTime: String = "" //开始时间
    var endTime: String = "" //结束时间
    var roomId: Int = 0 //直播间id
    var isSub: Bool? //订阅状态
    var listCoverPic: String = "" //列表（大）封面图片
    var teachers: [HSCSNewLiveTeacherModel] = []//老师
    var actStatus: Int? //节目状态 0节目未开始 未开播，1节目开始 正在直播，3节目已经结束 观看回放，2删除
    var showAdmire: Bool? //是否展示热度
    var admireNum: String = "" //热度值
    var hotValue: String = "" //热度
    
    var startTimeStamp: TimeInterval = 0 //开始时间
    var endTimeStamp: TimeInterval = 0 //结束时间
    var vhallId: String?

    //是否有权限，1有权限0无权限
    var isPermission: Int = 0
    //房间信息
    var roomInfo: HSCSRoomInfoModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map)
    {
        actName <- map["actName"]
        actId <- map["actId"]
        actTime <- map["actTime"]
        startTime <- map["startTime"]
        endTime <- map["endTime"]
        roomId <- map["roomId"]
        isSub <- map["isSub"]
        listCoverPic <- map["listCoverPic"]
        teachers <- map["teachers"]
        actStatus <- map["actStatus"]
        showAdmire <- map["showAdmire"]
        admireNum <- map["admireNum"]
        actTeacher <- map["actTeacher"]
        startTimeStamp <- map["startTimeStamp"]
        endTimeStamp <- map["endTimeStamp"]
        vhallId <- map["vhallId"]
        hotValue <- map["hotValue"]
        isPermission <- map["isPermission"]
        roomInfo <- map["roomInfo"]
    }
}

struct HSCSRoomInfoModel: Mappable
{
    var name: String = ""
    var intro: String = ""
    var announce: String = ""
    var living: String = ""
    var id: Int32 = 0
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map)
    {
        name <- map["name"]
        intro <- map["intro"]
        announce <- map["announce"]
        living <- map["living"]
        id <- map["id"]
    }
}

struct HSCSNewLiveTeacherModel: Mappable
{
    var nickname: String = "" //昵称
    var avatar: String = ""
    var realName: String = ""
    var desc: String = "" //描述
    var uid: String = ""
    var id: Int32 = 0
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map)
    {
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        realName <- map["realName"]
        desc <- map["desc"]
        uid <- map["uid"]
        id <- map["id"]
    }
}


class HSCSNewLiveLivingModel: Mappable {

    var image: String = "" //停播状态封面图
    var announce: String = "" //直播公告
    var chief: HSCSNewLiveChiefModel? //直播间信息
    var list: [HSCSNewLiveActModel] = [] //节目列表

    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        image <- map["image"]
        announce <- map["announce"]
        chief <- map["chief"]
        list <- map["list"]
    }
}

class HSCSNewLiveChiefModel: Mappable {

    var vhallId: String = "" //直播间vhallid
    var actStatus: Int? //直播状态，0未直播，1直播中
    var roomId: String = "" //当前直播间id
    var wsRoom: String = "" //ws长链接订阅房间号
    var name: String = "" //房间名称
    var intro: String = "" //房间介绍
    var actId: Int? //最近节目id（直播中或即将播）
    var showAdmire: Bool? //是否展示点赞按钮
    var admireNum: String = "" //点赞数量
    var hotValue: String = "" //直播热度值
    var vhallIdStr: Int32 = 0 //直播间vhallid
    var h5Url: String = "" //分享
    var wxShareIcon: String = "" //分享
    
    required init?(map: Map) {

    }

    func mapping(map: Map)
    {
        vhallId <- map["vhallId"]
        actStatus <- map["actStatus"]
        roomId <- map["roomId"]
        wsRoom <- map["wsRoom"]
        name <- map["name"]
        intro <- map["intro"]
        actId <- map["actId"]
        showAdmire <- map["showAdmire"]
        admireNum <- map["admireNum"]
        hotValue <- map["hotValue"]
        vhallIdStr <- map["vhallIdStr"]
        h5Url <- map["h5Url"]
        wxShareIcon <- map["wxShareIcon"]
    }
}
