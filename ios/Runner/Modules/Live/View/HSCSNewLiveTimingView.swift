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
//        File Name:       HSCSNewLiveTimingView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/1 3:59 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxSwift
import RxCocoa

extension UILabel
{
    class func create(textColor:UIColor,font:UIFont,textAlignment:NSTextAlignment) -> UILabel
    {
        let label = UILabel(frame: .zero)
        label.textColor = textColor
        label.font = font
        label.textAlignment = textAlignment
        return label
    }
}

class HSCSNewLiveTimingView: UIView {
    
    public var startLiveBlock:(()->())?//开始直播
    public var watchBackBlock:(()->())?//回看
    public var subBlock:(()->())?//预约
    
    private var timer : Timer?
    
    public var seconds : TimeInterval = 0
    {
        didSet{
            if seconds > 0 {
                initTimer()
            }
        }
    }
    
    public var isSub : Bool?
    {
        didSet{
            appointmentButton.setTitle(isSub! ? "已预约" : "立即预约", for: .normal)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    private let countDownView : UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let watchBackView : UIView = {
        let view = UIView(frame: .zero)
        view.isHidden = true
        return view
    }()
    
    private let watchBackIcon : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = UIImage(named: "new_live_back_logo")
        return view
    }()
    
    private let watchBackLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 16), textAlignment: .center)
        label.text = "节目已结束，敬请收看视频回放"
        return label
    }()
    
    private let watchBackBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage(named: "new_live_back_btn_icon"), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("查看回放", for: .normal)
        btn.titleLabel?.font = .PingFang_Medium(fontSize: 15)
        return btn
    }()
    
    private let waitLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 18), textAlignment: .center)
        label.text = "节目即将开始，敬请期待"
        label.isHidden = true
        return label
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Medium(fontSize: 17), textAlignment: .center)
        label.text = "距离直播开始"
        return label
    }()
    
    private let appointmentButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("立即预约", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .PingFang_Medium(fontSize: 16)
        button.layer.cornerRadius = HeightScale(height: 40)/2
        button.layer.masksToBounds = true
        return button
    }()
    
    private let contentView : UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let dayValueLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 20), textAlignment: .center)
        label.backgroundColor = .init(hex: "#EBCCA3")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let dayLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Regular(fontSize: 15), textAlignment: .center)
        label.backgroundColor = .clear
        return label
    }()
    
    private let hourValueLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 20), textAlignment: .center)
        label.backgroundColor = .init(hex: "#EBCCA3")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let hourLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Regular(fontSize: 15), textAlignment: .center)
        label.backgroundColor = .clear
        return label
    }()
    
    private let minuteValueLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 20), textAlignment: .center)
        label.backgroundColor = .init(hex: "#EBCCA3")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let minuteLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Regular(fontSize: 15), textAlignment: .center)
        label.backgroundColor = .clear
        return label
    }()
    
    private let secondValueLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Regular(fontSize: 20), textAlignment: .center)
        label.backgroundColor = .init(hex: "#EBCCA3")
        label.layer.cornerRadius = 3
        label.layer.masksToBounds = true
        return label
    }()
    
    private let secondLabel : UILabel = {
        let label = UILabel.create(textColor: .white, font: .PingFang_Regular(fontSize: 15), textAlignment: .center)
        label.backgroundColor = .clear
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .text
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
                
                countDownView.isHidden = true
                waitLabel.isHidden = true
                watchBackView.isHidden = true
                
                switch type {
                case .HSCSNewLiveTypeNone:
                    waitLabel.text = "今日无直播节目"
                    waitLabel.isHidden = false
                    break
                case .HSCSNewLiveTypeWillLive:
                    waitLabel.text = "节目即将开始，敬请期待"
                    waitLabel.isHidden = false
                    break
                case .HSCSNewLiveTypeCountDown:
                    countDownView.isHidden = false
                    break
                case .HSCSNewLiveTypeLiveEnd:
                    watchBackView.isHidden = false
                    break
                default:
                    break
                }
            }else{
                countDownView.isHidden = false
                waitLabel.isHidden = true
                watchBackView.isHidden = true
            }
        }
    }
    
    private func makeUpUI()
    {
        watchBackBtn.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else { return }
            if weakself.watchBackBlock != nil {
                weakself.watchBackBlock!()
            }
        }).disposed(by: disposeBag)

        appointmentButton.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else { return }
            if weakself.subBlock != nil {
                weakself.subBlock!()
            }
        }).disposed(by: disposeBag)
        
        addSubview(countDownView)
        countDownView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        addSubview(watchBackView)
        watchBackView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        watchBackView.addSubview(watchBackIcon)
        watchBackView.addSubview(watchBackLabel)
        watchBackView.addSubview(watchBackBtn)
        
        watchBackIcon.snp.makeConstraints { (make) in
            make.top.equalTo(HeightScale(height: 40))
            make.centerX.equalTo(watchBackView.snp.centerX)
            make.size.equalTo(watchBackIcon.image!.size)
        }
        watchBackLabel.snp.makeConstraints { (make) in
            make.top.equalTo(watchBackIcon.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.width.equalTo(SCREENWITH)
            make.height.equalTo(HeightScale(height: 22))
        }
        watchBackBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(watchBackView.snp.centerX)
            make.top.equalTo(watchBackLabel.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: HeightScale(height: 90), height: HeightScale(height: 31)))
        }
        
        addSubview(waitLabel)
        waitLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        countDownView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(45)
            make.left.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 25))
        }
        
        countDownView.addSubview(appointmentButton)
        appointmentButton.size = CGSize(width: HeightScale(height: 132), height: HeightScale(height: 40))
        appointmentButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(-45)
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: HeightScale(height: 132), height: HeightScale(height: 40)))
        }
        let layer = CAGradientLayer.gradientLayerWithType(type: .LeftToRight, frame: CGRect(x: 0, y: 0, width: appointmentButton.size.width, height: appointmentButton.size.height), startColor: .init(hex: "#FFC95B"), endColor: .init(hex: "#FEA708"))
        appointmentButton.layer.insertSublayer(layer, at: 0)
        
        countDownView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: HeightScale(height: 230), height: HeightScale(height: 25)))
        }
        
