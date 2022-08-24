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
//        File Name:       HSCSNewLiveViewController.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/1 9:49 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import RxSwift
import RxCocoa
import ObjectMapper

enum HSCSNewLiveType {
    //无直播
    case HSCSNewLiveTypeNone
    //观看直播
    case HSCSNewLiveTypeWatchBack
    //直播中
    case HSCSNewLiveTypeLiving
    //倒计时
    case HSCSNewLiveTypeCountDown
    //即将开始
    case HSCSNewLiveTypeWillLive
    //生成回看
    case HSCSNewLiveTypeMakeBack
    //播放结束
    case HSCSNewLiveTypeLiveEnd
}

let kVideoHeight = HeightScale(height: 210)

class HSCSNewLiveViewController: UIViewController {

    @objc
    public var roomId: Int = 0 {
        didSet {
            HSCSHUD.showGif(to: view)
            requestLiveLivingList(rid: roomId)
            requestChatfeedsall()
            requestGoodsRecomendList()//mitaran@icloud.com
            perform(#selector(requestLotteryAction), with: self, afterDelay: 2.0)
        }
    } //直播间id

    private var baseView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.isUserInteractionEnabled = true
        return view
    }()

    private let navBar: HSCSNewLiveNavView = {
        let view = HSCSNewLiveNavView()
//        view.title = "花生服务联播"
        return view
    }()

    private let headerView: HSCSNewLiveHeaderView = {
        let view = HSCSNewLiveHeaderView(frame: .zero)
        return view
    }()

