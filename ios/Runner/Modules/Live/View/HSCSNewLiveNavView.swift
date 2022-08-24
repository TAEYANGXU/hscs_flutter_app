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
//        File Name:       HSCSNewLiveNavView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/1 10:18 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxSwift
import RxCocoa

class HSCSNewLiveNavView: UIView {

    static let viewHeight: CGFloat = kNavigationBarHeight
    
    public var backBlock:(()->())?
    
    let backButon : UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "new_live_back_icon"), for: .normal)
        return button
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = .PingFang_Medium(fontSize: 17)
//        label.text = "花生服务联播"
        return label
    }()
    
    var title: String?
    {
        didSet{
            if let str = title {
                titleLabel.text = str
            }
        }
    }
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUpUI(){
        
        addSubview(backButon)
        backButon.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: HeightScale(height: 45), height: 45))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(backButon.snp.centerY)
            make.size.equalTo(CGSize(width: 250, height: 45))
        }
        
        backButon.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else{ return }
            if weakself.backBlock != nil {
                weakself.backBlock!()
            }
            weakself.viewController().navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}

class HSCSNewNavView: UIView {

    static let viewHeight: CGFloat = kNavigationBarHeight
    
    public var backBlock:(()->())?
    
    let backButon : UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "new_live_back_icon"), for: .normal)
        return button
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = .PingFang_Bold(fontSize: 17)
        return label
    }()
    
    var title: String?
    {
        didSet{
            if let str = title {
                titleLabel.text = str
            }
        }
    }
    
    var backImage: String?
    {
        didSet{
            if let str = backImage {
                backButon.setImage(UIImage(named: str), for: .normal)
            }
        }
    }
    
    var titleColor: UIColor?
    {
        didSet{
            if let color = titleColor {
                titleLabel.textColor = color
            }
        }
    }
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func makeUpUI(){
        
        addSubview(backButon)
        backButon.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: HeightScale(height: 45), height: 45))
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(backButon.snp.centerY)
            make.size.equalTo(CGSize(width: 250, height: 45))
        }
        
        backButon.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else{ return }
            if weakself.backBlock != nil {
                weakself.backBlock!()
            }
            weakself.viewController().navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
}
