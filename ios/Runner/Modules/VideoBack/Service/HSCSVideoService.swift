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
//        File Name:       HSCSVideoService.swift
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/10/17 14:14
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import ObjectMapper

class HSCSVideoService: NSObject {
    //MARK: 免费课
    public class func requestVideoListByType(parameters: Dictionary<String, Any>, success: ((Bool, Array<HSCSVpReviewListModel>) -> ())?, failure: ((String) -> ())?)
    {
        HSCSAFHTTPSessionManager.shared.get(target: FTHTTPTarget(path: "/v3/video/list-by-act-type", pararms: parameters, method: .GET, serverType: .HSCS)) { (model, response) in
            if model.code == 200 {
                let dict = response as! Dictionary<String, Any>
                let data = model.data as! Dictionary<String, Any>
                let list: Array<HSCSVpReviewListModel> = Mapper<HSCSVpReviewListModel>().mapArray(JSONObject: data["list"])!
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