    private let videoView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: kNavigationBarHeight + HSCSNewLiveHeaderView.viewHeight, width: SCREENWITH, height: kVideoHeight))
        view.backgroundColor = .clear
        return view
    }()

    //底部礼盒、键盘、点赞
    private let liveToolView: HSCSNewLiveToolView = {
        let toolView = HSCSNewLiveToolView(frame: .zero)
        return toolView
    }()

    //回看控件
    private lazy var watchPlayBackView: HSCSWatchBackVideoView = {
        let view = HSCSWatchBackVideoView(frame: videoView.bounds)
        return view
    }()

    //直播控件
    private lazy var watchLiveVideoView: HSCSWatchLiveVideoView = {
        let view = HSCSWatchLiveVideoView(frame: videoView.bounds)
        view.isHidden = true
        return view
    }()

    //倒计时
    private lazy var timingView: HSCSNewLiveTimingView = {
        let view = HSCSNewLiveTimingView(frame: videoView.bounds)
        view.isHidden = true
        return view
    }()

    //生成回放
    private lazy var waitView: HSCSNewLiveWaitView = {
        let view = HSCSNewLiveWaitView(frame: videoView.bounds)
        view.isHidden = true
        return view
    }()

    //聊天列表
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        table.register(HSCSNewLiveChatCell.classForCoder(), forCellReuseIdentifier: "HSCSNewLiveChatCell")
        table.delegate = self
        table.dataSource = self
        return table
    }()

    //键盘
    private lazy var keyboardBar: UIKeyboardBar = {
        let keyBoard = UIKeyboardBar(frame: .zero, maxY: -55)
        keyBoard!.expressionBundleName = "FaceExpression"
        keyBoard!.keyboardTypes = [NSNumber(value: 2), NSNumber(value: 3)]
        keyBoard!.barDelegate = self
        return keyBoard!
    }()

    //长连接 - 推送
    private lazy var socketIOManager: HSCSLiveSocketIOManager = {
        let manager = HSCSLiveSocketIOManager()
        return manager
    }()

    //下拉刷新
    private lazy var mj_header: MJRefreshNormalHeader = {
        let mjheader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(requestChatfeedsall))
        mjheader?.stateLabel.textColor = .white
        mjheader?.lastUpdatedTimeLabel.textColor = .white
        mjheader?.tintColor = .white
        return mjheader!
    }()

    //抽奖浮动
    private let lotteryView: HSCSNewLiveLotteryView = {
        let view = HSCSNewLiveLotteryView()
        return view
    }()

    //抽奖预告
    private let lotteryTextView: HSCSNewLiveLotteryTextView = {
        let view = HSCSNewLiveLotteryTextView()
        view.isHidden = true
        return view
    }()

    private let spaceView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()

    //抽奖弹窗
    private let takeLotteryView: HSCSNewLiveTakeLotteryView2 = {
        let view = HSCSNewLiveTakeLotteryView2(frame: UIApplication.shared.keyWindow!.bounds)
        return view
    }()

    //中奖结果
    private let wWinButton: HSCSNewLiveWinButton = {
        let btn = HSCSNewLiveWinButton(frame: .zero)
        btn.isHidden = true
        return btn
    }()

    let shareButon: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "vp_pdf_share_icon"), for: .normal)
        return button
    }()

    //delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    //RX
    let disposeBag = DisposeBag()

    //tableview 高度
    let maxY: CGFloat = SCREENHEIGHT - HSCSNewLiveNavView.viewHeight - HSCSNewLiveHeaderView.viewHeight - kVideoHeight - HSCSNewLiveToolView.viewHeight

    //聊天记录
    var chatList: Array<HSCSNewLiveChatModel> = []

    //推荐商品列表
    var recomendList: Array<HSCSGoodsRecomendModel> = []

    //游客 5分钟弹窗一次
    private var vipTimer: Timer?

    //直播间信息
    var liveLivingModel: HSCSNewLiveLivingModel?

    //当前节目信息
    var liveActModel: HSCSNewLiveActModel?

    //直播状态
    var liveType: HSCSNewLiveType = .HSCSNewLiveTypeCountDown

    //长连接 房间
    var wsRoom: String = ""

    //获取历史记录 sinceKey
    var sinceKeyOld: String = ""

    //被回复的发言
    var replyModel: HSCSNewLiveChatModel?

    //是否拉取最新数据
    var isNewData: Bool = true

    //拉取历史数据数
    var count: Int = 0

    //抽奖活动信息
    var activityModel: HSCSNewLiveActivityModel?

    //抽奖结果信息
    var activityResultModel: HSCSNewLiveActivityResultModel?

    //所有中奖名单
    var roundResultList: [HSCSNewLiveRoundResultModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUpUI()
        setEvents()
        setNewLiveNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endFullScreen()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    deinit {
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        invalidate()
        socketIOManager.socketIOClose()
        takeLotteryView.invalidate()
        timingView.invalidate()
        lotteryView.invalidate()
        lotteryView.startLotteryBlock = nil
        watchLiveVideoView.close()
        watchPlayBackView.close()
        HSCSLog("deinit", obj: self, line: #line)
    }

    func makeUpUI()
    {
        print("username2 = \(HSCSUserInfoManager.shared().userInfo.nickname)");
        print("token2 = \(HSCSUserInfoManager.shared().userInfo.token)");
        
        fd_prefersNavigationBarHidden = true
        view.addSubview(baseView)
        baseView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

        view.addSubview(navBar)
        navBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(HSCSNewLiveNavView.viewHeight)
        }
        
        navBar.addSubview(shareButon)
        shareButon.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: HeightScale(height: 40), height: 45))
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(navBar.snp.bottom).offset(0)
            make.height.equalTo(HSCSNewLiveHeaderView.viewHeight)
        }

        view.addSubview(videoView)

        view.addSubview(liveToolView)
        liveToolView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(HSCSNewLiveToolView.viewHeight)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(videoView.snp.bottom).offset(0)
            make.bottom.equalTo(liveToolView.snp.top).offset(0)
        }
        videoView.addSubview(timingView)
        videoView.addSubview(waitView)

        view.addSubview(keyboardBar)

        view.addSubview(spaceView)
        spaceView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: SCREENWITH, height: HeightScale(height: 8)))
        }
        spaceView.size = CGSize(width: SCREENWITH, height: HeightScale(height: 12))

        let btnLayer = CAGradientLayer.gradientLayerWithType(type: .TopToBottom, frame: CGRect(x: 0, y: 0, width: spaceView.size.width, height: spaceView.size.height), colors: [.init(hex: "#FFFFFF", alpha: 0.1), .init(hex: "#FFFFFF", alpha: 0.05), .init(hex: "#FFFFFF", alpha: 0)])
        spaceView.layer.insertSublayer(btnLayer, at: 0)

        view.addSubview(wWinButton)
        wWinButton.snp.makeConstraints { (make) in
            make.right.equalTo(HeightScale(height: 120))
            make.bottom.equalTo(videoView.snp.top).offset(-HeightScale(height: 13))
            make.size.equalTo(CGSize(width: HeightScale(height: 120), height: HeightScale(height: 38)))
        }

        view.addSubview(lotteryTextView)
        lotteryTextView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom).offset(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: SCREENWITH, height: HeightScale(height: 36)))
        }

        //下拉刷新
        tableView.mj_header = mj_header
        
        shareButon.rx.tap.subscribe(onNext:{ [self] in
            if let liveLivingModel = liveLivingModel {
                if let chief = liveLivingModel.chief {
//                    HSCSShareCenter.share(with: HSCSShareView(frame: .zero), title: chief.name, content: chief.intro, imageUrl: chief.wxShareIcon, url: chief.h5Url) { type in  }
                }
            }
        }).disposed(by: disposeBag)
    }

    //创建定时器
    func initTimer()
    {
        invalidate()
        vipTimer = Timer.init(timeInterval: 5 * 60, target: self, selector: #selector(showLockAlert), userInfo: nil, repeats: true)
        RunLoop.current.add(vipTimer!, forMode: .common)
    }

    //销毁定时器
    func invalidate()
    {
        if vipTimer != nil {
            vipTimer!.invalidate()
            vipTimer = nil
        }
    }

    func endMJheader()
    {
        if tableView.mj_header.isRefreshing {
            tableView.mj_header.endRefreshing()
        }
    }

    func setEvents()
    {
        navBar.backBlock = { [weak self] in
            guard let weakself = self else { return }
            weakself.invalidate()
        }

        timingView.startLiveBlock = { [weak self] in
            guard let weakself = self else { return }
//            NotificationCenter.default.post(name: .appRefreshHome, object: nil)
            weakself.perform(#selector(weakself.reloadLivingList), with: weakself, afterDelay: 1.5)
        }

        timingView.watchBackBlock = { [weak self] in
            guard let weakself = self else { return }
            weakself.watchBack()
        }

        timingView.subBlock = { [weak self] in
            guard let weakself = self else { return }
            if let model = weakself.liveActModel {
                weakself.doSetLivingSub(actId: model.actId!)
            }
        }

        liveToolView.likeEventBlock = { [weak self] in
            guard let weakself = self else { return }
            if weakself.canScroll() {
                weakself.tableView.reloadData()
                weakself.scrollToBottom(animated: true)
            } else {
                weakself.tableView.reloadData()
            }
            weakself.animationForHeart()
        }

        liveToolView.showTextViewBlock = { [weak self] in
            guard let weakself = self else { return }
//            if HSCSUserInfoManager.shared().isUnlock && !AppConfig.sharedManager().inHSSH {
//                weakself.showLockAlert()
//                return
//            }
            weakself.replyModel = nil
            weakself.keyboardBar.placehoder = ""
            weakself.keyboardBar.textBecomeFirstResponder()
        }

        liveToolView.showRecomendBlock = { [weak self] in
            guard let weakself = self else { return }
//            HSCSSensorsAnalyticsManager.track(withId: "Product_Recommendation", param: ["user_grade": HSCSUserInfoManager.shared().levelNum])
            HSCSNewLiveRecommendListView.showRecommendView(array: AppConfig.sharedManager().inHSSH ? [] : weakself.recomendList)
        }

        let tap = UITapGestureRecognizer()
        tap.rx.event.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else { return }
            if let model = weakself.liveActModel, model.teachers.count > 0 {
//                let tea = model.teachers[0]
//                let vc = HSCSMasterDetailViewController()
//                vc.teacherId = tea.id
//                weakself.navigationController?.push(vc, animated: true)
            }
        }).disposed(by: disposeBag)
        headerView.bgView.addGestureRecognizer(tap)

        //抽奖结束
        lotteryView.startLotteryBlock = { [weak self] in
            guard let weakself = self else { return }
            if let model = weakself.activityModel, model.isPartIn {
//                let vc = UIViewController.getCurrent()
//                if vc.isMember(of: HSCSNewLiveViewController.classForCoder()) {
//                    weakself.requestLotteryTriggerRandom()
//                    HSCSNewLiveCountdownView.showCountdownView(seconds: 9) {
//                        //倒计时结束 计算结果
//                        weakself.requestLotteryLastResult()
//                    }
//                }
            }
        }

        //参与抽奖
        lotteryView.takeLotteryBlock = { [weak self] in
            guard let weakself = self else { return }
//            if HSCSUserInfoManager.shared().isUnlock {
//                weakself.showLockAlert()
//            } else {
//                weakself.activityModel?.leftTime = Int32(weakself.lotteryView.seconds)
//                weakself.takeLotteryView.seconds = TimeInterval(Int32(weakself.lotteryView.seconds))
//                weakself.takeLotteryView.activityModel = weakself.activityModel
//                weakself.takeLotteryView.showTakeLotteryView()
//            }
        }

        takeLotteryView.takeLotteryBlock = { [weak self] in
            guard let weakself = self else { return }
            if let _ = weakself.activityModel?.partInContent {
                HSCSHUD.showSuccessText("已参与")
                weakself.replyModel = nil
                if let model = weakself.activityModel {
                    model.isPartIn = true
                }
            }
        }

        //查看中奖结果
        wWinButton.showWinListBlock = { [weak self] in
            guard let weakself = self else { return }
//            if HSCSUserInfoManager.shared().isUnlock {
//                weakself.showLockAlert()
//            } else {
//                HSCSNewLiveWinListView.showWinListView(array: weakself.roundResultList)
//            }
        }
    }
}