//        dayValueLabel.text = "02"
//        hourValueLabel.text = "02"
//        minuteValueLabel.text = "02"
//        secondValueLabel.text = "02"
        
        dayLabel.text = "天"
        hourLabel.text = "时"
        minuteLabel.text = "分"
        secondLabel.text = "秒"
        
        contentView.addSubview(dayValueLabel)
        dayValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 35), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dayValueLabel.snp.right).offset(0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 26), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(hourValueLabel)
        hourValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dayValueLabel.snp.right).offset(HeightScale(height: 26))
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 35), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(hourLabel)
        hourLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hourValueLabel.snp.right).offset(0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 26), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(minuteValueLabel)
        minuteValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(hourValueLabel.snp.right).offset(HeightScale(height: 26))
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 35), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(minuteLabel)
        minuteLabel.snp.makeConstraints { (make) in
            make.left.equalTo(minuteValueLabel.snp.right).offset(0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 26), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(secondValueLabel)
        secondValueLabel.snp.makeConstraints { (make) in
            make.left.equalTo(minuteValueLabel.snp.right).offset(HeightScale(height: 26))
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 35), height: HeightScale(height: 24)))
        }
        
        contentView.addSubview(secondLabel)
        secondLabel.snp.makeConstraints { (make) in
            make.left.equalTo(secondValueLabel.snp.right).offset(0)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: HeightScale(height: 26), height: HeightScale(height: 24)))
        }
    }
}

extension HSCSNewLiveTimingView
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
        }else{
            //直播开始
            invalidate()
            isHidden = true
            if startLiveBlock != nil {
                startLiveBlock!()
            }
        }
    }
    
    func timeText(secondss:Int32)
    {
        //设置倒计时显示的时间
        let day = String(format: "%02ld", secondss/3600/24)
        let hour = String(format: "%02ld", (secondss/3600) % 24)
        let minute = String(format: "%02ld", (Int(secondss) % 3600)/60)
        let second = String(format: "%02ld", secondss % 60)
        
        dayValueLabel.text = day
        hourValueLabel.text = hour
        minuteValueLabel.text = minute
        secondValueLabel.text = second
    }
    
    func invalidate()
    {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
}
