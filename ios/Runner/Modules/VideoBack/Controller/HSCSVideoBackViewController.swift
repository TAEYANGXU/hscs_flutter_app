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
//        File Name:       HSCSVideoBackViewController.swift
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/10/17 13:07
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import ObjectMapper
import RxSwift
import RxCocoa

class VideoSectionView: UIView
{
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .init(hex: "#373737")
        label.text = "更多视频"
        label.font = .PingFang_Bold(fontSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI()
    {
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.bottom.equalTo(-5)
            make.right.equalTo(0)
            make.height.equalTo(HeightScale(height: 22))
        }
    }
}

class HSCSVideoBackViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(HSCSFreeListCell.classForCoder(), forCellReuseIdentifier: "HSCSFreeListCell")
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .vcbg
        if #available(iOS 15.0, *) {
            table.sectionHeaderTopPadding = 0
        }
        return table
    }()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private let videoView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: UIDevice.isiPhoneXAll() ? 39 : 20, width: SCREENWITH, height: HeightScale(height: 210)))
        view.backgroundColor = .clear
        return view
    }()
    
    //回看控件
    private lazy var watchPlayBackView: HSCSWatchBackVideoView = {
        let view = HSCSWatchBackVideoView(frame: videoView.bounds)
        return view
    }()
    
    private let backButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "video_back_withe_icon"), for: .normal)
        return btn
    }()
    
    let disposeBag = DisposeBag()
    var model: HSCSVpReviewListModel?
    var currentIndex: Int = 0
    
    @objc var videoJson: Dictionary<String,Any>? {
        didSet{
            guard let json = videoJson else { return }
            model  = Mapper<HSCSVpReviewListModel>().map(JSON: json)
            if let model = model {
                print("vTitle = \(model.vTitle)")
//                print("videoJson = \(videoJson)")
                print("model.index = \(model.index)")
                currentIndex = model.index
                print("currentIndex = \(currentIndex)")
                watchBackVideo(vUrl: model.vUrl, title: model.vTitle, surfaceImg: model.vCoverImgUrl)
            }
        }
    }
    
    private var page: Int = 1
    private let pageSize: Int = 20
    var list: Array<HSCSVpReviewListModel> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        requestVideoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        endFullScreen()
    }
    
    func setupUI()
    {
        view.backgroundColor = .white
        fd_prefersNavigationBarHidden = true
        view.addSubview(videoView)
//        videoView.addSubview(watchPlayBackView);
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(UIDevice.isiPhoneXAll() ? 39 : 20)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: 45, height: kNavigationBarHeight - (UIDevice.isiPhoneXAll() ? 48 : 20)))
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(videoView.snp.bottom).offset(0)
            make.left.right.bottom.equalTo(0)
        }
        
        backButton.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else { return  }
            weakself.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
    //MARK: 观看回放
    private func watchBackVideo(vUrl: String, title: String, surfaceImg: String)
    {
        beginFullScreen()
        watchPlayBackView.removeFromSuperview()
        watchPlayBackView.close()
        watchPlayBackView = HSCSWatchBackVideoView(frame: videoView.bounds)
        videoView.addSubview(watchPlayBackView)
        
        watchPlayBackView.nextPlayer(withId: "\(vUrl)", title: title, surfaceImg: surfaceImg) { [weak self]  isFullScreen in
            guard let weakself = self else { return  }
            weakself.nextVideo()
        } nextVideoBlock: { [weak self]  isFullScreen in
            guard let weakself = self else { return  }
            weakself.nextVideo()
        }
    }
    
    func nextVideo(){
        currentIndex += 1
        if currentIndex < list.count {
            model = list[currentIndex]
            print("currentIndex = \(currentIndex)")
            if let model = model {
                watchBackVideo(vUrl: model.vUrl, title: model.vTitle, surfaceImg: model.vCoverImgUrl)
            }
        }
    }
    
    deinit {
        watchPlayBackView.close()
    }
}

extension HSCSVideoBackViewController
{
    @objc func requestVideoList()
    {
        HSCSVideoService.requestVideoListByType(parameters: ["actType":2,"page":page,"pageSize":pageSize]) { [weak self] suc, array in
            guard let weakself = self else { return  }
            weakself.page += 1
            weakself.list.append(contentsOf: array)
            weakself.tableView.reloadData()
            weakself.tableView.mj_footer = array.count >= 10 ? MJRefreshAutoNormalFooter.init(refreshingTarget: weakself, refreshingAction: #selector(weakself.requestVideoList)) : nil
        } failure: { error in
            
        }
    }
}


extension HSCSVideoBackViewController
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

extension HSCSVideoBackViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HeightScale(height: 40)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return VideoSectionView(frame: CGRect(x: 0, y: 0, width: SCREENWITH, height: HeightScale(height: 40)))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeightScale(height: 95)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HSCSFreeListCell = tableView.dequeueReusableCell(withIdentifier: "HSCSFreeListCell", for: indexPath) as! HSCSFreeListCell
        if indexPath.row < list.count {
            let model = list[indexPath.row]
            cell.reviewModel = model
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.row < list.count {
            model = list[indexPath.row]
            if let model = model {
                currentIndex = indexPath.row
                watchBackVideo(vUrl: model.vUrl, title: model.vTitle, surfaceImg: model.vCoverImgUrl)
            }
        }
    }
}