// 抽奖
extension HSCSNewLiveViewController
{

    @objc func requestLotteryAction()
    {
        requestLotteryInfo()
        requestLotteryLastResult()
    }

    //MARK: 活动信息
    @objc
    private func requestLotteryInfo()
    {
        HSCSNewLiveLotterySerice.requestLotteryInfo(parameters: ["roomId": roomId as Any]) { [weak self] (suc, model) in
            if suc {
                guard let weakself = self else { return }
                if let aModel = model {
                    weakself.activityModel = aModel
                    if aModel.isStart {
                        weakself.lotteryView.showFloatWindow(view: weakself.view)
                        weakself.lotteryView.seconds = TimeInterval(aModel.leftTime)
                    }
                    if aModel.isNoticeOpen {
                        weakself.lotteryTextView.alpha = 0
                        weakself.lotteryTextView.isHidden = aModel.notice.count > 0 ? false : true
                        weakself.lotteryTextView.notice = aModel.notice
                        UIView.animate(withDuration: 0.3) {
                            weakself.lotteryTextView.alpha = 1
                        } completion: { (finished) in

                        }
                    } else {
                        weakself.lotteryTextView.isHidden = true
                    }
                }
            }
        } failure: { (error) in

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
            }
        } failure: { (error) in

        }
    }

    //MARK: 最近一次抽奖结果
    private func requestLotteryLastResult()
    {
        takeLotteryView.hideView()
        HSCSNewLiveLotterySerice.requestLotteryLastResult(parameters: ["roomId": roomId as Any]) { [weak self] (suc, model) in
            if suc {
                guard let weakself = self else { return }
                if let rModel = model {
                    weakself.activityResultModel = rModel
                    weakself.takeLotteryView.activityResultModel = weakself.activityResultModel
//                    if !rModel.isChecked && !HSCSUserInfoManager.shared().isUnlock {
//                        if rModel.isPartIn {
//                            weakself.takeLotteryView.showTakeLotteryView()
//                        }
//                    }
                    weakself.requestLotteryRoundResult()
                }
            }
        } failure: { (error) in

        }
    }

    //MARK: 触发抽奖计算
    private func requestLotteryTriggerRandom()
    {
        HSCSNewLiveLotterySerice.requestLotteryTriggerRandom(parameters: ["roomId": roomId as Any]) { (suc) in
            if suc {

            }
        } failure: { (error) in

        }
    }

    //MARK: 直播间所有中奖名单
    private func requestLotteryRoundResult()
    {
        HSCSNewLiveLotterySerice.requestLotteryRoundResult(parameters: ["roomId": roomId as Any]) { [self] (suc, array) in
            if suc {
                roundResultList = array
                wWinButton.isHidden = (liveType == .HSCSNewLiveTypeLiving && roundResultList.count > 0) ? false : true
                if !wWinButton.isHidden {
                    UIView.animate(withDuration: 0.3) {
                        wWinButton.snp.updateConstraints { (make) in
                            make.right.equalTo(0)
                        }
                        view.layoutIfNeeded()
                    } completion: { (finished) in

                    }
                }
            }
        } failure: { (error) in

        }
    }
}

