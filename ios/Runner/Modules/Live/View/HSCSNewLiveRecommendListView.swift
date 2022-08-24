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
//        File Name:       HSCSNewLiveRecommendListView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/12 2:40 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxCocoa
import RxSwift

class HSCSNewLiveRecommendListView: UIView {

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.white
        return contentView
    }()
    
    private let  topLine : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lineBG
        return view
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel.create(textColor: .text, font: .PingFang_Medium(fontSize: 18), textAlignment: .center)
        label.text = "花生服务尊享"
        return label
    }()
    
    private let closeButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "new_live_close_icon"), for: .normal)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(HSCSNewLiveRecommendCell.classForCoder(), forCellReuseIdentifier: "HSCSNewLiveRecommendCell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private let disposeBag = DisposeBag()
    
    var list: Array<HSCSGoodsRecomendModel> = []
    {
        didSet{
            tableView.reloadData()
            let height = SCREENHEIGHT - HeightScale(height: 150)
            let viewHeight = HeightScale(height: 158) * CGFloat(list.count) + HeightScale(height: 100)
            contentView.snp.updateConstraints { (make) in
                make.size.equalTo(CGSize(width: SCREENWITH, height: viewHeight > height ? height : viewHeight))
            }
            if list.count == 0 {
                contentView.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize(width: SCREENWITH, height: 400))
                }
//                tableView.showBlankPageView(withImage: "", content: "暂无商品")
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
        closeButton.rx.tap.subscribe(onNext:{ [weak self] in
            guard let weakself = self else{ return }
            weakself.hide()
        }).disposed(by: disposeBag)
        
        addSubview(contentView)
        contentView.size = CGSize(width: SCREENWITH, height: SCREENHEIGHT - HeightScale(height: 150))
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.size.equalTo(CGSize(width: SCREENWITH, height: SCREENHEIGHT - HeightScale(height: 250)))
        }
        UIView.bezierPathWithRounded(stateView: contentView, corners: [.topLeft,.topRight], cornerRadii: CGSize(width: HeightScale(height: 12), height: HeightScale(height: 12)))
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(HeightScale(height: 200))
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(HeightScale(height: 45))
            make.top.equalTo(0)
        }
        
        contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.right.equalTo(0)
            make.size.equalTo(CGSize(width: HeightScale(height: 50), height: HeightScale(height: 45)))
        }
        
        contentView.addSubview(topLine)
        topLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(1)
            make.top.equalTo(HeightScale(height: 44))
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: HeightScale(height: 45), left: 0, bottom: 0, right: 0))
        }
    }
    
    class func showRecommendView(array:Array<HSCSGoodsRecomendModel>)
    {
        let window = UIApplication.shared.keyWindow
        let view = HSCSNewLiveRecommendListView(frame: CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWITH, height: SCREENHEIGHT))
        view.list = array
        window?.addSubview(view)
        UIView.animate(withDuration: 0.2) {
            view.frame = CGRect(x: 0, y: 0, width: SCREENWITH, height: SCREENHEIGHT)
        } completion: { (finish) in
            view.backgroundColor = UIColor.init(hex: "#000000", alpha: 0.1)
        }
    }
    
    func hide()
    {
        self.backgroundColor = .clear
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWITH, height: SCREENHEIGHT)
        } completion: { (finish) in
            self.removeFromSuperview()
        }
    }
}

extension HSCSNewLiveRecommendListView: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HeightScale(height: 158)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: HSCSNewLiveRecommendCell = tableView.dequeueReusableCell(withIdentifier: "HSCSNewLiveRecommendCell", for: indexPath) as! HSCSNewLiveRecommendCell
        cell.recomendModel = list[indexPath.row]
        cell.openWechat = { [self] _ in
            if AppConfig.sharedManager().inHSSH {
                return
            }
//            HSCSSensorsAnalyticsManager.track(withId: "Products_Featured", param: ["goods_id": cell.recomendModel!.goodId, "user_grade": HSCSUserInfoManager.shared().levelNum,"cs_user_id":HSCSUserInfoManager.shared().userInfo.userId,"goods_name":cell.recomendModel!.name,"goods_price":cell.recomendModel!.price])
//            HSCSWechatManager.shareInstance().openWechat()
            hide()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let model = list[indexPath.row]
//        HSCSSensorsAnalyticsManager.track(withId: "Products_Featured", param: ["goods_id": model.goodId, "user_grade": HSCSUserInfoManager.shared().levelNum,"cs_user_id":HSCSUserInfoManager.shared().userInfo.userId,"goods_name":model.name,"goods_price":model.price])
//        HSCSWechatManager.shareInstance().openWechat()
        hide()
    }
}
