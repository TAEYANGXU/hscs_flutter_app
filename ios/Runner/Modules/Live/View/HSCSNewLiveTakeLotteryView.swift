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
//        File Name:       HSCSNewLiveTakeLotteryView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/9 3:40 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import RxSwift
import RxCocoa

class HSCSNewLiveLotteryButton: UIButton
{
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.size.width - HeightScale(height: 7), y: (contentRect.size.height - HeightScale(height: 12)) / 2, width: HeightScale(height: 7), height: HeightScale(height: 12))
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: contentRect.size.height / 2 - HeightScale(height: 20) / 2, width: contentRect.size.width - HeightScale(height: 7), height: HeightScale(height: 20))
    }
}

class HSCSNewLiveTakeLotteryView: UIView
{
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 3
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = false
        return contentView
    }()

    private let closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "new_live_lottery_close"), for: .normal)
        return btn
    }()

    //未参加
    private let unTakeView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_lottery_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    private let unTakeTitleLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#CA8F52"), font: .PingFang_Medium(fontSize: 20), textAlignment: .center)
        label.numberOfLines = 2
        return label
    }()
    private let unTakeTimeLb: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 14), textAlignment: .center)
        return label
    }()
    private let takeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("参与抽奖", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .PingFang_Medium(fontSize: 17)
        btn.layer.cornerRadius = HeightScale(height: 42) / 2
        btn.layer.masksToBounds = true
        return btn
    }()
    private let topIcon: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_lottery_top_icon")
        return view
    }()

    //已参加
    private let takeLotteryLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#FA6D06"), font: .PingFang_Medium(fontSize: 17), textAlignment: .center)
        label.text = "已参与抽奖"
        return label
    }()

    private let lotteryTipsLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#CA8F52"), font: .PingFang_Regular(fontSize: 12), textAlignment: .center)
        label.text = "抽奖发起及内容由主播自行决定并承担责任"
        label.isHidden = true
        return label
    }()

    //已中奖
    private let lotteryView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_has_lottery_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    private let lotteryTitleLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#A86C2E"), font: .PingFang_Bold(fontSize: 24), textAlignment: .center)
        label.text = "恭喜中奖"
        return label
    }()
    private let nikeNameLb: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 14), textAlignment: .center)
//        label.text = HSCSUserInfoManager.shared().userInfo.nickname
        return label
    }()
    private let redeemLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#FA6D06"), font: .PingFang_Medium(fontSize: 17), textAlignment: .center)
