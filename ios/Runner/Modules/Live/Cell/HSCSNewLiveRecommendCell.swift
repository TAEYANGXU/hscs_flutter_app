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
//        File Name:       HSCSNewLiveRecommendCell.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/12 3:04 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

class HSCSNewLiveRecommendCell: UITableViewCell {

    public var openWechat:((Any) -> ())?
    
    private let imageV : UIImageView = {
        let view  = UIImageView(frame: .zero)
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Medium(fontSize: 16), textAlignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    private let validLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .pingFangSCRegular(14), textAlignment: .left)
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#EC7331"), font: .PingFang_Bold(fontSize: 21), textAlignment: .left)
        return label
    }()
    
    private let buyButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("咨询理财管家", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 4
        btn.titleLabel?.font = .PingFang_Medium(fontSize: 14)
        btn.layer.masksToBounds = true
        return btn
    }()
    
    private let iconV : UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.image = UIImage(named: "new_live_tag_icon")
        return icon
    }()
    
    private let botLine : UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .lineBG
        return line
    }()
    
    private let disposeBag = DisposeBag()
    
    var recomendModel : HSCSGoodsRecomendModel?
    {
        didSet{
            if let model = recomendModel {
                let image = UIImage.placeholderImage(bgColor: .init(hex: "#E6E6E6"), image: UIImage(named: "white_app_logo")!, size: CGSize(width: HeightScale(height: 106), height: HeightScale(height: 106)), iconSize: CGSize(width: HeightScale(height: 101) / 3, height: HeightScale(height: 62) / 3))
                let str = model.goodsImg + "?imageView2/1/w/\(Int(HeightScale(height: 106*3)))/h/\(Int(HeightScale(height: 106*3)))/q/100"
                imageV.kf.setImage(with: URL(string: str), placeholder: image, options: nil, progressBlock: nil, completionHandler: nil)
                titleLabel.text = model.name
                validLabel.text = "有效期：\(model.days) 天"
                validLabel.isHidden = true
                priceLabel.text = String(format: "¥%0.2f", model.price)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeUpUI()
    {
        buyButton.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else{ return }
            if weakself.openWechat != nil {
                weakself.openWechat!(0)
            }
        }).disposed(by: disposeBag)
        
        contentView.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 106), height: HeightScale(height: 106)))
        }
        contentView.addSubview(botLine)
        botLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(1)
            make.width.equalTo(SCREENWITH)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.top).offset(0)
            make.left.equalTo(imageV.snp.right).offset(UIDevice.isiPhoneXAll() ? 11 : 5)
            make.right.equalTo(-15)
            make.height.equalTo(HeightScale(height: 50))
        }
        contentView.addSubview(validLabel)
        validLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageV.snp.centerY)
            make.left.equalTo(imageV.snp.right).offset(11)
            make.right.equalTo(-15)
            make.height.equalTo(HeightScale(height: 22))
        }
        contentView.addSubview(iconV)
        iconV.snp.makeConstraints { (make) in
            make.left.equalTo(imageV.snp.right).offset(UIDevice.isiPhoneXAll() ? 11 : 5)
            make.bottom.equalTo(imageV.snp.bottom).offset(-2)
            make.size.equalTo(CGSize(width: HeightScale(height: 21), height: HeightScale(height: 23)))
        }
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconV.snp.right).offset(8)
            make.centerY.equalTo(iconV.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 120), height: HeightScale(height: 30)))
        }
        contentView.addSubview(buyButton)
        buyButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(iconV.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 100), height: HeightScale(height: 35)))
        }
        buyButton.size = CGSize(width: HeightScale(height: 102), height: HeightScale(height: 35))
        let Layer = CAGradientLayer.gradientLayerWithType(type: .LeftToRight, frame: CGRect(x: 0, y: 0, width: buyButton.size.width, height: buyButton.size.height), colors: [.init(hex: "#FFAB1A"),.init(hex: "#FC830B"),.init(hex: "#FA6A02")])
        buyButton.layer.insertSublayer(Layer, at: 0)
    }
}
