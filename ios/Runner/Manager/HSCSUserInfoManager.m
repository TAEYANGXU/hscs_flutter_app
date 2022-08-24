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
//        File Name:       HSCSUserInfoManager.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2020/12/7 3:38 PM
//
//        Copyright © 2020 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "HSCSUserInfoManager.h"
#import <XyWidget/NSUserDefaults+Assist.h>
#import "Runner-Swift.h"
#import <YYModel/YYModel.h>

NSString *const kUSER_INFROMATION   = @"kUSER_INFROMATION";
NSString *const kUSER_AGREEMENT     = @"kUSER_AGREEMENT";
NSString *const kUSER_HOMEGUIDE     = @"kUSER_HOMEGUIDE";
NSString *const kUSER_ROOMINFO      = @"kUSER_ROOMINFO";
NSString *const kUSER_DEVICEUNLOCK  = @"kUSER_DEVICEUNLOCK";

@interface HSCSUserInfoManager ()



@end

@implementation HSCSUserInfoManager

+ (HSCSUserInfoManager *)sharedManager
{
    static HSCSUserInfoManager *sharedManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (BOOL)isLogined
{
    HSCSUserInfoModel *user = [self getUserInfo];
    if ([AppUtils nullEmpty:user.token].length) {
        return YES;
    }else{
        return NO;
    }
}

-(BOOL)isUnlock
{
    if (![self isLogined]) {
        return YES;
    }
    return self.userInfo.role.intValue == 0 ? YES : NO;
}

-(BOOL)isVp
{
    if (![self isLogined]) {
        return NO;
    }
    return self.userInfo.isVip.boolValue;
}

-(BOOL)isTeacher
{
    if (![self isLogined]) {
        return NO;
    }
    return self.userInfo.isTeacher;
}

-(BOOL)bindWecChat
{
    return [AppUtils nullEmpty:self.userInfo.openid].length > 0 ? YES : NO;
}

-(BOOL)canLetter
{
    if (self.isVp) {
        return YES;
    }else{
        return NO;
    }
//    if (self.userInfo.isOldUser.boolValue) {
//        //老用户
//        if (self.isVp) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }else{
//        //新用户
//        if (self.userInfo.role.integerValue == 200) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }
}

-(NSInteger)level
{
    if (![self isLogined]) {
        return 0;
    }
    return self.userInfo.role.intValue;
}

- (NSString *)levelName
{
    if (![self isLogined]) {
        return @"";
    }
    return [AppUtils nullEmpty:self.userInfo.role_text];
}

-(NSString *)levelNum
{
    if ([AppUtils nullEmpty:self.token].length == 0) {
        return @"0";
    }
    NSString *text = @"1";
    switch (self.userInfo.role.intValue) {
        case 100:
            text = @"2";
            break;
        case 150:
            text = @"3";
            break;
        case 200:
            text = @"4";
            break;
        case 125:
            text = @"5";
            break;
        case 300:
            text = @"6";
            break;
        default:
            break;
    }
    return  text;
}

-(NSString *)token
{
    return [AppUtils nullEmpty:self.userInfo.token];
}

-(HSCSUserInfoModel *)userInfo
{
    return [self getUserInfo];
}

-(BOOL)userAgreement
{
    id agree = [NSUserDefaults valueWithKey:kUSER_AGREEMENT];
    return agree;
}

-(BOOL)showGuidePage
{
    id agree = [NSUserDefaults valueWithKey:kUSER_HOMEGUIDE];
    return agree;
}

-(BOOL)isDeviceUnlock
{
    if ([self isLogined] && ![self isUnlock]) {
        return YES;//已解
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL  agree = [defaults boolForKey:kUSER_DEVICEUNLOCK];
    return agree;
}

/** 更新用户信息 **/
- (void)saveUserInfo:(HSCSUserInfoModel *)user
{
    if (user) {
        id data = [user yy_modelToJSONObject];
        [NSUserDefaults saveValue:data forKey:kUSER_INFROMATION];
        if (user.chatRoomModel) {
            id data2 = [user.chatRoomModel yy_modelToJSONObject];
            [NSUserDefaults saveValue:data2 forKey:kUSER_ROOMINFO];
        }
    }
}

- (HSCSUserInfoModel *)getUserInfo
{
    id json = [NSUserDefaults valueWithKey:kUSER_INFROMATION];
    HSCSUserInfoModel *user = [HSCSUserInfoModel yy_modelWithJSON:json];
    id roomJson = [NSUserDefaults valueWithKey:kUSER_ROOMINFO];
    HSCSUserChatRoomModel *room = [HSCSUserChatRoomModel yy_modelWithJSON:roomJson];
    user.chatRoomModel = room;
    return user;
}

/** 用户同意协议 **/
- (void)saveUserAgreement:(BOOL)agreement
{
    if (agreement) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:agreement forKey:kUSER_AGREEMENT];
        [userDefaults synchronize];
    }
}

