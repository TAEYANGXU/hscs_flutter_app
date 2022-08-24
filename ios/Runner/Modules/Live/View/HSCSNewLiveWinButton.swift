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
//        File Name:       HSCSNewLiveWinButton.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/12 9:46 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxSwift
import RxCocoa

class HSCSNewLiveWinButton: UIView {

    var showWinListBlock:(()->())?
    
    private let button:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .PingFang_Medium(fontSize: 15)
        btn.setTitle("查看中奖结果", for: .normal)
        return btn
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUpUI()
    {
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.size.equalTo(CGSize(width: HeightScale(height: 120), height: HeightScale(height: 38)))
        }
        button.size = CGSize(width: HeightScale(height: 120), height: HeightScale(height: 38))
        UIView.bezierPathWithRounded(stateView: button, corners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: HeightScale(height: 38)/2, height: HeightScale(height: 38)/2))
        let gradientLayer = CAGradientLayer.gradientLayerWithType(type: .LeftToRight, frame: CGRect(x: 0, y: 0, width: button.size.width, height: button.size.height), startColor: UIColor.init(hex: "#FF6A43"), endColor: .init(hex: "#F40113"))
        button.layer.insertSublayer(gradientLayer, at: 0)
        
        button.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else{ return }
            if weakself.showWinListBlock != nil {
                weakself.showWinListBlock!()
            }
        }).disposed(by: disposeBag)
    }
}
