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
//        File Name:       HSCSVpReviewActModel.swift
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/3/1 2:11 PM
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import ObjectMapper


struct HSCSVpReviewListModel: Mappable {

    var reviewId: Int32 = 0 //回放id
    var roomId: Int32 = 0 //房间id
    var actId: Int32 = 0 //节目id
    var reviewNum: Int32 = 0 //回放次数
    var vhallAid: Int32 = 0 //vhall视频id
    var createdAt: String = "" //创建时间
    var title: String = "" //回放标题
    var coverPic: String = "" //大封面图
    var content: String = "" //节目描述
    var createTime: String = ""
    var small_cover_pic: String = "" //小封面图
    
    var vCoverImgUrl: String = ""
    var vTitle: String = ""
    var vContent: String = ""
    var vUrl: String = "" //vhall视频id
    var vid: String = ""
    
    var index: Int = 0
    
    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
        reviewId <- map["reviewId"]
        roomId <- map["roomId"]
        actId <- map["actId"]
        reviewNum <- map["reviewNum"]
        vhallAid <- map["vhallAid"]
        createdAt <- map["createdAt"]
        title <- map["title"]
        coverPic <- map["coverPic"]
        content <- map["content"]
        createTime <- map["createTime"]
        small_cover_pic <- map["small_cover_pic"]
        
        vCoverImgUrl <- map["vCoverImgUrl"]
        vTitle <- map["vTitle"]
        vContent <- map["vContent"]
        vUrl <- map["vUrl"]
        vid <- map["vid"]
        index <- map["index"]
    }
}