/** VIP专区引导页 **/
- (void)saveshowGuidePage:(BOOL)show
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:show forKey:kUSER_HOMEGUIDE];
    [userDefaults synchronize];
}

/** 设备是否Jiesuo **/
- (void)saveDeviceUnlock:(BOOL)unLock
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:unLock forKey:kUSER_DEVICEUNLOCK];
    [userDefaults synchronize];
}

/** 退出手机登录 **/
- (void)loginOut
{
    HSCSUserInfoModel *user = [self getUserInfo];
    user.token = @"";
    user.role = @(0);
    user.isTeacher = NO;
    [self saveUserInfo:user];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kAppWealthTextLiveNotification object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kAppUserLoginOutNotification object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kAppRefreshHomeNotification object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kAppRefreshChatListNotification object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kAppWealthTextLiveNotification object:nil];
}

/** 手机登录失效 **/
- (void)userLoginLose
{
    [HSCSHUD showText:@"您的账号已在其他设备登录"];
    [self loginOut];
    [self reloadTabar];
}

- (void)reloadTabar
{
//    NSString *str = NSStringFromClass(self.class);
//    if ([str isEqualToString:@"HSCSLiveMessageViewController"] || [str isEqualToString:@"HSCSNewMineViewController"] || [str isEqualToString:@"HSCSMineViewController"] || [self isKindOfClass:[HSCSHomeViewController class]] || [self isKindOfClass:[HSCSNewHomeViewController class]] || [self isKindOfClass:[HSCSNewVpViewController class]] || [self isKindOfClass:[HSCSVpWealthCircleViewController class]]) {
//        HSCSMainViewController *tabVC = ((HSCSAppDelegate *)[UIApplication sharedApplication].delegate).tabVC;
//        [tabVC getUnlockData];
//    }
}

-(UIImage *)roleImage:(NSInteger)role
{
    UIImage *image = [UIImage imageNamed:@"mine_user_level_5_bg"];
    switch (role) {
        case 100:
            image = [UIImage imageNamed:@"mine_user_level_6_bg"];
            break;
        case 125:
            image = [UIImage imageNamed:@"mine_user_level_1_bg"];
            break;
        case 150:
            image = [UIImage imageNamed:@"mine_user_level_2_bg"];
            break;
        case 200:
            image = [UIImage imageNamed:@"mine_user_level_3_bg"];
            break;
        case 300:
            image = [UIImage imageNamed:@"mine_user_level_4_bg"];
            break;
        default:
            break;
    }
    if ([AppConfig sharedManager].inHSSH) {
        image = [UIImage imageNamed:@"nome"];
    }
    return  image;
}

-(CGSize)roleImgSize:(NSInteger)role
{
    UIImage *image = [UIImage imageNamed:@"mine_user_level_5_bg"];
    switch (role) {
        case 100:
            image = [UIImage imageNamed:@"mine_user_level_6_bg"];
            break;
        case 125:
            image = [UIImage imageNamed:@"mine_user_level_1_bg"];
            break;
        case 150:
            image = [UIImage imageNamed:@"mine_user_level_2_bg"];
            break;
        case 200:
            image = [UIImage imageNamed:@"mine_user_level_3_bg"];
            break;
        case 300:
            image = [UIImage imageNamed:@"mine_user_level_4_bg"];
            break;
        default:
            break;
    }
    if ([AppConfig sharedManager].inHSSH) {
        image = [UIImage imageNamed:@"nome"];
    }
    return image.size;
}

@end


@implementation HSCSUserInfoModel

-(NSString *)userId
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:[AppUtils nullEmpty:self.uid] options:0];
    return [AppUtils nullEmpty:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
}

-(UIImage *)roleBGImage
{
    if ([AppUtils nullEmpty:self.token].length == 0) {
        return [UIImage imageNamed:@"user_level_visitor_bg"];
    }
    UIImage *image = [UIImage imageNamed:@"user_level_visitor_bg"];
    switch (self.role.intValue) {
        case 100:
            image = [UIImage imageNamed:@"user_level_general_bg"];
            break;
        case 125:
            image = [UIImage imageNamed:@"user_level_standard_bg"];
            break;
        case 150:
            image = [UIImage imageNamed:@"user_level_gold_bg"];
            break;
        case 200:
            image = [UIImage imageNamed:@"user_level_diamond_bg"];
            break;
        case 300:
            image = [UIImage imageNamed:@"user_level_black_diamond_bg"];
            break;
        default:
            break;
    }
    return  image;
}

-(UIImage *)roleImage
{
    return  [[HSCSUserInfoManager sharedManager] roleImage:self.role.intValue];
}

-(CGSize)roleImgSize
{
    return [[HSCSUserInfoManager sharedManager] roleImgSize:self.role.intValue];
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"chatRoomModel":[HSCSUserChatRoomModel class]};
}

@end

@implementation HSCSUserChatRoomModel

@end