extension HSCSNewLiveViewController
{
    //MARK: 当前房间直播节目
    private func requestLiveLivingList(rid: Int)
    {
        HSCSNewLiveService.requestLiveLivingList(parameters: ["rid": rid]) { [weak self] (suc, liveModel) in
            HSCSHUD.hideGifToView()
            if suc {
                guard let weakself = self else { return }
                weakself.liveLivingModel = liveModel
                weakself.liveActModel = weakself.dismantle(liveModel: liveModel)
                if weakself.wsRoom.count == 0 {
                    if let room = weakself.liveLivingModel?.chief?.wsRoom {
                        weakself.wsRoom = room
                        weakself.receiveMessage(wsRoom: room)
                    }
                }
                weakself.configWithData()
            }
        } failure: { (error) in
            HSCSHUD.hideGifToView()
        }
    }

    private func doSetLivingSub(actId: Int)
    {
        if let model = liveActModel {
            if model.isSub! {
                HSCSHUD.showText("已预约，请留意直播时间")
            } else {
                HSCSNewLiveService.doLivingSub(parameters: ["actId": actId]) { [weak self] (suc) in
                    if suc {
                        guard let weakself = self else {
                            return
                        }
                        HSCSHUD.showText("已设置为开播前五分钟提醒")
//                        NotificationCenter.default.post(name: .appRefreshHome, object: nil)
                        if weakself.liveType == .HSCSNewLiveTypeCountDown {
                            weakself.liveActModel?.isSub = true
                            weakself.timingView.isSub = weakself.liveActModel?.isSub
                        }
                    }
                } failure: { (error) in

                }
            }
        }
    }

