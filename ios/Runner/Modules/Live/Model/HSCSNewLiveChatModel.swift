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
//        File Name:       HSCSNewLiveChatModel.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/9 3:36 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import ObjectMapper
import YYText

struct HSCSNewLiveChatModel: Mappable {

    var feedId: Int32 = 0
    var roomId: Int32 = 0
    var oid: Int = 0
    var type: Int = 0
    var show: HSCSNewLiveChatShowModel?
    var cellHeight: CGFloat = 0

    public static func getCellHeight(contentAtt: NSMutableAttributedString) -> CGFloat
    {
        var height: CGFloat = 10
        let layout = YYTextLayout(containerSize: CGSize(width: HSCSNewLiveChatCell.textWidth, height: 9999), text: contentAtt)
        let textHeight = layout!.textBoundingSize.height + 5
        height += textHeight
//        let lines : Int = Int(textHeight/HSCSNewLiveChatCell.lineHeight)//只有一行 宽度自适应
        return height + 5
    }

    var contentAttr: NSMutableAttributedString
    {
        get {
            let contentAtt = NSMutableAttributedString()

            if let reply = show?.replyUserInfo {
//                reply.isTeacher = true
//                reply.title = "理财规划师"
                if let user = show?.user {
                    let nameAtt = NSMutableAttributedString(string: user.nickname)
                    nameAtt.yy_color = user.isTeacher! ? .init(hex: "#FFA819") : .init(hex: "#86C4FF")
                    nameAtt.yy_font = .PingFang_Regular(fontSize: 14)
                    contentAtt.append(nameAtt)
                    if user.isTeacher! {
                        let tagAtt = NSMutableAttributedString.addTag(tag: user.title)
                        contentAtt.append(tagAtt)
                    }
                }

                let repAtt = NSMutableAttributedString(string: " 回复")
                repAtt.yy_color = .white
                repAtt.yy_font = .PingFang_Regular(fontSize: 14)
                contentAtt.append(repAtt)

                let replyNameAtt = NSMutableAttributedString(string: reply.nickname)
                replyNameAtt.yy_color = reply.isTeacher! ? .init(hex: "#FFA819") : .init(hex: "#86C4FF")
                replyNameAtt.yy_font = .PingFang_Regular(fontSize: 14)
                contentAtt.append(replyNameAtt)

                if reply.isTeacher! {
                    let tagAtt = NSMutableAttributedString.addTag(tag: reply.title)
                    contentAtt.append(tagAtt)
                }

                guard let showModel = show else {
                    return contentAtt
                }

                let textAtt = NSMutableAttributedString(string: "：" + showModel.content)
                textAtt.yy_color = .white
                textAtt.yy_font = .PingFang_Regular(fontSize: 14)
                contentAtt.append(textAtt)

            } else {
                if let user = show?.user {
                    let nameAtt = NSMutableAttributedString(string: user.nickname)
                    nameAtt.yy_color = user.isTeacher! ? .init(hex: "#FFA819") : .init(hex: "#86C4FF")
                    nameAtt.yy_font = .PingFang_Regular(fontSize: 14)
                    contentAtt.append(nameAtt)
                    if user.isTeacher! {
                        let tagAtt = NSMutableAttributedString.addTag(tag: user.title)
                        contentAtt.append(tagAtt)
                    }
                }
                guard let showModel = show else {
                    return contentAtt
                }
                let textAtt = NSMutableAttributedString(string: "：" + showModel.content)
                textAtt.yy_color = .white
                textAtt.yy_font = .PingFang_Regular(fontSize: 14)
                contentAtt.append(textAtt)
            }
            return contentAtt
        }
    }

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        feedId <- map["feedId"]
        roomId <- map["roomId"]
        oid <- map["oid"]
        type <- map["type"]
        show <- map["show"]
    }
}

struct HSCSNewLiveChatShowModel: Mappable {

    var content: String = ""
    var chatId: Int32 = 0
    var roomId: Int16 = 0
    var ctime: String = ""
    var zmtime: String = ""
    var replyId: Int32 = 0
    var replyContent: String = ""

    var user: HSCSNewLiveChatUserModel?
    var replyUserInfo: HSCSNewLiveChatUserModel?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        content <- map["content"]
        chatId <- map["chatId"]
        roomId <- map["roomId"]
        ctime <- map["ctime"]
        zmtime <- map["zmtime"]
        replyId <- map["replyId"]
        replyContent <- map["replyContent"]
        user <- map["user"]
        replyUserInfo <- map["replyUserInfo"]
    }
}

struct HSCSNewLiveChatUserModel: Mappable {

    var uid: Int32 = 0
    var isTeacher: Bool?
    var title: String = ""
    var nickname: String = ""
    var avatar: String = ""
    var role: Int16 = 0
    var roleDes: String = ""

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        uid <- map["uid"]
        isTeacher <- map["isTeacher"]
        title <- map["title"]
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        role <- map["role"]
        roleDes <- map["roleDes"]
    }
}
