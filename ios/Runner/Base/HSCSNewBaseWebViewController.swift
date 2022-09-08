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
//        File Name:       HSCSNewBaseWebViewController.swift
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/2/24 4:40 PM
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'


import UIKit
import WebKit
import RxCocoa
import RxSwift
//import JXSegmentedView

class HSCSNewBaseWebViewController: HSCSBaseViewController {

    lazy var wkWebView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.allowsInlineMediaPlayback = true
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        view.navigationDelegate = self
        if #available(iOS 11.0, *) {
            view.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        }
        return view
    }()

    private let shareButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 45, height: 40)
        btn.setImage(UIImage(named: "webview_share_icon"), for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -15)
        btn.isHidden = true
        return btn
    }()

    private lazy var wkBridge: WKWebViewJavascriptBridge = {
        WKWebViewJavascriptBridge.enableLogging()
        let bridge = WKWebViewJavascriptBridge(for: self.wkWebView)!
        bridge.setWebViewDelegate(self)
        return bridge
    }()

    private let progressView: UIProgressView = {
        let view = UIProgressView(frame: .zero)
        view.tintColor = .theme
        view.trackTintColor = .white
        return view
    }()

    private let backButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "icon_back_black"), for: .normal)
        btn.tag = 100
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.contentMode = .scaleToFill
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        return btn
    }()

    private let closeButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "web_close_icon"), for: .normal)
        btn.tag = 101
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.contentMode = .scaleToFill
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -25, bottom: 0, right: 0)
        btn.isHidden = true
        return btn
    }()

    let disposeBag = DisposeBag()

    var canGoBackObservationToken: NSKeyValueObservation?

    @objc var URLString: String?
    {
        didSet {
            loadURLRequest()
        }
    }

    @objc var jumpType: Int = 0
    {
        didSet {
//            wkBridge.registerHandler("isNeedJump") { [weak self] data, responseCallback in
//                guard let weakself = self else { return }
//                if let callBack = responseCallback {
//                    callBack(weakself.jumpType)
//                }
//            }
        }
    }

    var shareData: Dictionary<String, Any>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpNav()
        registerHandler()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupUI()
    {
        view.addSubview(wkWebView)
        wkWebView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        if #available(iOS 11.0, *) {
            view.addSubview(progressView)
            progressView.snp.makeConstraints { make in
                make.top.equalTo(0)
                make.left.right.equalTo(0)
                make.height.equalTo(HeightScale(height: 1.5))
            }
        }
    }

    func loadURLRequest()
    {
        if let urlStr = URLString, urlStr.count > 0 {
            var request = URLRequest(url: URL(string: urlStr)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60 * 60)
            request.setValue("iOS", forHTTPHeaderField: "pl")
            request.setValue(ProjectID, forHTTPHeaderField: "PROJECT")
            request.setValue(AppUtils.nullEmpty(HSCSUserInfoManager.shared().userInfo.token), forHTTPHeaderField: "token")
            wkWebView.load(request)
        }
    }

    func setUpNav()
    {
//        canGoBackObservationToken = wkWebView.observe(\.canGoBack) { (object, change) in
////                self.backButton.isEnabled = self.webView.canGoBack
//            print("canGoBackObservationToken")
//        }
        //返回
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else { return }
            weakself.back(tag: weakself.backButton.tag)
        }).disposed(by: disposeBag)
        //关闭web
        closeButton.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let weakself = self else { return }
            weakself.back(tag: weakself.closeButton.tag)
        }).disposed(by: disposeBag)
        //分享
        shareButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let weakself = self else { return }
            weakself.shareDataAction()
        }).disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton), UIBarButtonItem(customView: closeButton)]
    }

    func back(tag: Int)
    {
        if (tag == 100) {
            if (wkWebView.canGoBack) {
                wkWebView.goBack()
            } else {
                navigationController?.popViewController(animated: true)
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    deinit {
        HSCSLog("deinit", obj: self, line: #line)
        if #available(iOS 11.0, *) {
            wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        }
    }
}

extension HSCSNewBaseWebViewController
{

    func setParamSign() -> Dictionary<String, Any>
    {
        let timestamp = String(format: "\(Int(Date.init().timeIntervalSince1970))")
        let text = String(format: "APPVER=%@&PL=%@&TIMESTAMP=%@", majorVersion, "iOS", timestamp)
        let dict: Dictionary<String, Any> = ["sign": text.md5(), "pl": "iOS", "appver": majorVersion, "timestamp": timestamp]
        return dict
    }
    func registerHandler()
    {
        // H5 bridge引擎初始化完毕#define kJSAPPVER  @"1.0"
        wkBridge.registerHandler("jsBridgeReady") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let callBack = responseCallback {
                callBack(["version": "1.0", "platform": "ios", "api": weakself.wkBridge.registMethodsArrayM as Any])
            }
        }

        // 登录
        wkBridge.registerHandler("login") { data, responseCallback in
            HSCSLoginManager.loginSuccess {
                if let callBack = responseCallback {
                    callBack(true)
                }
            } loginFail: {
                if let callBack = responseCallback {
                    callBack(false)
                }
            }
        }

        // 用户信息
        wkBridge.registerHandler("getUserInfo") { data, responseCallback in
            if HSCSUserInfoManager.shared().isLogined() {
                if let callBack = responseCallback {
                    callBack(HSCSUserInfoManager.shared().userInfo.yy_modelToJSONObject())
                }
            }else{
                if let callBack = responseCallback {
                    callBack("")
                }
            }
        }

        //返回
        wkBridge.registerHandler("webviewBack") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            weakself.back(tag: 100)
        }

        // 关闭 WEBVIEW
        wkBridge.registerHandler("webviewClose") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            weakself.navigationController?.popViewController(animated: true)
        }
        
        // 获取渠道
        wkBridge.registerHandler("getChannel") { [weak self] data, responseCallback in
            guard let _ = self else { return }
            if let callBack = responseCallback {
                callBack("")
            }
        }
        
        // 获取设备号
        wkBridge.registerHandler("getDeviceId") { data, responseCallback in
            if let callBack = responseCallback {
                callBack(NSString.getUUIDByKeyChain())
            }
        }

        // 验签
        wkBridge.registerHandler("getSign") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let callBack = responseCallback {
                callBack(weakself.setParamSign())
            }
        }

        // 获取token接口
        wkBridge.registerHandler("getToken") { data, responseCallback in
            if let callBack = responseCallback {
                callBack(HSCSUserInfoManager.shared().getUserInfo().token)
            }
        }

        // 图片下载
        wkBridge.registerHandler("download") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let url = data as? String {
                weakself.downloadImage(imgUrl: url)
            }
        }

        //VP弹窗
        wkBridge.registerHandler("showVIPAlert") { data, responseCallback in
            HSCSVpLocalModel.singleton.pageConfigUrl = HSCSVpLocalModel.singleton.getPageConfigUrl(type:0)
            HSCSPushCenter.handleDeepLindUrl(DeepLink_unlock_popup_wx, title: "")
        }

        //一次性订阅消息
        wkBridge.registerHandler("subscribenews") { data, responseCallback in
            if let link = data as? String {
                HSCSPushCenter.handleDeepLindUrl(link, title: "")
            }
        }

        //查看大图
        wkBridge.registerHandler("viewImage") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let dict = data as? Dictionary<String, Any> {
                if let imageUrls = dict["imageUrls"] as? Array<String>,imageUrls.count > 0 {
                    if let index = dict["index"] as? Int {
                        HSCSPhotoBrowserManager.showWebImagesAction(imageUrls, currentIndex: index, superView: weakself.view)
                    }else{
                        HSCSPhotoBrowserManager.showWebImagesAction(imageUrls, currentIndex: 0, superView: weakself.view)
                    }
                }else{
                    if let imageUrl = dict["imageUrl"] {
                        HSCSPhotoBrowserManager.showWebImagesAction([imageUrl], currentIndex: 0, superView: weakself.view)
                    }
                }
            }
        }

        //Jiesuo
        wkBridge.registerHandler("showUnLockAlert") { data, responseCallback in
            HSCSVpLocalModel.singleton.pageConfigUrl = HSCSVpLocalModel.singleton.getPageConfigUrl(type:0)
            HSCSPushCenter.handleDeepLindUrl(DeepLink_unlock_popup_wx, title: "")
        }

        wkBridge.registerHandler("setTitle") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let text = data as? String {
                weakself.title = text
            }
        }

        //老师详情
        wkBridge.registerHandler("teacher") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let dict = data as? Dictionary<String, Any> {
                if let teacherId = dict["teacherId"] as? String {
                    let detailVC = HSCSMasterDetailViewController()
                    detailVC.setValue(teacherId, forKey: "teacherId")
                    weakself.navigationController?.pushViewController(detailVC, animated: true)
                }
            }
        }

        //分享
        wkBridge.registerHandler("shareAction") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            weakself.shareDataAction()
        }

        //视频播放
        wkBridge.registerHandler("videoPlay") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let dict = data as? Dictionary<String, Any> {
                if let vhallId = dict["vhallId"] as? String {
                    let detailVC = HSCSLiveWatchBackViewController()
                    detailVC.setValue(vhallId, forKey: "vhallId")
                    weakself.navigationController?.pushViewController(detailVC, animated: true)
                }
            }
        }

        //跳转
        wkBridge.registerHandler("isNeedJump") { [weak self] data, responseCallback in
            guard let weakself = self else { return }
            if let callBack = responseCallback {
                callBack(weakself.jumpType)
            }
        }
        wkBridge.registerHandler("h5JumpApp") { data, responseCallback in
            if let dict = data as? Dictionary<String, Any> {
                if let url = dict["url"] as? String {
                    HSCSPushCenter.handleDeepLindUrl(url, title: "")
                }
            }
        }
        
        wkBridge.registerHandler("goHome") { [weak self] data, responseCallback in
            guard let _ = self else { return }
            HSCSLoginService.doUserLogout(["":""]) { suc, msg in
                } failure: { error in }
        }
    }

    //分享
    func shareDataAction()
    {
        if let shareDict = shareData
        {
            let shareTitle = shareDict["title"] as? String
            let shareUrl = shareDict["link"] as? String
            let shareContent = shareDict["desc"] as? String
            let shareImageUrl = shareDict["imgUrl"] as? String
            let course_id = shareDict["course_id"] as? String
            let trackId = shareDict["trackId"] as? String
            let plate = shareDict["plate"] as? String
            let articleId = shareDict["articleId"] as? String
            if let track = trackId, let pa = plate, let courseId = course_id {
                HSCSSensorsAnalyticsManager.track(withId: track, param: ["plate": pa, "course_id": courseId, "cs_user_id": HSCSUserInfoManager.shared().userInfo.userId])
            }
            if let shareTitle = shareTitle, let shareContent = shareContent, let shareUrl = shareUrl {
                HSCSShareCenter.share(with: HSCSShareView(frame: .zero), title: shareTitle, content: shareContent, imageUrl: String.nullEmpty(text: shareImageUrl), url: shareUrl) { type in
                    if let aId = articleId {
                        HSCSNewMineService.doPostUserShare(parameters: ["id": aId as Any]) { suc in } failure: { error in }
                    }
                }
            }
        }
    }

    //MARK: - 下载图片
    func downloadImage(imgUrl: String)
    {
        SDWebImageManager.shared.loadImage(with: URL(string: imgUrl), options: .lowPriority) { receivedSize, expectedSize, targetURL in
        } completed: { [weak self] image, data, error, cacheType, finished, imageURL in
            guard let weakself = self else { return }
            if let img = image {
                UIImageWriteToSavedPhotosAlbum(img, weakself, #selector(weakself.image(image: didFinishSavingWithError: contextInfo:)), nil)
            }
        }
    }

    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject)
    {
        if let _ = error {
            HSCSHUD.showErrorText("保存图片失败")
        } else {
            HSCSHUD.showSuccessText("保存图片成功")
        }
    }
}

