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
//        File Name:       HSCSNewLiveLotteryView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/9 1:23 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit

private let kFloatHeight: CGFloat = HeightScale(height: 70)
private let single = HSCSNewLiveLotteryView()

class HSCSNewLiveLotteryView: NSObject
{
    @objc open class var shared: HSCSNewLiveLotteryView {
        return single
    }
    weak var naviController: UINavigationController?
    let screenSize = UIScreen.main.bounds.size
    var roundEntryViewWidth: CGFloat = kFloatHeight
    var roundEntryViewMargin: CGFloat = 0
//    let delegate = UIApplication.shared.delegate as! HSCSAppDelegate
    private var baseView: UIView!
    private var floatView: UIView!

    private let imgView: UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(named: "new_live_lottery_icon")
        return img
    }()

    private let timeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .init(hex: "#FEEDD6")
        label.font = UIFont.PingFang_Medium(fontSize: 13)
        label.textColor = .init(hex: "#E4561B")
        label.textAlignment = .center
        label.layer.cornerRadius = HeightScale(height: 11)
        label.layer.masksToBounds = true
        return label
    }()

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

    //抽奖结束
    public var startLotteryBlock: (() -> ())?
    //参与抽奖
    public var takeLotteryBlock: (() -> ())?

    override init() {
        super.init()
        baseView = UIView(frame: CGRect(x: screenSize.width - roundEntryViewMargin - roundEntryViewWidth, y: screenSize.height / 2 + 100, width: HeightScale(height: 67), height: HeightScale(height: 61)))
        floatView = UIView(frame: CGRect(x: 0, y: 0, width: HeightScale(height: 67), height: HeightScale(height: 61)))
        baseView.isHidden = true
        floatView.isUserInteractionEnabled = true

        let pan = UIPanGestureRecognizer(target: self, action: #selector(processRoundEntryView(gesture:)))
        baseView.addGestureRecognizer(pan)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGes(gesture:)))
        floatView.addGestureRecognizer(tap)

        baseView.addSubview(floatView)
        floatView.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

        baseView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: HeightScale(height: 44), height: HeightScale(height: 22)))
            make.centerX.equalTo(baseView.snp.centerX)
            make.top.equalTo(HeightScale(height: 28))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func tapAction()
    {
        hideFloatWindow()
    }

    @objc func tapGes(gesture: UITapGestureRecognizer)
    {
        if takeLotteryBlock != nil {
            takeLotteryBlock!()
        }
    }

    //显示悬浮窗
//    @objc open func showFloatWindow(view: UIView, model: HSCSAdvertModel)
    @objc open func showFloatWindow(view: UIView)
    {
        //如果悬浮窗处于隐藏状态，则显示
        if baseView.isHidden {
            self.baseView.alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                view.addSubview(self.baseView)
                self.baseView.alpha = 1
                self.baseView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            }) { (finished) in
                self.baseView.isHidden = false
            }
        }
    }

    //隐藏悬浮窗
    @objc open func hideFloatWindow()
    {
        if !baseView.isHidden {
            UIView.animate(withDuration: 0.1, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.baseView.transform = CGAffineTransform.identity
                    .scaledBy(x: 0.2, y: 0.2)
                self.baseView.alpha = 0
            }) { (finished) in
                self.baseView.isHidden = true
                self.baseView.removeFromSuperview()
            }
        }
    }

    @objc
    func processRoundEntryView(gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: baseView.self.superview)
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.baseView.center = point
            }) { (finished) in

            }
        } else if gesture.state == .changed {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                self.baseView.center = point
            }) { (finished) in

            }
        } else if gesture.state == .ended || gesture.state == .cancelled {
            var frame = baseView.frame
            //设置横向坐标
            if point.x > screenSize.width / 2 {
                frame.origin.x = screenSize.width - roundEntryViewMargin - roundEntryViewWidth
            } else {
                frame.origin.x = roundEntryViewMargin
            }
            //设置最高点
            if point.y < 50 {
                frame.origin.y = 50
            }
//            //设置最低点
            if point.y > SCREENHEIGHT - kFloatHeight - CGFloat(k_Height_NavContentBar) {
                frame.origin.y = SCREENHEIGHT - kFloatHeight - CGFloat(k_Height_NavContentBar) - kFloatHeight / 2 - 10
            }
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.baseView.frame = frame
            }) { (finished) in

            }
        }
    }
}


extension HSCSNewLiveLotteryView
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
            invalidate()
            hideFloatWindow()
            if startLotteryBlock != nil {
                startLotteryBlock!()
            }
        }
    }

    func timeText(secondss: Int32)
    {
        //设置倒计时显示的时间
        let minute = String(format: "%02ld", (Int(secondss) % 3600) / 60)
        let second = String(format: "%02ld", secondss % 60)
        timeLabel.text = minute + ":" + second
    }

    func invalidate()
    {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
}


//抽检预告
class HSCSNewLiveLotteryTextView: UIView
{
    private let textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .text
        label.font = UIFont.PingFang_Regular(fontSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(hex: "#FFF3EA")
        makeUpUI()
    }

    var notice: String?
    {
        didSet {
            if let text = notice {
                textLabel.text = "抽奖预告：\(text)"
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeUpUI()
    {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.bottom.right.equalTo(0)
        }
    }
}
