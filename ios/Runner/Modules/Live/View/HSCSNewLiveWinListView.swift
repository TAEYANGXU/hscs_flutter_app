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
//        File Name:       HSCSNewLiveWinListView.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/8/12 10:04 AM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxSwift
import RxCocoa

class HSCSNewLiveWinListView: UIView {
    
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
        label.text = "中奖名单"
        return label
    }()
    
    private let closeButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "new_live_win_close_icon"), for: .normal)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.register(HSCSNewLiveWinListCell.classForCoder(), forCellReuseIdentifier: "HSCSNewLiveWinListCell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    private let disposeBag = DisposeBag()
    
    //所有中奖名单
    var list : [HSCSNewLiveRoundResultModel] = []
    {
        didSet{
            tableView.reloadData()
            let height = SCREENHEIGHT - HeightScale(height: 230)
            var cellHeight : CGFloat = HeightScale(height: 90)
            for model in list {
                cellHeight += model.cellHeight
            }
            contentView.snp.updateConstraints { (make) in
                make.size.equalTo(CGSize(width: SCREENWITH, height: cellHeight > height ? height : cellHeight))
            }
            if list.count == 0 {
                contentView.snp.updateConstraints { (make) in
                    make.size.equalTo(CGSize(width: SCREENWITH, height: HeightScale(height: 350)))
                }
//                tableView.showBlankPageView(withImage: "", content: "暂无数据")
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
    
    class func showWinListView(array:[HSCSNewLiveRoundResultModel])
    {
        let window = UIApplication.shared.keyWindow
        let view = HSCSNewLiveWinListView(frame: CGRect(x: 0, y: SCREENHEIGHT, width: SCREENWITH, height: SCREENHEIGHT))
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

extension HSCSNewLiveWinListView : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let m = list[indexPath.row]
        return m.cellHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: HSCSNewLiveWinListCell = tableView.dequeueReusableCell(withIdentifier: "HSCSNewLiveWinListCell", for: indexPath) as! HSCSNewLiveWinListCell
        let m = list[indexPath.row]
        cell.model = m
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
