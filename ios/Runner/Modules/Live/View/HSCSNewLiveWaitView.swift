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
//        File Name:       HSCSNewLiveWaitView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/2 1:40 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit

class HSCSNewLiveWaitView: UIView {

    private let imgIcon: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "white_app_logo")
        return view
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Regular(fontSize: 21), textAlignment: .center)
        label.text = "回放生成中，请稍后查看"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //直播状态
    var liveType : HSCSNewLiveType?
    {
        didSet{
            if let type = liveType {
                switch type {
                case .HSCSNewLiveTypeMakeBack:
                    titleLabel.text = "回放生成中，请稍后查看"
                    break
                case .HSCSNewLiveTypeNone:
                    titleLabel.text = "今天无直播节目"
                    break
                default:
                    break
                }
            }else{
                titleLabel.text = "回放生成中，请稍后查看"
            }
        }
    }
    
    private func makeUpUI()
    {
        addSubview(imgIcon)
        imgIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(70)
            make.size.equalTo(CGSize(width: HeightScale(height: 101), height: HeightScale(height: 62)))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(imgIcon.snp.bottom).offset(20)
            make.height.equalTo(HeightScale(height: 30))
        }
    }
}
