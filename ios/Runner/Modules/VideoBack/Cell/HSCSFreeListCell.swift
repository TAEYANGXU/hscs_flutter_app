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
//        File Name:       HSCSFreeListCell.swift
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/10/17 14:03
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit

class HSCSFreeListCell: UITableViewCell {

    static public let cellHeight: CGFloat = HeightScale(height: 110)
    
    private let coverView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let playIconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "icon_free_play")
        return view
    }()
    
    private let vTitleLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#373737"), font: .PingFang_Bold(fontSize: 15), textAlignment: .left)
        label.numberOfLines = 2
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#9F9F9F"), font: .PingFang_Light(fontSize: 12), textAlignment: .left)
        return label
    }()
    
    
    var reviewModel: HSCSVpReviewListModel?
    {
        didSet{
            if let model = reviewModel {
                let image = UIImage.placeholderImage(bgColor: .init(hex: "#E6E6E6"), image: UIImage(named: "white_app_logo")!, size: CGSize(width: HeightScale(height: 113), height: HeightScale(height: 75)), iconSize: CGSize(width: HeightScale(height: 101) / 3, height: HeightScale(height: 62) / 3))
                let str = model.vCoverImgUrl + "?imageView2/1/w/\(Int(HeightScale(height: 113*3)))/h/\(Int(HeightScale(height: 75*3)))/q/100"
                coverView.kf.setImage(with: URL(string: str), placeholder: image, options: nil, progressBlock: nil) { (image, error, type, url) in
                }
                vTitleLabel.text = model.vTitle
                contentLabel.text = model.vContent
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI()
    {
        
        coverView.backgroundColor = .vcbg
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 113), height: HeightScale(height: 75)))
        }
        coverView.addSubview(playIconView)
        playIconView.snp.makeConstraints { make in
            make.centerY.equalTo(coverView.snp.centerY)
            make.centerX.equalTo(coverView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 20), height: HeightScale(height: 20)))
        }
        
        contentView.addSubview(vTitleLabel)
        contentView.addSubview(contentLabel)
        
        vTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(coverView.snp.right).offset(12)
            make.top.equalTo(coverView.snp.top).offset(5)
            make.right.equalTo(-15)
            make.height.equalTo(HeightScale(height: 50))
        }
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(coverView.snp.right).offset(12)
            make.bottom.equalTo(coverView.snp.bottom).offset(-5)
            make.right.equalTo(-15)
            make.height.equalTo(HeightScale(height: 20))
        }
    }
}