//        label.text = "请私信主播兑奖"
//        label.text = HSCSUserInfoManager.shared().isVp ? "请联系理财管家兑奖" : "请联系宣老师助手兑奖"
        return label
    }()
    private let top2Icon: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_lottery_top2_icon")
        return view
    }()
    private let avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    private let lotteryListButton: HSCSNewLiveLotteryButton = {
        let btn = HSCSNewLiveLotteryButton(type: .custom)
        btn.setImage(UIImage(named: "new_live_lottery_arrown_icon"), for: .normal)
        btn.setTitleColor(.text, for: .normal)
        btn.titleLabel?.font = .PingFang_Regular(fontSize: 13)
        return btn
    }()
    //未中奖
    private let unLotteryView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_lottery_bg")
        view.isUserInteractionEnabled = true
        return view
    }()
    private let unLotteryTitleLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#A86C2E"), font: .PingFang_Bold(fontSize: 24), textAlignment: .center)
        label.text = "很遗憾，你未中奖"
        return label
    }()
    private let unLotteryIcon: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_unlottery_icon")
        view.isUserInteractionEnabled = true
        return view
    }()
    private let unlotteryListButton: HSCSNewLiveLotteryButton = {
        let btn = HSCSNewLiveLotteryButton(type: .custom)
        btn.setImage(UIImage(named: "new_live_lottery_arrown_icon"), for: .normal)
        btn.setTitleColor(.text, for: .normal)
        btn.titleLabel?.font = .PingFang_Regular(fontSize: 13)
        return btn
    }()

    //中奖记录
    private let lotteryListView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_lottery_bg")
        view.isUserInteractionEnabled = true
        return view
    }()

    private let backButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "new_live_lottery_back_icon"), for: .normal)
        return btn
    }()

    private let listTitleLabel: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Medium(fontSize: 15), textAlignment: .center)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 12), textAlignment: .center)
        label.isHidden = true
        return label
    }()

    private let lotteryScrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .clear
        view.contentSize = CGSize(width: HeightScale(height: 300 - 20), height: HeightScale(height: 310) - HeightScale(height: 75))
        return view
    }()


    private var popTag: Int = 1

    private let disposeBag = DisposeBag()

    private var timer: Timer?

    public var seconds: TimeInterval = 0
    {
        didSet {
            if seconds > 0 {
                timeText(secondss: Int32(seconds))
                initTimer()
            }
        }
    }

    //抽奖信息
    public var activityModel: HSCSNewLiveActivityModel?
    {
        didSet {
            lotteryView.isHidden = true
            top2Icon.isHidden = lotteryView.isHidden
            lotteryView.size = contentView.size
            takeLotteryLb.isHidden = true
            unLotteryView.isHidden = true
            lotteryListView.isHidden = true
            if let model = activityModel {
                unTakeView.isHidden = false
//                self.seconds = TimeInterval(model.leftTime)
                unTakeTitleLb.text = "参与聊天可抽奖，共\(model.awardsNumber)个中奖名额"
                self.takeButton.isHidden = model.isPartIn
                self.takeLotteryLb.isHidden = !model.isPartIn
            }
        }
    }

    //抽奖结果
    public var activityResultModel: HSCSNewLiveActivityResultModel?
    {
        didSet {
            if let model = activityResultModel {
                unTakeView.isHidden = true
                unLotteryView.isHidden = true
                lotteryListView.isHidden = true
                lotteryView.isHidden = true
                top2Icon.isHidden = lotteryView.isHidden
                lotteryView.size = contentView.size
                if model.isWin {
                    //中奖
                    lotteryView.isHidden = false
                    top2Icon.isHidden = lotteryView.isHidden
                    lotteryView.size = contentView.size
                } else {
                    //未中奖
                    unLotteryView.isHidden = false
                }

                listTitleLabel.text = "\(model.winNumber)人中奖"
                subTitleLabel.text = "共\(model.partInNumber)人参与"
                lotteryListButton.setTitle("\(model.winNumber)人中奖", for: .normal)
                unlotteryListButton.setTitle("\(model.winNumber)人中奖", for: .normal)
                let width: CGFloat = UILabel.getWidth(title: "\(model.winNumber)人中奖", font: .PingFang_Regular(fontSize: 13)) + 12
                lotteryListButton.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize(width: width, height: HeightScale(height: 20)))
                }
                unlotteryListButton.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize(width: width, height: HeightScale(height: 20)))
                }

                //中奖列表
                createLotteryList(winList: model.winList)
            }
        }
    }

    //抽奖结束
    public var startLotteryBlock: (() -> ())?
    //参与抽奖
    public var takeLotteryBlock: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(hex: "#000000", alpha: 0.3)
        makeUpUI()
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createLotteryList(winList: [HSCSNewLiveWinListModel])
    {
        for view in lotteryScrollView.subviews {
            if view.isKind(of: HSCSLotteryInfoView.classForCoder()) {
                view.removeFromSuperview()
            }
        }
        
        var top: CGFloat = 0
        for (_, model) in winList.enumerated() {
            let view = HSCSLotteryInfoView(frame: CGRect(x: 0, y: top, width: HeightScale(height: 300 - 20), height: HeightScale(height: 36)))
            view.winListModel = model
            lotteryScrollView.addSubview(view)
            top += HeightScale(height: 36)
        }
        lotteryScrollView.contentSize = CGSize(width: HeightScale(height: 300 - 20), height: CGFloat(winList.count) * HeightScale(height: 36))
    }

    func makeUpUI()
    {
        backgroundColor = UIColor.init(hex: "#000000", alpha: 0.1)
        addSubview(contentView)
        addSubview(closeBtn)

        contentView.addSubview(unTakeView)
        unTakeView.addSubview(topIcon)
        unTakeView.addSubview(unTakeTitleLb)
        unTakeView.addSubview(unTakeTimeLb)
        unTakeView.addSubview(takeButton)
        unTakeView.addSubview(takeLotteryLb)
        unTakeView.addSubview(lotteryTipsLb)

        contentView.addSubview(top2Icon)
        contentView.addSubview(lotteryView)
        lotteryView.addSubview(lotteryTitleLb)
        lotteryView.addSubview(avatarView)
        lotteryView.addSubview(redeemLb)
        lotteryView.addSubview(nikeNameLb)
        lotteryView.addSubview(lotteryListButton)

        contentView.addSubview(unLotteryView)
        unLotteryView.addSubview(unLotteryTitleLb)
        unLotteryView.addSubview(unLotteryIcon)
        unLotteryView.addSubview(unlotteryListButton)

        contentView.addSubview(lotteryListView)
        lotteryListView.addSubview(backButton)
        lotteryListView.addSubview(listTitleLabel)
        lotteryListView.addSubview(subTitleLabel)
        lotteryListView.addSubview(lotteryScrollView)

    }

    func makeLayout()
    {
        contentView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(CGSize(width: HeightScale(height: 300), height: HeightScale(height: 310)))
        }
        closeBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: HeightScale(height: 50), height: HeightScale(height: 50)))
        }
        topIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
