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
//        File Name:       HSCSGoodsRecomendModel.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/14 11:17 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import ObjectMapper

struct HSCSGoodsRecomendModel: Mappable {
    var name: String = ""
    var goodsImg: String = ""
    var days: Int16 = 0
    var price: Double = 0
    var h5Link: String = ""
    var appLink: String = ""
    var goodId: String = ""

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        goodsImg <- map["goodsImg"]
        days <- map["days"]
        price <- map["price"]
        h5Link <- map["h5Link"]
        appLink <- map["appLink"]
        goodId <- map["goodId"]
    }
}
