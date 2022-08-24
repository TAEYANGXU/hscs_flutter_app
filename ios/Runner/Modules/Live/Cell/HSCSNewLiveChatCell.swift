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
//        File Name:       HSCSNewLiveChatCell.swift
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/1 5:44 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

import UIKit
import RxSwift
import RxCocoa
import YYText

class HSCSNewLiveChatCell: UITableViewCell {
    
    public var replyBlock:((HSCSNewLiveChatModel) -> ())?
    
    public let disposeBag = DisposeBag()
    
    public static var lineHeight: CGFloat {
        let layout = YYTextLayout(containerSize: CGSize(width: HSCSNewLiveChatCell.textWidth, height: 9999), text: NSMutableAttributedString(string: "测试"))
        let height = layout!.textBoundingSize.height + 1
        return height
    }
    
    static let textWidth = SCREENWITH - 15 - 100 - 10

    private let bgView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .init(hex: "#B3B3B3", alpha: 0.3)
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        return view
    }()
    
    private let contentLabel: YYLabel = {
        let label = YYLabel(frame: .zero)
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .PingFang_Regular(fontSize: 14)
        return label
    }()
    
    var chatModel : HSCSNewLiveChatModel?
    {
        didSet{
            
            if let model = chatModel
            {
                contentLabel.attributedText = model.contentAttr
                let layout = YYTextLayout(containerSize: CGSize(width: HSCSNewLiveChatCell.textWidth, height: 9999), text: model.contentAttr)
                let height = layout!.textBoundingSize.height + 5
                let width = layout!.textBoundingSize.width + 2
                let lines : Int = Int(height/HSCSNewLiveChatCell.lineHeight)//只有一行 宽度自适应
                bgView.snp.updateConstraints { (make) in
                    make.width.equalTo(lines == 1 ? width + 10 : (SCREENWITH - 115))
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showUIMenuItem()
    {
//        contentView.xy_showMenu(withImages: ["",""], titles: ["复制","举报"], menuType: XYMenuMidNormal) { [weak self] (index) in
//            guard let weakself = self else{ return }
//            if index == 1 {
//                UIPasteboard.general.string = weakself.chatModel!.contentAttr.string
//            }else if index == 2 {
//                HSCSReportView.showReportView(content: weakself.chatModel!.contentAttr.string, roomId: NSNumber(value: 0))
//            }
//        }
    }

    private func makeUpUI()
    {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.width.equalTo(SCREENWITH - 115)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        bgView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        }
        
        let bgTap = UITapGestureRecognizer()
        bgTap.rx.event.subscribe(onNext:{[weak self] ges in
            guard let weakself = self else{ return }
            if weakself.replyBlock != nil {
                weakself.replyBlock!(weakself.chatModel!)
            }
        }).disposed(by: disposeBag)
        bgView.addGestureRecognizer(bgTap)
        
        let longGes = UILongPressGestureRecognizer()
        longGes.minimumPressDuration = 0.8
        longGes.rx.event.subscribe(onNext:{ [weak self] ges in
            guard let weakself = self else{ return }
            if ges.state == .began {
                weakself.showUIMenuItem()
            }
        }).disposed(by: disposeBag)
        bgView.addGestureRecognizer(longGes)
        
    }
}

extension NSMutableAttributedString
{
    class func addTag(tag:String) -> NSMutableAttributedString
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 17))
        label.font = .PingFang_Regular(fontSize: 10)
        label.textColor = .white
        label.backgroundColor = .init(hex: "#FB6700")
        label.layer.cornerRadius = 3
        label.text = tag
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.frame = CGRect(x: 0, y: 0, width: label.requiredWidth + 8, height: 17)
        return NSMutableAttributedString.yy_attachmentString(withContent: label, contentMode: .scaleAspectFit, attachmentSize: label.size, alignTo: .PingFang_Regular(fontSize: 14), alignment: .center)
    }
}
