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
//        File Name:       UIDevice+Mode.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/12/3 9:07 AM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Mode)

/**
 *  getModeName  判断手机型号
 */
+ (NSString *)getModeName;

+ (NSString *)getModeNameString;

+ (NSString *)getIPAddress:(BOOL)preferIPv4;

///判断是否是iPhoneX系列
+ (BOOL)isIPhoneXFull;

@end

NS_ASSUME_NONNULL_END
