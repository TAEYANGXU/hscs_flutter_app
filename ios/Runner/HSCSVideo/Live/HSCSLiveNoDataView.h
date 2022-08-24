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
//		File Name:		HSCSLiveNoDataView.h
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/12 10:50 AM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSCSLiveNoDataView : UIView

@property (nonatomic, assign) NSInteger status;//1 加载失败 2 直播结束 3 回看结束

@end

NS_ASSUME_NONNULL_END
