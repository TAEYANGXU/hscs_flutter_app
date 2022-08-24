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
//        File Name:       UIColor+Theme.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/12/3 2:45 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Theme)

@property(class, nonatomic, readonly) UIColor *themeColor;

@property(class, nonatomic, readonly) UIColor *textColor;

@property(class, nonatomic, readonly) UIColor *lineColor;

@property(class, nonatomic, readonly) UIColor *lineBGColor;

@property(class, nonatomic, readonly) UIColor *darkGrayColor;

@property(class, nonatomic, readonly) UIColor *VCBGColor;

@property(class, nonatomic, readonly) UIColor *orangeTextColor;

@end

NS_ASSUME_NONNULL_END
