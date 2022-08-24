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
//        File Name:       HSCSNewLiveTakeLotteryView2.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/10/10 10:18 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxSwift
import RxCocoa

class HSCSNewLiveTakeLotteryView2: UIView
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
        btn.setImage(UIImage(named: "new_live_close_white_icon"), for: .normal)
        return btn
    }()

    //未参加
    private let unTakeView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_lottery_bg2")
        view.isUserInteractionEnabled = true
        return view
    }()
    private let unTakeTitleLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#DE5839"), font: .PingFang_Medium(fontSize: 30), textAlignment: .center)
        label.text = "开奖倒计时"
        label.numberOfLines = 2
        return label
    }()
    private let unTakeTimeLb: UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 14), textAlignment: .center)
        return label
    }()
    
    private let takeTimeView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let minuteValueLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 30), textAlignment: .center)
        label.backgroundColor = .init(hex: "#DE5839")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let minuteValue2Label : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 30), textAlignment: .center)
        label.backgroundColor = .init(hex: "#DE5839")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let minuteLabel : UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#DA5837"), font: .PingFang_Medium(fontSize: 24), textAlignment: .center)
        label.backgroundColor = .clear
        label.text = "分"
        return label
    }()
    
    private let secondValueLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 30), textAlignment: .center)
        label.backgroundColor = .init(hex: "#DE5839")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let secondValue2Label : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 30), textAlignment: .center)
        label.backgroundColor = .init(hex: "#DE5839")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let secondLabel : UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#DA5837"), font: .PingFang_Medium(fontSize: 24), textAlignment: .center)
        label.backgroundColor = .clear
        label.text = "秒"
        return label
    }()
    
    private let takeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "new_live_join_button_icon"), for: .normal)
        btn.setTitle("参与抽奖", for: .normal)
        btn.setTitleColor(.init(hex: "#944D16"), for: .normal)
        btn.titleLabel?.font = .PingFang_Medium(fontSize: 24)
        btn.layer.cornerRadius = HeightScale(height: 42) / 2
        btn.layer.masksToBounds = true
        return btn
    }()

    //已中奖
    private var lotteryGIFView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.loadGif(asset: "new_live_lottery_gif")
        imgView.isHidden = true
        return imgView
    }()
    
    private let lotteryView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_unlottery_bg2")
        view.isUserInteractionEnabled = true
        return view
    }()
    private let lotteryTitleLb: UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Bold(fontSize: 30), textAlignment: .center)
        label.text = "恭喜中奖"
        return label
    }()
    private let nikeNameLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#8C613A"), font: .PingFang_Medium(fontSize: 21), textAlignment: .center)
//        label.text = HSCSUserInfoManager.shared().userInfo.nickname
        return label
    }()
    private let redeemLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#DA5837"), font: .PingFang_Medium(fontSize: 21), textAlignment: .center)
