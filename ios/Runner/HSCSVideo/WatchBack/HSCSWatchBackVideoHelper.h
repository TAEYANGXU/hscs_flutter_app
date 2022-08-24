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
//        File Name:       HSCSWatchBackVideoHelper.h
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/4/27 10:08 AM
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSCSWatchBackVideoHelper : NSObject

+ (HSCSWatchBackVideoHelper *)shareInstance;

- (double)timeWithKey:(NSString *)key;

- (void)saveTime:(double)time forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
