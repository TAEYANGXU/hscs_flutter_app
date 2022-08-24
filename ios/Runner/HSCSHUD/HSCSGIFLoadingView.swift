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
//        File Name:       HSCSGIFLoadingView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/2/25 10:38 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import SnapKit

private let single = HSCSGIFLoadingView()

class HSCSGIFLoadingView: UIView
{
    @objc open class var shared: HSCSGIFLoadingView {
        return single
    }
    
    private let gifView : UIImageView = {
        let gif = UIImageView(frame: .zero)
        gif.loadGif(asset: "hud_gif_loading_icon")
        return gif
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        makeUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUpUI(){
        addSubview(gifView)
        gifView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 426*2/5, height: 135*2/5))
            make.center.equalTo(self.snp.center)
        }
    }
}
