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
//        File Name:       HSCSNewLiveToolView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/1 11:52 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import RxCocoa
import RxSwift

class HSCSNewLiveToolView: UIView {

    public var showTextViewBlock: (() -> ())?
    public var likeEventBlock: (() -> ())?
    public var showRecomendBlock: (() -> ())?

    static let viewHeight: CGFloat = UIDevice.isiPhoneXAll() ? HeightScale(height: 72) : HeightScale(height: 62)

    private let boxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "new_live_box_icon"), for: .normal)
        return button
    }()

    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "new_live_zan_icon"), for: .normal)
        return button
    }()

    private let likeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = .PingFang_Medium(fontSize: 12)
        label.textColor = .init(hex: "#FF4C20")
        label.backgroundColor = .white
        label.layer.cornerRadius = HeightScale(height: 15) / 2
        label.layer.masksToBounds = true
        return label
    }()

    private let textView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .init(hex: "#949494", alpha: 0.5)
        view.layer.cornerRadius = HeightScale(height: 36) / 2
        view.layer.masksToBounds = true
        return view
    }()

    private let textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "问问老师"
        label.textColor = .init(hex: "#B4B5BF")
        label.font = .PingFang_Regular(fontSize: 16)
        return label
    }()

    let disposeBag = DisposeBag()
    
    var showAdmire : Bool?
    {
        didSet{
            if let show = showAdmire {
                likeButton.isHidden = !show
                likeLabel.isHidden = !show
                textView.snp.updateConstraints { (make) in
                    make.right.equalTo(show ? (-40 - HeightScale(height: 40)) : -20)
                }
            }
        }
    }
    
    var admireNum : String?
    {
        didSet{
            if let num = admireNum {
                likeLabel.text = num
                likeLabel.isHidden = num.count > 0 ? (showAdmire! ? false : true) : true
                let w = UILabel.getWidth(title: num, font: likeLabel.font) + 10
                likeLabel.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize(width: w, height: HeightScale(height: 15)))
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUpUI()
        setUpRXEvent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeUpUI()
    {
        addSubview(boxButton)
        boxButton.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(5)
            make.size.equalTo(CGSize(width: HeightScale(height: 40), height: HeightScale(height: 40)))
        }

        addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-25)
            make.centerY.equalTo(boxButton.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 40), height: HeightScale(height: 40)))
        }
        
        addSubview(likeLabel)
        likeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(likeButton.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 36), height: HeightScale(height: 15)))
            make.top.equalTo(likeButton.snp.top).offset(36)
        }

        addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.left.equalTo(boxButton.snp.right).offset(12)
            make.right.equalTo(-40 - HeightScale(height: 40))
            make.height.equalTo(HeightScale(height: 36))
            make.centerY.equalTo(boxButton.snp.centerY)
        }

        textView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.top.bottom.equalTo(0)
        }
    }

    private func setUpRXEvent()
    {
        boxButton.rx.tap.subscribe(onNext: { [self] _ in
//            if HSCSUserInfoManager.shared().isUnlock && !AppConfig.sharedManager().inHSSH {
//                HSCSVpLocalModel.singleton.pageConfigUrl = HSCSVpLocalModel.singleton.getPageConfigUrl(type:0)
//                HSCSPushCenter.handleDeepLindUrl(DeepLink_unlock_popup, title: "")
//                return
//            }
            if showRecomendBlock != nil {
                showRecomendBlock!()
            }
        }).disposed(by: disposeBag)

        likeButton.rx.tap.subscribe(onNext: { [self]_ in
            if likeEventBlock != nil {
                likeEventBlock!()
            }
        }).disposed(by: disposeBag)

        let textTap = UITapGestureRecognizer()
        textTap.rx.event.subscribe(onNext: { [self] _ in
            if showTextViewBlock != nil {
                showTextViewBlock!()
            }
        }).disposed(by: disposeBag)
        textView.addGestureRecognizer(textTap)
    }
}
