//
//  AppConfig.h
//  HSCSApp
//
//  Created by 徐琰璋 on 2018/12/6.
//  Copyright © 2018 利事果. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppConfig : NSObject

+ (AppConfig *)sharedManager;

//服务器地址
@property(nonatomic,strong) NSString                    *clientServer;
//服务器地址 -- 社区
@property(nonatomic,strong) NSString                    *clientQSServer;
//版本更新
@property(nonatomic,strong) NSString                    *clientLanyiServer;
//青松视频直播室Socket地址
@property(nonatomic,strong) NSString                    *clientLiveSocketServer;
//H5
@property(nonatomic,strong) NSString                    *clientH5Server;
//设备token
@property(nonatomic,strong) NSString                    *deviceToken;
//jpush
@property(nonatomic,strong) NSString                    *registrationID;
//app是否最新版本
@property(nonatomic,assign,readonly) BOOL               isLastVersion;
//app当前版本
@property(nonatomic,strong,readonly) NSString           *currentVersion;
//App Store版本
@property(nonatomic,strong) NSString                    *lastVersion;

@property(nonatomic,assign) BOOL                        inHSSH;
/** app名称 */
@property(nonatomic,strong) NSString                    *appDisplayName;
/** build版本 */
@property(nonatomic,strong) NSString                    *appBuild;
/** BundleID */
@property(nonatomic,strong) NSString                    *appBundleID;
/** api切换 */
@property(nonatomic,assign) NSInteger                   URLType;
/** 渠道编号 */
@property(nonatomic,strong) NSString                    *CHANNEL;

@property(nonatomic,strong) NSString                    *vipTabTitle;

@property(nonatomic,strong) NSString                    *wechatUserName;//小程序的原始ID

@property(nonatomic,strong) NSString                    *UserAgent;

@end

NS_ASSUME_NONNULL_END
