//
//  AppConfig.m
//  HSCSApp
//
//  Created by 徐琰璋 on 2018/12/6.
//  Copyright © 2018 利事果. All rights reserved.
//

#import "AppConfig.h"
#import <XyWidget/NSUserDefaults+Assist.h>
//#import <XyWidget/ConstHeader.h>
#import "AppConst.h"
#import "AppUtils.h"

static NSString *kURLType       = @"kURLType";
static NSString *LASTVERSION    = @"LASTVERSION";
static NSString *FIRSTINSTALL   = @"FIRSTINSTALL";
static NSString *KDeviceToken   = @"KDeviceToken";
static NSString *KRegistrationID   = @"KRegistrationID";
static NSString *kVipTabTitle   = @"kVipTabTitle";

@interface AppConfig()

@property(nonatomic,assign) NSInteger                   URL_Type;
@property(nonatomic,assign) BOOL                        isFirstInstall;

@end

@implementation AppConfig

+ (AppConfig *)sharedManager
{
    static AppConfig *sharedManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init {
    self = [super init];
    if ( self ) {
        [self load];
    }
    return self;
}

/**
 *  加载本地数据
 */
-  (void)load
{
    [self loadDefault];
    [self loadServer];
}

- (void)loadDefault
{
    
    NSString *title = [NSUserDefaults valueWithKey:kVipTabTitle];
    if ([AppUtils nullEmpty:title].length == 0) {
        [NSUserDefaults saveValue:@"专区" forKey:kVipTabTitle];
    }
    
    if (!self.isFirstInstall) {
        self.isFirstInstall = YES;
        self.URL_Type = 1;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:@(1) forKey:FIRSTINSTALL];
        [defaults setValue:@(self.URL_Type) forKey:kURLType];
        [defaults synchronize];
    }else{
        //取得本地缓存
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSInteger type = [defaults integerForKey:kURLType];
        self.URL_Type = type;
    }
}

/**
 初始化服务器地址
 */
- (void)loadServer
{
    if (self.URL_Type == 1){
        self.clientServer = HSCS_SERVER_PRO;
        self.clientLanyiServer = HSCS_SERVER_VERVION_PRO;
        self.clientLiveSocketServer = LIVE_VIDEO_SOCKET_PRO;
        self.clientQSServer = HSCS_SERVER_QS_PRO;
        self.clientH5Server = HSCS_SERVER_H5_PRO;
        self.wechatUserName = WechatUserNameId_PRO;
        self.CHANNEL = HSCSCHANNEL;
    }else if (self.URL_Type == 2){
        self.clientServer = HSCS_SERVER_TES;
        self.clientLanyiServer = HSCS_SERVER_VERVION_TES;
        self.clientLiveSocketServer = LIVE_VIDEO_SOCKET_TES;
        self.clientQSServer = HSCS_SERVER_QS_TES;
        self.clientH5Server = HSCS_SERVER_H5_TES;
        self.wechatUserName = WechatUserNameId_DEV;
        self.CHANNEL = HSCSTESCHANNEL;
    }else if (self.URL_Type == 3){
        self.clientServer = HSCS_SERVER_DEV;
        self.clientLanyiServer = HSCS_SERVER_VERVION_DEV;
        self.clientLiveSocketServer = LIVE_VIDEO_SOCKET_DEV;
        self.clientQSServer = HSCS_SERVER_QS_DEV;
        self.clientH5Server = HSCS_SERVER_H5_DEV;
        self.wechatUserName = WechatUserNameId_DEV;
        self.CHANNEL = HSCSTESCHANNEL;
    }
    
    NSLog(@"服务器地址:%@",self.clientServer);
}

-(void)setURLType:(NSInteger)URLType
{
    self.URL_Type = URLType;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@(URLType) forKey:kURLType];
    [defaults synchronize];
}

-(NSInteger)URLType
{
    return self.URL_Type;
}

-(NSString *)appDisplayName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

-(NSString *)appBuild
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

-(BOOL)isLastVersion
{
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleShortVersionString"];
    return [self.currentVersion compare:lastVersion options:NSNumericSearch] == NSOrderedDescending || !lastVersion;
}

-(BOOL)isFirstInstall
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber  *firstInstall = [defaults valueForKey:FIRSTINSTALL];
    return firstInstall.boolValue;
}

-(void)setLastVersion:(NSString *)lastVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:lastVersion forKey:LASTVERSION];
    [defaults synchronize];
}

-(NSString *)lastVersion
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVer = [defaults valueForKey:LASTVERSION];
    return lastVer ? lastVer : @"0";
}

-(NSString *)currentVersion
{
    NSString *infoPath = [[NSBundle mainBundle]pathForResource:@"Info.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:infoPath];
    NSString *currentVersion = dict[@"CFBundleShortVersionString"];
    return [AppUtils nullEmpty:currentVersion];
}

-(void)setDeviceToken:(NSString *)deviceToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:deviceToken forKey:KDeviceToken];
    [defaults synchronize];
}

-(NSString *)deviceToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults valueForKey:KDeviceToken];
    return [AppUtils nullEmpty:token];
}

-(void)setRegistrationID:(NSString *)registrationID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:registrationID forKey:KRegistrationID];
    [defaults synchronize];
}

-(NSString *)registrationID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *registrationID = [defaults valueForKey:KRegistrationID];
    return [AppUtils nullEmpty:registrationID];
}

-(NSString *)vipTabTitle
{
    id agree = [NSUserDefaults valueWithKey:kVipTabTitle];
    return  agree;
}

@end
