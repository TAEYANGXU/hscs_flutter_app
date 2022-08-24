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
//        File Name:       HSCSNewLiveHeaderView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/1 10:34 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import Kingfisher

class HSCSNewLiveHeaderView: UIView {

    static let viewHeight: CGFloat = HeightScale(height: 24 + 43) + 40

    public let bgView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .init(hex: "#C1C1C1", alpha: 0.4)
        view.layer.cornerRadius = HeightScale(height: 43) / 2
        view.layer.masksToBounds = true
        return view
    }()

    private let avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = HeightScale(height: 36) / 2
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .PingFang_Medium(fontSize: 16)
        label.textColor = .white
        return label
    }()

    private let hotLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .PingFang_Regular(fontSize: 12)
        label.textColor = .white
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .PingFang_Medium(fontSize: 16)
        label.textColor = .white
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

    var liveActModel: HSCSNewLiveActModel?
    {
        didSet {
            if let model = liveActModel {
                titleLabel.text = model.actName
                nameLabel.text = model.actTeacher
                if model.teachers.count > 0 {
                    let tea = model.teachers[0]
                    nameLabel.text = tea.realName
                    let str = tea.avatar + "?imageView2/1/w/\(3 * Int(100))/h/\(3 * Int(100))/q/100"
                    avatarView.kf.setImage(with: URL(string: str), placeholder: UIImage(named: "mine_default_head_icon"), options: nil, progressBlock: nil, completionHandler: nil)
                }
            }
        }
    }
    
    var hotValue : Int32?
    {
        didSet{
            if let value = hotValue {
                hotLabel.text =  "\(value)" + "热度"
            }else{
                hotLabel.text =  "0热度"
            }
            if let model = liveActModel {
                if model.actStatus == 0 {
                    let date = Date(timeIntervalSince1970: model.startTimeStamp)
                    let dateStr =  DateFormatter.dateConverString(date: date, format: "MM-dd HH:mm")
                    hotLabel.text = dateStr
                }
            }
        }
    }

    private func makeUpUI()
    {
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.size.equalTo(CGSize(width: HeightScale(height: 137), height: HeightScale(height: 43)))
        }
        bgView.addSubview(avatarView)
        avatarView.snp.makeConstraints { (make) in
            make.left.equalTo(9)
            make.centerY.equalTo(bgView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 36), height: HeightScale(height: 36)))
        }

        bgView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarView.snp.right).offset(7.5)
            make.top.equalTo(HeightScale(height: 3))
            make.right.equalTo(-5)
            make.height.equalTo(HeightScale(height: 23))
        }

        bgView.addSubview(hotLabel)
        hotLabel.snp.makeConstraints { (make) in
            make.left.equalTo(avatarView.snp.right).offset(7.5)
            make.bottom.equalTo(-HeightScale(height: 3))
            make.right.equalTo(-5)
            make.height.equalTo(HeightScale(height: 18))
        }

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(bgView.snp.bottom).offset(10)
            make.height.equalTo(HeightScale(height: 24))
        }
    }
}