//            make.top.equalTo(contentView.snp.top).offset(-50)
            make.top.equalTo(-50)
            make.size.equalTo(CGSize(width: HeightScale(height: 176), height: HeightScale(height: 114)))
        }

        unTakeView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        unTakeTitleLb.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 85))
            make.centerX.equalTo(unTakeView.snp.centerX)
            make.width.equalTo(HeightScale(height: 212))
            make.height.equalTo(HeightScale(height: 60))
        }
        unTakeTimeLb.snp.makeConstraints { (make) in
            make.top.equalTo(unTakeTitleLb.snp.bottom).offset(35)
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 20))
        }

        lotteryTipsLb.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 20))
            make.bottom.equalTo(-HeightScale(height: 17))
        }

        takeLotteryLb.snp.makeConstraints { (make) in
            make.centerX.equalTo(unTakeView.snp.centerX)
            make.top.equalTo(unTakeTimeLb.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: HeightScale(height: 230), height: HeightScale(height: 42)))
        }

        takeButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(unTakeView.snp.centerX)
            make.top.equalTo(unTakeTimeLb.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: HeightScale(height: 230), height: HeightScale(height: 42)))
        }
        takeButton.size = CGSize(width: HeightScale(height: 230), height: HeightScale(height: 42))
        let layer = CAGradientLayer.gradientLayerWithType(type: .LeftToRight, frame: CGRect(x: 0, y: 0, width: takeButton.size.width, height: takeButton.size.height), startColor: .init(hex: "#FFAB1A"), endColor: .init(hex: "#FA6A02"))
        takeButton.layer.insertSublayer(layer, at: 0)

        lotteryView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        lotteryTitleLb.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(lotteryView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 147), height: HeightScale(height: 55)))
        }
        top2Icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(lotteryView.snp.top).offset(-62)
//            make.top.equalTo(62)
            make.size.equalTo(CGSize(width: HeightScale(height: 217), height: HeightScale(height: 105)))
        }
        avatarView.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 88))
            make.centerX.equalTo(contentView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 70), height: HeightScale(height: 70)))
        }
        nikeNameLb.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(5)
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 20))
        }
        redeemLb.snp.makeConstraints { (make) in
            make.top.equalTo(nikeNameLb.snp.bottom).offset(30)
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 22))
        }
        lotteryListButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(redeemLb.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: HeightScale(height: 120), height: HeightScale(height: 20)))
        }

        unLotteryView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        unLotteryTitleLb.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 45))
            make.centerX.equalTo(unTakeView.snp.centerX)
            make.width.equalTo(HeightScale(height: 195))
            make.height.equalTo(HeightScale(height: 33))
        }
        unLotteryIcon.snp.makeConstraints { (make) in
            make.top.equalTo(unLotteryTitleLb.snp.bottom).offset(30)
            make.centerX.equalTo(unLotteryView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 78), height: HeightScale(height: 83)))
        }
        unlotteryListButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(unLotteryView.snp.centerX)
            make.top.equalTo(unLotteryIcon.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: HeightScale(height: 120), height: HeightScale(height: 20)))
        }


        lotteryListView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(15)
            make.size.equalTo(CGSize(width: HeightScale(height: 40), height: HeightScale(height: 40)))
        }
        listTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalTo(lotteryListView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 150), height: HeightScale(height: 20)))
        }
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(listTitleLabel.snp.bottom).offset(0)
            make.centerX.equalTo(lotteryListView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 150), height: HeightScale(height: 17)))
        }
        lotteryScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(HeightScale(height: 75))
            make.size.equalTo(CGSize(width: HeightScale(height: 300 - 20), height: HeightScale(height: 310) - HeightScale(height: 85)))
        }

