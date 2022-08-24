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
//        File Name:       FTResponseModel.swift
//        Product Name:    TEAYANGPROJECT
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/7/23 4:22 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import ObjectMapper

struct FTResponseModel: Mappable {

    var code: Int = 200
    var msg: String = ""
    var serverTime: Int32?
    var data: Any?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        serverTime <- map["serverTime"]
        data <- map["data"]
    }
}

struct FTErrorModel
{
    var code: Int?
    var errorMsg: String?
    init(code: Int, errorMsg: String) {
        self.code = code
        self.errorMsg = errorMsg
    }
}

