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
//        File Name:       HSCSNewLiveCountdownView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/11 1:29 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit

class HSCSNewLiveCountdownView: UIView {

    public var countdownBlock: (() -> ())?

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .init(hex: "#515151", alpha: 0.35)
        contentView.layer.cornerRadius = 13
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = false
        return contentView
    }()

    private let numberLabel: UILabel = {
        let label = UILabel.create(textColor: .init(hex: "#FB6800"), font: .Impact_Regular(fontSize: 90), textAlignment: .center)
        return label
    }()

    var replicator: CAReplicatorLayer?
    var showlayer: CALayer?

    private var timer: Timer?

    public var seconds: TimeInterval = 0
    {
        didSet {
            if seconds > 0 {
                initTimer()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        makeUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeUpUI()
    {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(CGSize(width: HeightScale(height: 200), height: HeightScale(height: 200)))
        }
        contentView.size = CGSize(width: HeightScale(height: 200), height: HeightScale(height: 200))
        creatReaplicator()
        startAnimation()
        numberLabel.text = "9"
        contentView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 80, height: 100))
        }
    }

    func hideView()
    {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { (suc) in
            self.removeFromSuperview()
        }
    }

    func startAnimation()
    {
        //对layer进行动画设置
        let animaiton = CABasicAnimation()
        //设置动画所关联的路径属性
        animaiton.keyPath = "transform.scale"
        //设置动画起始和终结的动画值
        animaiton.fromValue = NSNumber(value: 1)
        animaiton.toValue = NSNumber(value: 0.1)
        //设置动画时间
        animaiton.duration = 2.0
        //填充模型
        animaiton.fillMode = .forwards
        //不移除动画
        animaiton.isRemovedOnCompletion = false
        //设置动画次数
        animaiton.repeatCount = Float(Int32.max)
        //添加动画
        showlayer!.add(animaiton, forKey: "anmation")
    }

    func creatReaplicator()
    {
        let numofInstance = 12
        let duration = 1.0
        replicator = CAReplicatorLayer()
        replicator?.bounds = CGRect(x: 0, y: 0, width: HeightScale(height: 230), height: HeightScale(height: 200))

        replicator?.position = CGPoint(x: contentView.size.width / 2, y: contentView.size.height / 2)
        replicator?.instanceCount = numofInstance
        replicator?.instanceDelay = duration / Double(numofInstance)
        replicator?.instanceTransform = CATransform3DMakeRotation(.pi * 2.0 / 12.0, 0, 0, 1)

        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: HeightScale(height: 20), height: HeightScale(height: 20))
        layer.position = CGPoint(x: HeightScale(height: 90), y: HeightScale(height: 35))
        layer.backgroundColor = UIColor.init(hex: "#FB6800").cgColor
        layer.cornerRadius = HeightScale(height: 20) / 2
        layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        showlayer = layer

        //将子图层添加到repelicator上
        replicator?.addSublayer(layer)
        contentView.layer.addSublayer(replicator!)
    }


    @objc class func showCountdownView(seconds: TimeInterval, startBlock: @escaping (() -> ()))
    {
        let window = UIApplication.shared.keyWindow
        let view = HSCSNewLiveCountdownView(frame: window!.bounds)
        view.alpha = 0;
        view.seconds = seconds
        view.countdownBlock = startBlock
        window?.addSubview(view)
        UIView.animate(withDuration: 0.2) {
            view.alpha = 1
        }
    }
}

extension HSCSNewLiveCountdownView
{
    func initTimer() {
        invalidate()
        timer = Timer.init(timeInterval: 1, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }

    @objc func timerFire() {
        seconds -= 1
        if seconds >= 0 {
            //倒计时
            timeText(secondss: Int32(seconds))
        } else {
            //直播开始
            invalidate()
            isHidden = true
            if countdownBlock != nil {
                countdownBlock!()
            }
        }
    }

    func timeText(secondss: Int32)
    {
        //设置倒计时显示的时间
        numberLabel.text = "\(secondss)"
    }

    func invalidate()
    {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
}