//        let str = HSCSUserInfoManager.shared().userInfo.avatar + "?imageView2/1/w/\(3 * Int(100))/h/\(3 * Int(100))/q/100"
//        avatarView.kf.setImage(with: URL(string: str), placeholder: UIImage(named: "mine_default_head_icon"), options: nil, progressBlock: nil, completionHandler: nil)

        closeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let weakself = self else{ return }
            weakself.hideView()
        }).disposed(by: disposeBag)

        takeButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let weakself = self else{ return }
            weakself.requestLotteryPartIn()
        }).disposed(by: disposeBag)

        lotteryListButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let weakself = self else{ return }
            //中奖列表
            weakself.popTag = 1
            weakself.lotteryView.isHidden = true
            weakself.top2Icon.isHidden = weakself.lotteryView.isHidden
            weakself.lotteryListView.isHidden = false
        }).disposed(by: disposeBag)

        unlotteryListButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let weakself = self else{ return }
            //中奖列表
            weakself.popTag = 2
            weakself.unLotteryView.isHidden = true
            weakself.lotteryListView.isHidden = false
        }).disposed(by: disposeBag)

        backButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let weakself = self else{ return }
            weakself.lotteryListView.isHidden = true
            if weakself.popTag == 1 {
                weakself.lotteryView.isHidden = false
                weakself.top2Icon.isHidden = weakself.lotteryView.isHidden
            }
            if weakself.popTag == 2 {
                weakself.unLotteryView.isHidden = false
            }
        }).disposed(by: disposeBag)
    }

    func hideView()
    {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { (suc) in
            self.removeFromSuperview()
        }
    }

    public func showTakeLotteryView()
    {
        let window = UIApplication.shared.keyWindow
        self.alpha = 0;
        window?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }

    //MARK: 用户参与抽奖
    private func requestLotteryPartIn()
    {
        guard let activityId = activityModel?.activityId else { return }
        HSCSNewLiveLotterySerice.requestLotteryPartIn(parameters: ["activityId": activityId]) { [weak self] (suc, isPartIn, partInNumber) in
            if suc {
                guard let weakself = self else { return }
                weakself.takeButton.isHidden = true
                weakself.takeLotteryLb.isHidden = false
                weakself.activityModel?.isPartIn = isPartIn
                weakself.activityModel?.partInNumber = partInNumber
                weakself.hideView()
                if weakself.takeLotteryBlock != nil {
                    weakself.takeLotteryBlock!()
                }
            }
        } failure: { (error) in

        }
    }
}

extension HSCSNewLiveTakeLotteryView
{

    func initTimer() {
        invalidate()
        timer = Timer.init(timeInterval: 1, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }

    @objc func timerFire() {
        seconds -= 1
        if seconds > 0 {
            //倒计时
            timeText(secondss: Int32(seconds))
        } else {
            //开始
            if startLotteryBlock != nil {
                startLotteryBlock!()
            }
            invalidate()
            hideView()
        }
    }

    func timeText(secondss: Int32)
    {
        //设置倒计时显示的时间
        let minute = String(format: "%02ld", (Int(secondss) % 3600) / 60)
        let second = String(format: "%02ld", secondss % 60)
        unTakeTimeLb.text = "开奖倒计时 " + minute + ":" + second
    }

    func invalidate()
    {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
}

class HSCSLotteryInfoView: UIView
{
    private let nikeNameLabel: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 14), textAlignment: .left)
        return label
    }()

    private let phoneLabel: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 14), textAlignment: .left)
        label.textAlignment = .right
        return label
    }()

    private let lineView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .init(hex: "#FCEFBB")
        return view
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
        addSubview(lineView)

        nikeNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.right.equalTo(-HeightScale(height: 140))
            make.height.equalTo(36)
        }
        phoneLabel.snp.makeConstraints { (make) in
            make.width.equalTo(HeightScale(height: 150))
            make.top.equalTo(0)
            make.right.equalTo(-15)
            make.height.equalTo(36)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalTo(0)
            make.right.equalTo(-15)
            make.height.equalTo(1)
        }
    }
}
