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
//        File Name:       HSCSWatchBackVideoHelper.m
//        Product Name:    HSCSApp
//        Author:          yanzhangxu@利事果科技
//        Swift Version:   5.0
//        Created Date:    2022/4/27 10:08 AM
//
//        Copyright © 2022 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "HSCSWatchBackVideoHelper.h"
#import <XyWidget/NSUserDefaults+Assist.h>
#import <XyWidget/ConstHeader.h>
#import "Masonry.h"
#define kHSCSWatchBackVideo @"kHSCSWatchBackVideo"

@interface HSCSWatchBackVideoHelper ()

@property (strong,nonatomic) NSMutableDictionary *timeDict;

@end

@implementation HSCSWatchBackVideoHelper

+ (HSCSWatchBackVideoHelper *)shareInstance
{
    static HSCSWatchBackVideoHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.timeDict = [[NSMutableDictionary alloc] init];
        NSDictionary *dict = [NSUserDefaults valueWithKey:kHSCSWatchBackVideo];
        if (dict) {
            [self.timeDict setDictionary:dict];
        }
    }
    return self;
}

- (double)timeWithKey:(NSString *)key
{
    if (key) {
        double time = [self.timeDict[key] doubleValue];
        return  time;
    }
    return 0;
}

- (void)saveTime:(double)time forKey:(NSString *)key
{
    if (key) {
        [self.timeDict setValue:@(time) forKey:key];
        [NSUserDefaults saveValue:self.timeDict forKey:kHSCSWatchBackVideo];
    }
}

@end