//        label.text = HSCSUserInfoManager.shared().isVp ? "请联系理财管家兑奖" : "请联系宣老师助手兑奖"
        return label
    }()
    private let avatarView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    //未中奖
    private let unLotteryView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_unlottery_bg2")
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let unLotteryTitleLb: UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Bold(fontSize: 30), textAlignment: .center)
        label.text = "未中奖"
        return label
    }()
    
    private let unLotteryMsgLb: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#DA5837"), font: .PingFang_Medium(fontSize: 18), textAlignment: .center)
        label.numberOfLines = 0
        label.text = "很遗憾，大奖与您擦肩而过下次再接再励哦~"
        return label
    }()
    private let unLotteryIcon: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_unlottery_icon2")
        view.isUserInteractionEnabled = true
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
            if let model = activityModel {
                lotteryView.isHidden = true
                unLotteryView.isHidden = true
                lotteryGIFView.isHidden = true
                unTakeView.isHidden = false
                unTakeView.image = model.isPartIn ? UIImage(named: "new_live_join_lottery_bg") : UIImage(named: "new_live_lottery_bg2")
                takeButton.isHidden = model.isPartIn
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
                lotteryView.isHidden = true
                lotteryGIFView.isHidden = true
                if model.isWin {
                    //中奖
                    lotteryView.isHidden = false
                    lotteryGIFView.isHidden = false
                } else {
                    //未中奖
                    unLotteryView.isHidden = false
                }
            }
        }
    }

    //抽奖结束
    public var startLotteryBlock: (() -> ())?
    //参与抽奖
    public var takeLotteryBlock: (() -> ())?

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUpUI()
        makeLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeUpUI()
    {
        backgroundColor = UIColor.init(hex: "#000000", alpha: 0.5)
        addSubview(contentView)
        addSubview(closeBtn)
//        unTakeView.isHidden = true
//        lotteryView.isHidden = true
//        unLotteryView.isHidden = true
        
        contentView.addSubview(unTakeView)
        unTakeView.addSubview(unTakeTitleLb)
        unTakeView.addSubview(takeTimeView)
        unTakeView.addSubview(takeButton)
        takeTimeView.addSubview(minuteValueLabel)
        takeTimeView.addSubview(minuteValue2Label)
        takeTimeView.addSubview(minuteLabel)
        takeTimeView.addSubview(secondValueLabel)
        takeTimeView.addSubview(secondValue2Label)
        takeTimeView.addSubview(secondLabel)
        
        contentView.addSubview(lotteryView)
        contentView.addSubview(lotteryGIFView)
        lotteryView.addSubview(lotteryTitleLb)
        lotteryView.addSubview(avatarView)
        lotteryView.addSubview(redeemLb)
        lotteryView.addSubview(nikeNameLb)
        
        contentView.addSubview(unLotteryView)
        unLotteryView.addSubview(unLotteryTitleLb)
        unLotteryView.addSubview(unLotteryMsgLb)
        unLotteryView.addSubview(unLotteryIcon)
        
    }

    func makeLayout()
    {
        contentView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(CGSize(width: SCREENWITH, height: HeightScale(height: 330)))
        }
        closeBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: HeightScale(height: 50), height: HeightScale(height: 50)))
        }

        unTakeView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        unTakeTitleLb.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 75))
            make.centerX.equalTo(unTakeView.snp.centerX)
            make.width.equalTo(HeightScale(height: 300))
            make.height.equalTo(HeightScale(height: 35))
        }
        takeButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: HeightScale(height: 153), height: HeightScale(height: 42)))
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(-HeightScale(height: 60))
        }
        takeTimeView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: HeightScale(height: 200), height: HeightScale(height: 40)))
            make.top.equalTo(unTakeTitleLb.snp.bottom).offset(25)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        minuteValueLabel.snp.makeConstraints { (make) in
            make.width.equalTo(CGSize(width: HeightScale(height: 32), height: HeightScale(height: 40)))
            make.top.left.equalTo(0)
        }
        minuteValue2Label.snp.makeConstraints { (make) in
            make.left.equalTo(minuteValueLabel.snp.right).offset(6)
            make.top.equalTo(0)
            make.width.equalTo(CGSize(width: HeightScale(height: 32), height: HeightScale(height: 40)))
        }
        minuteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(minuteValue2Label.snp.right).offset(0)
            make.centerY.equalTo(takeTimeView.snp.centerY)
            make.width.equalTo(CGSize(width: HeightScale(height: 36), height: HeightScale(height: 35)))
        }
        secondValueLabel.snp.makeConstraints { (make) in
            make.width.equalTo(CGSize(width: HeightScale(height: 32), height: HeightScale(height: 40)))
            make.top.equalTo(0)
            make.left.equalTo(minuteLabel.snp.right).offset(0)
        }
        secondValue2Label.snp.makeConstraints { (make) in
            make.left.equalTo(secondValueLabel.snp.right).offset(6)
            make.top.equalTo(0)
            make.width.equalTo(CGSize(width: HeightScale(height: 32), height: HeightScale(height: 40)))
        }
        secondLabel.snp.makeConstraints { (make) in
            make.left.equalTo(secondValue2Label.snp.right).offset(0)
            make.centerY.equalTo(takeTimeView.snp.centerY)
            make.width.equalTo(CGSize(width: HeightScale(height: 36), height: HeightScale(height: 35)))
        }
        
        lotteryGIFView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(lotteryView.snp.top).offset(HeightScale(height: 375)/2)
            make.size.equalTo(CGSize(width: SCREENWITH, height: HeightScale(height: 375)))
        }
        lotteryView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        lotteryTitleLb.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(lotteryView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 147), height: HeightScale(height: 45)))
        }
        
        avatarView.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 65))
            make.centerX.equalTo(contentView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 60), height: HeightScale(height: 60)))
        }
        nikeNameLb.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.bottom).offset(HeightScale(height: 7))
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 30))
        }
        redeemLb.snp.makeConstraints { (make) in
            make.top.equalTo(nikeNameLb.snp.bottom).offset(30)
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 22))
        }
        
        unLotteryView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        unLotteryMsgLb.snp.makeConstraints { (make) in
            make.top.equalTo(unLotteryIcon.snp.bottom).offset(0)
            make.centerX.equalTo(unTakeView.snp.centerX)
            make.width.equalTo(HeightScale(height: 216))
            make.height.equalTo(HeightScale(height: 55))
        }
        unLotteryIcon.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 55))
            make.centerX.equalTo(unLotteryView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 83), height: HeightScale(height: 102)))
        }
        unLotteryTitleLb.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(lotteryView.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 147), height: HeightScale(height: 45)))
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
//        let view = HSCSNewLiveTakeLotteryView(frame: window!.bounds)
        self.alpha = 0;
//        view.seconds = 5
//        view.activityModel = activityModel
//        view.activityResultModel = activityResultModel
//        view.takeLotteryBlock = takeLotteryBlock
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
                weakself.activityModel?.isPartIn = isPartIn
                weakself.activityModel?.partInNumber = partInNumber
                weakself.unTakeView.image = isPartIn ? UIImage(named: "new_live_join_lottery_bg") : UIImage(named: "new_live_lottery_bg2")
                weakself.takeButton.isHidden = isPartIn
                weakself.hideView()
                if weakself.takeLotteryBlock != nil {
                    weakself.takeLotteryBlock!()
                }
            }
        } failure: { (error) in

        }
    }
}

extension HSCSNewLiveTakeLotteryView2
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
        minuteValueLabel.text = minute[0]
        minuteValue2Label.text = minute[1]
        secondValueLabel.text = second[0]
        secondValue2Label.text = second[1]
    }

    func invalidate()
    {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
}