extension HSCSNewBaseWebViewController
{
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if wkWebView.isEqual(object) && keyPath == "estimatedProgress" {
            progressView.progress = Float(self.wkWebView.estimatedProgress)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

@available(iOS 13.0, *)
extension HSCSNewBaseWebViewController: WKNavigationDelegate
{
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {

    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {

    }
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let t = webView.title, t.count > 0 {
            title = t
        }
        closeButton.isHidden = !wkWebView.canGoBack
        UIView.animate(withDuration: 0.4) {
            self.progressView.alpha = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let weakself = self else { return }
            weakself.wkBridge.callHandler("getShareData", data: ["": ""]) { responseData in
                if let t = webView.title, t.count > 0 {
                    weakself.title = t
                }
                if let response = responseData as? Dictionary<String, Any> {
                    weakself.shareButton.isHidden = false
                    weakself.shareData = response
                }
            }
        }
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("didFailProvisionalNavigation")
    }
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {

    }
    // 在收到响应后，决定是否跳转 -> 默认允许
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //允许跳转
        decisionHandler(.allow)
        //不允许跳转
//        decisionHandler(.cancel)
    }

    // 在发送请求之前，决定是否跳转 -> 默认允许
    @available(iOS 13.0, *)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        decisionHandler(.allow, preferences)
    }

    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
}


//extension HSCSNewBaseWebViewController :JXSegmentedListContainerViewListDelegate
//{
//    func listView() -> UIView
//    {
//        return view
//    }
//}
