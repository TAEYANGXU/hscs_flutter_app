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
//        File Name:       HSCSNewLiveWinListCell.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/12 10:20 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit

class HSCSNewLiveWinListCell: UITableViewCell
{
    private let  nameLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Medium(fontSize: 16), textAlignment: .left)
        label.text = "奖品名称："
        return label
    }()
    
    private let  nameValueLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Regular(fontSize: 16), textAlignment: .left)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Medium(fontSize: 16), textAlignment: .left)
        label.text = "开奖时间："
        return label
    }()
    
    private let  timeValueLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Regular(fontSize: 16), textAlignment: .left)
        return label
    }()
    
    private let winLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Medium(fontSize: 16), textAlignment: .left)
        label.text = "开奖名单："
        return label
    }()
    
    private let line : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lineBG
        return view
    }()
    
    var model:HSCSNewLiveRoundResultModel?
    {
        didSet{
            if let m = model {
                nameValueLabel.text = m.prizeName
                timeValueLabel.text = m.lotteryTime
                setUpWinUserViewList(winList: m.winList)
            }
        }
    }
    
    func setUpWinUserViewList(winList: [HSCSNewLiveWinListModel])
    {
        for view in self.subviews {
            if view.isMember(of: HSCSNewLiveWinUserView.classForCoder()) {
                view.removeFromSuperview()
            }
        }
        
        var top = HeightScale(height: 60) + 10;
        for model in winList {
            let view1 = HSCSNewLiveWinUserView(frame: CGRect(x: 15 + HeightScale(height: 82), y: top, width: SCREENWITH - HeightScale(height: 100), height: HeightScale(height: 28)))
            view1.winListModel = model
            addSubview(view1)
            top += HeightScale(height: 28)
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameValueLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(timeValueLabel)
        contentView.addSubview(winLabel)
        contentView.addSubview(line)
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.width.equalTo(HeightScale(height: 82))
            make.height.equalTo(HeightScale(height: 22))
        }
        nameValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(0)
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 300), height: HeightScale(height: 22)))
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(nameLabel.snp.bottom).offset(HeightScale(height: 8))
            make.width.equalTo(HeightScale(height: 82))
            make.height.equalTo(HeightScale(height: 22))
        }
        timeValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel.snp.right).offset(0)
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 300), height: HeightScale(height: 22)))
        }
        
        winLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(timeLabel.snp.bottom).offset(HeightScale(height: 8))
            make.width.equalTo(HeightScale(height: 82))
            make.height.equalTo(HeightScale(height: 22))
        }
        line.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }
}


class HSCSNewLiveWinUserView: UIView
{
    private let nikeNameLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Regular(fontSize: 16), textAlignment: .left)
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#2D2F3B"), font: .PingFang_Regular(fontSize: 16), textAlignment: .left)
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

    public var winListModel: HSCSNewLiveWinListModel?
    {
        didSet {
            if let model = winListModel {
                nikeNameLabel.text = model.nickname
                var mobile = model.phone
                mobile.replaceSubrange(mobile.index(mobile.startIndex, offsetBy: 3)..<mobile.index(mobile.startIndex, offsetBy: 7), with: "****")
                phoneLabel.text = mobile
            }
        }
    }

    private func makeUpUI()
    {
        addSubview(nikeNameLabel)
        addSubview(phoneLabel)
        
        nikeNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(HeightScale(height: 140))
            make.height.equalTo(36)
        }
        phoneLabel.snp.makeConstraints { (make) in
            make.width.equalTo(HeightScale(height: 160))
            make.top.equalTo(0)
            make.left.equalTo(HeightScale(height: 150))
            make.height.equalTo(36)
        }
    }
}
