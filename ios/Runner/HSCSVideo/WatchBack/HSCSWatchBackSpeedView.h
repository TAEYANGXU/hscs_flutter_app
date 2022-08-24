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
//        File Name:       HSCSWatchBackSpeedView.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2021/7/6 5:54 PM
//
//        Copyright © 2021 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SpeedSelectBlock)(NSInteger index);

@interface HSCSWatchBackSpeedView : UIView

- (void)makeLayout:(CGFloat)viewHeight;

@property (nonatomic,copy)  SpeedSelectBlock    speedSelectBlock;

@end

NS_ASSUME_NONNULL_END