    // MARK: - 接收聊天消息
    private func receiveMessage(wsRoom: String)
    {
        socketIOManager.socketIOWithURL(url: AppConfig.sharedManager().clientLiveSocketServer, wsRoom: wsRoom) { [weak self] (data) in

            guard let weakself = self else { return }

            let json = data as! String
            let jsonData: Data = json.data(using: String.Encoding.utf8)!
            let dictData = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? Dictionary<String, Any>

            guard let dict = dictData else {
                return
            }

            let msgType: Int = dict["msgType"] as! Int
            let pushData = dict["data"] as? Dictionary<String, Any>

            if let postData = pushData {
                let rId: Int = postData["roomId"] as! Int
                if msgType == 1 { //聊天记录
                    if rId == weakself.roomId {
                        var chatModel = HSCSNewLiveChatModel(JSON: ["roomId": rId])
                        let show = Mapper<HSCSNewLiveChatShowModel>().map(JSON: postData)
                        chatModel?.show = show
                        if let model = chatModel {
                            //是否存在
                            if !HSCSNewLiveService.isExistChat(chatArray: weakself.chatList, model: model) {
                                weakself.chatList.append(model)
                                if weakself.canScroll() {
                                    weakself.tableView.reloadData()
                                    weakself.scrollToBottom(animated: true)
                                } else {
                                    weakself.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
                if msgType == 3 { //直播室信息变动
                    if rId == weakself.roomId {
//                        NotificationCenter.default.post(name: .appRefreshHome, object: nil)
                        weakself.perform(#selector(weakself.reloadLivingList), with: weakself, afterDelay: 1.5)
                    }
                }
                if msgType == 14 { // 视频直播点赞数推送
                    if rId == weakself.roomId {
                        let admireNum = postData["admireNum"]
                        let hotValue: Int32 = postData["hotValue"] as! Int32
                        weakself.headerView.hotValue = hotValue
                        if let num = admireNum {
                            weakself.liveToolView.admireNum = "\(num)"
                        }
                        weakself.animationForHeart()
                        weakself.perform(#selector(weakself.animationForHeart), with: weakself, afterDelay: 1)
                    }
                }

                if msgType == 11 { // 抽奖活动预告
                    //notice    string    预告内容
                    if rId == weakself.roomId {
                        if let notice = postData["notice"] as? String {
                            weakself.lotteryTextView.alpha = 0
                            weakself.lotteryTextView.isHidden = notice.count > 0 ? false : true
                            weakself.lotteryTextView.notice = notice
                            UIView.animate(withDuration: 0.3) {
                                weakself.lotteryTextView.alpha = 1
                            } completion: { (finished) in

                            }
                        }
                    }
                }

                if msgType == 12 { // 抽奖活动信息 - 抽奖开始
                    if rId == weakself.roomId {
                        weakself.requestLotteryInfo()
                    }
                }
            }
        }
    }


    //MARK: 聊天记录
    @objc
    private func requestChatfeedsall()
    {
        HSCSNewLiveService.requestChatfeedsall(parameters: ["rid": roomId as Any, "sinceKeyChat": sinceKeyOld]) { [weak self] (suc, array, sinceKey) in
            if suc {
                guard let weakself = self else { return }
                weakself.sinceKeyOld = sinceKey
                if weakself.isNewData {
                    weakself.chatList.append(contentsOf: array)
                    weakself.tableView.reloadData()
                    weakself.isNewData = false
                    weakself.scrollToBottom(animated: false)
                } else {
                    if array.count >= 10 {
                        weakself.chatList.insert(contentsOf: array, at: 0)
                    } else {
                        var temp: [HSCSNewLiveChatModel] = []
                        for model in array {
                            if !HSCSNewLiveService.isExistChat(chatArray: weakself.chatList, model: model) {
                                temp.append(model)
                            }
                        }
                        weakself.chatList.insert(contentsOf: temp, at: 0)
                    }
                    weakself.tableView.reloadData()
                    weakself.endMJheader()
                    weakself.scrollToRowAtIndex(index: array.count)
                }
            }
        } failure: { (error) in

        }
    }

    //MARK: 推荐商品列表
    func requestGoodsRecomendList()
    {
        HSCSNewLiveService.requestGoodsRecomendList(parameters: ["": ""]) { [weak self] (suc, array) in
            if suc {
                guard let weakself = self else { return }
                weakself.recomendList = array
            }
        } failure: { (error) in

        }
    }

    //MARK: 用户发言
    func doChatPost(text: String, isAuto: Int)
    {
        var param: Dictionary<String, Any> = ["rid": roomId as Any, "content": text, "isAuto": isAuto]
        if let model = replyModel {
            param["replyId"] = model.show?.chatId
        }
        HSCSNewLiveService.doChatPost(parameters: param) { [weak self] (suc, chatModel) in
            guard let weakself = self else { return }
            if suc {
                weakself.replyModel = nil
                weakself.keyboardBar.placehoder = ""
                weakself.keyboardBar.resignFirstResponder()
                if let model = chatModel {
                    //是否存在
                    if !HSCSNewLiveService.isExistChat(chatArray: weakself.chatList, model: model) {
                        weakself.chatList.append(model)
                        weakself.tableView.reloadData()
                        weakself.scrollToBottom(animated: false)
                    }
                }
            } else {
                weakself.keyboardBar.resignFirstResponder()
            }
        } failure: { (error) in

        }
    }

    @objc
    private func reloadLivingList()
    {
        requestLiveLivingList(rid: roomId)
    }

    func watchBack()
    {
        guard let model = liveActModel else {
            HSCSHUD.showText("回放出错")
            return
        }
//        if HSCSReachability.sharedInstance().isWWAN {
//            HSCSHUD.showText("当前处在非WIFI环境，注意流量消耗哦！")
//        }
        guard let vhallId = model.vhallId else {
            HSCSHUD.showText("回放生成中...")
            return
        }
        watchBackVideo(vhallId: Int32(vhallId)!, title: "", surfaceImg: model.listCoverPic)
    }

    //MARK: 获取当前直播节目
    private func dismantle(liveModel: HSCSNewLiveLivingModel?) -> HSCSNewLiveActModel?
    {
        var actModel: HSCSNewLiveActModel?
        if let model = liveModel {
            for act in model.list {
                if act.actId == model.chief?.actId {
                    actModel = act
                    break
                }
            }
        }
        return actModel
    }

    private func configWithData()
    {
        watchPlayBackView.isHidden = true
        watchLiveVideoView.isHidden = true
        timingView.isHidden = true
        waitView.isHidden = true

        guard let model = liveActModel else {
            timingView.isHidden = false
            liveType = .HSCSNewLiveTypeNone
            timingView.liveType = liveType
            baseView.image = UIImage(named: "new_live_back_bg")
            return
        }
        headerView.liveActModel = model
        guard let chief = liveLivingModel?.chief else { return }
        navBar.title = chief.name
        liveToolView.showAdmire = chief.showAdmire
        liveToolView.admireNum = chief.admireNum
        headerView.hotValue = Int32(chief.hotValue)
        if chief.actStatus == 1 { //直播中
//            if HSCSReachability.sharedInstance().isWWAN {
//                HSCSHUD.showText("当前处在非WIFI环境，注意流量消耗哦！")
//            }
//            if HSCSUserInfoManager.shared().isUnlock {
//                initTimer()
//            }
            liveVideo(vhallId: chief.vhallIdStr, title: model.actName)
        } else {
            if let model = liveActModel {
                if model.actStatus == 3 {
                    //播放结束
                    liveType = .HSCSNewLiveTypeLiveEnd
                    timingView.isHidden = false
                    timingView.liveType = liveType
                    baseView.image = UIImage(named: "new_live_back_bg")
                } else {
                    let nowInterval: TimeInterval = Date().timeIntervalSince1970
                    let startInterval: TimeInterval = model.startTimeStamp
                    let endInterval: TimeInterval = model.endTimeStamp
                    if nowInterval < startInterval {
                        //未开始，倒计时
                        timingView.isHidden = false
                        liveType = .HSCSNewLiveTypeCountDown
                        timingView.isSub = model.isSub
                        timingView.seconds = startInterval - nowInterval
                        timingView.liveType = liveType
                        baseView.image = UIImage(named: "new_live_foreshow_bg")
                    } else {
                        if nowInterval < endInterval {
                            //即将开始
                            timingView.isHidden = false
                            liveType = .HSCSNewLiveTypeWillLive
                            timingView.liveType = liveType
                            baseView.image = UIImage(named: "new_live_foreshow_bg")
                        } else {
                            //播放结束
                            liveType = .HSCSNewLiveTypeLiveEnd
                            timingView.isHidden = false
                            timingView.liveType = liveType
                            baseView.image = UIImage(named: "new_live_back_bg")
                        }
                    }
                }
            }
        }
        wWinButton.isHidden = (liveType == .HSCSNewLiveTypeLiving && roundResultList.count > 0) ? false : true
    }

    //MARK: 开始直播
    private func liveVideo(vhallId: Int32, title: String)
    {
        beginFullScreen()
        baseView.image = UIImage(named: "new_live_living_bg")
        liveType = .HSCSNewLiveTypeLiving
        watchLiveVideoView.removeFromSuperview()
        watchLiveVideoView.close()
        watchLiveVideoView = HSCSWatchLiveVideoView(frame: videoView.bounds)
        videoView.addSubview(watchLiveVideoView)
        watchLiveVideoView.isHidden = false
        watchLiveVideoView.startPlayer(withId: NSNumber(value: vhallId), title: title)
    }

    //MARK: 观看回放
    private func watchBackVideo(vhallId: Int32, title: String, surfaceImg: String)
    {
        beginFullScreen()
        baseView.image = UIImage(named: "new_live_back_bg")
        liveType = .HSCSNewLiveTypeLiving
        watchPlayBackView.removeFromSuperview()
        watchPlayBackView.close()
        watchPlayBackView = HSCSWatchBackVideoView(frame: videoView.bounds)
        videoView.addSubview(watchPlayBackView)
        watchPlayBackView.isHidden = false
        watchPlayBackView.startPlayer(withId: "\(vhallId)", title: title, surfaceImg: surfaceImg) { [weak self] (timeInterval) in
            guard let weakself = self else { return }
            let time = Int32(timeInterval)
            if time % 300 == 0 {
                weakself.showLockAlert()
            }
        }
    }
}

extension HSCSNewLiveViewController
{
    //Jiesuo弹窗
    @objc func showLockAlert()
    {
//        if HSCSUserInfoManager.shared().isUnlock {
//            HSCSVpLocalModel.singleton.pageConfigUrl = HSCSVpLocalModel.singleton.getPageConfigUrl(type: 0)
//            HSCSPushCenter.handleDeepLindUrl(DeepLink_unlock_popup, title: "")
//        }
    }

    // MARK: - 通知事件
    func setNewLiveNotification()
    {
        //键盘弹起
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification).subscribe(onNext: { [weak self] notification in
            //获取键盘的frame
            guard let weakself = self else { return }
            //获取动画执行的时间
            var duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            if duration == nil { duration = 0.25 }
        }).disposed(by: disposeBag)

        //键盘收起
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification).subscribe(onNext: { [weak self] notification in
            var duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            if duration == nil { duration = 0.25 }
            guard let weakself = self else { return }
        }).disposed(by: disposeBag)

        //APP唤醒
        NotificationCenter.default.rx.notification(UIApplication.didBecomeActiveNotification).subscribe(onNext: { [weak self] notification in
            guard let weakself = self else { return }
            weakself.reloadLivingList()
            weakself.sinceKeyOld = ""
            weakself.chatList = []
            weakself.isNewData = true
            weakself.requestChatfeedsall()
        }).disposed(by: disposeBag)
    }

    // MARK: -  点赞动画
    @objc
    func animationForHeart()
    {
        let imageV = UIImageView()
        imageV.frame = CGRect(x: SCREENWITH - HeightScale(height: 40) - 20, y: SCREENHEIGHT - HSCSNewLiveToolView.viewHeight, width: HeightScale(height: 30), height: HeightScale(height: 30))
        imageV.backgroundColor = UIColor.clear
        imageV.clipsToBounds = true
        view.addSubview(imageV)

        // UInt32(0.9)
        let starX: CGFloat = CGFloat(round(Double(arc4random() % 300)))
        var scale = round(Double(arc4random() % 2 + 1))
        let speed = 1 / round(Double(arc4random() % 900)) + 0.4
        let imageName = Int(round(Double(arc4random() % 5)))
        let name = String(format: "live_animation_%d", imageName)
        imageV.image = UIImage(named: name)
        let x = (SCREENWITH - starX) * 1.5
        if scale >= 1.2 {
            scale = 1.2
        }

        UIView.animate(withDuration: 7 * speed, animations: {
            imageV.frame = CGRect(x: x, y: SCREENHEIGHT - 400, width: HeightScale(height: 30) * CGFloat(scale), height: HeightScale(height: 30) * CGFloat(scale))
            imageV.alpha = 0.1
        }, completion: { (_) in
                imageV.removeFromSuperview()
            })
    }

    // MARK: -  滚动到底部
    func scrollToBottom(animated: Bool)
    {
        if chatList.count - 1 > 0 {
            let row: Int = tableView.numberOfRows(inSection: 0) >= chatList.count - 1 ? chatList.count - 1: tableView.numberOfRows(inSection: 0)
            if row > 0 && row < chatList.count {
                tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .bottom, animated: animated)
            }
        }
    }

    // MARK: - 滚动到指定位置
    func scrollToRowAtIndex(index: Int)
    {
        if chatList.count > index && index > 0 {
            tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: false)
        }
    }

    // MARK: - 能否滚动到底部
    func canScroll() -> Bool
    {
        let y = tableView.contentSize.height - self.tableView.contentOffset.y
        return y - maxY > 50 ? false : true
    }

}

extension HSCSNewLiveViewController
{
    // MARK: - 进入全屏
    func beginFullScreen()
    {
        appDelegate.allowRotation = true
    }

    // MARK: - 退出全屏
    func endFullScreen()
    {
        appDelegate.allowRotation = false
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
}

extension HSCSNewLiveViewController: UIKeyboardBarDelegate
{
    func keyboardBar(_ keyboard: UIKeyboardBar!, sendContent message: String!) {
        //发言
        if message.trimming.count == 0 {
            HSCSHUD.showText("请输入内容")
            return
        }
        doChatPost(text: message, isAuto: 0)
    }
}

extension HSCSNewLiveViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var chantModel = chatList[indexPath.row]
        if chantModel.cellHeight > 0 {
            return chantModel.cellHeight
        } else {
            chantModel.cellHeight = HSCSNewLiveChatModel.getCellHeight(contentAtt: chantModel.contentAttr)
            return chantModel.cellHeight
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: HSCSNewLiveChatCell = tableView.dequeueReusableCell(withIdentifier: "HSCSNewLiveChatCell", for: indexPath) as! HSCSNewLiveChatCell
        let chantModel = chatList[indexPath.row]
        cell.chatModel = chantModel
        cell.replyBlock = { [weak self] model in
            guard let weakself = self else { return }
            weakself.replyModel = model
//            if model.show?.user?.uid == Int32(HSCSUserInfoManager.shared().userInfo.userId) {
//                return
//            }
            let name = model.show?.user?.nickname
            weakself.keyboardBar.placehoder = "回复 \(name!)"
            weakself.keyboardBar.textBecomeFirstResponder();
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }

    }
}
