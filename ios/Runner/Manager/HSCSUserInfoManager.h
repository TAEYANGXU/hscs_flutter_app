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
//        File Name:       HSCSUserInfoManager.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果科技
//        Swift Version:   5.0
//        Created Date:    2020/12/7 3:38 PM
//
//        Copyright © 2020 利事果科技.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <Foundation/Foundation.h>
#import <XyWidget/ConstHeader.h>

NS_ASSUME_NONNULL_BEGIN
@class HSCSUserInfoModel,HSCSHomeAppModel,HSCSUserChatRoomModel;
@interface HSCSUserInfoManager : NSObject

+ (HSCSUserInfoManager *)sharedManager;

/** 个人信息 **/
@property(nonatomic,strong,readonly) HSCSUserInfoModel *userInfo;

/** 是否VIP **/
@property(nonatomic,assign,readonly) BOOL    isVp;

/** 是否老师 **/
@property(nonatomic,assign,readonly) BOOL    isTeacher;

/** 是否需要Jiesuo **/
@property(nonatomic,assign,readonly) BOOL    isUnlock;

/** 设备是否Jiesuo **/
@property(nonatomic,assign,readonly) BOOL    isDeviceUnlock;

/** 是否可以使用私信 **/
@property(nonatomic,assign,readonly) BOOL    canLetter;

/** 是否绑定私信 **/
@property(nonatomic,assign,readonly) BOOL    bindWecChat;

/** 用户等级 **/
@property(nonatomic,assign,readonly) NSInteger    level;

/** 是否显示用户等级 **/
@property(nonatomic,assign) BOOL     showLevel;

/** 用户等级名称 **/
@property(nonatomic,strong,readonly) NSString     *levelName;

/** 用户等级 **/
@property(nonatomic,strong,readonly) NSString     *levelNum;

/** 用户token **/
@property(nonatomic,assign,readonly) NSString     *token;

/** 首次安装软件协议确认 **/
@property(nonatomic,assign,readonly) BOOL userAgreement;

/** VIP专区引导页是否显示  **/
@property(nonatomic,assign,readonly) BOOL showGuidePage;

/** true跳转小程序，false跳转一次性订阅消息  **/
@property(nonatomic,assign) BOOL jumpWxApp;

/** 未处理私信数 **/
@property(nonatomic,strong) NSString *unhandleMessageNum;

//VP落地页
@property(nonatomic,strong) NSString *vipH5Url;

//用户注销
@property(nonatomic,strong) NSString *unRegisterUrl;

//VP落地页
@property(nonatomic,strong) NSString *vipLiveRoomUrl;

//我的资产
@property(nonatomic,strong) NSString *myAssetsUrl;

//首页权限
@property(nonatomic,strong) NSArray<HSCSHomeAppModel *>   *appFunctions;

//未读消息数量
@property(nonatomic,assign) NSInteger unReadNum;

//总积分
@property(nonatomic,assign) NSInteger score;

/** 是否登录 **/
- (BOOL)isLogined;

/** 用户信息 **/
- (HSCSUserInfoModel *)getUserInfo;

/** 更新用户信息 **/
- (void)saveUserInfo:(HSCSUserInfoModel *)user;

/** 用户同意协议 **/
- (void)saveUserAgreement:(BOOL)agreement;

/** VIP专区引导页 **/
- (void)saveshowGuidePage:(BOOL)show;

/** 设备是否Jiesuo **/
- (void)saveDeviceUnlock:(BOOL)unLock;

/** 退出登录 **/
- (void)loginOut;

/** 登录失效 **/
- (void)userLoginLose;

/** 等级显示 **/
-(UIImage *)roleImage:(NSInteger)role;

/** 等级显示 **/
-(CGSize)roleImgSize:(NSInteger)role;

@end


@interface HSCSUserInfoModel : NSObject

//手机号码
@property(nonatomic,strong) NSString *mobile;
//用户头像
@property(nonatomic,strong) NSString *avatar;
//用户头像 - 待
@property(nonatomic,strong) NSString *verify_avatar;
//用户token
@property(nonatomic,strong) NSString *token;
//昵称
@property(nonatomic,strong) NSString *nickname;
//昵称 - 待
@property(nonatomic,strong) NSString *verify_nickname;
//用户级别 - 角色 0游客 100普通用户 150黄金会员 200钻石会员
@property(nonatomic,strong) NSNumber *role;
//用户id base64
@property(nonatomic,strong) NSString *uid;
//
@property(nonatomic,strong) NSString *userId;
//微信昵称
@property(nonatomic,strong) NSString *wechat_nickname;
//微信openid
@property(nonatomic,strong) NSString *openid;
//角色文本
@property(nonatomic,strong) NSString *role_text;
//是否老师
@property(nonatomic,assign) BOOL isTeacher;
//是否会员
@property(nonatomic,assign) NSNumber *isVip;
//
@property(nonatomic,strong) NSString *vhallEmail;
//到期时间
@property(nonatomic,strong) NSString *vipExpireDay;
//是否老用户，老用户+黄金可使用私信，新用户+钻石可用私信
@property(nonatomic,strong) NSNumber *isOldUser;
//未读消息数量
@property(nonatomic,strong) NSNumber *unReadNum;
//生日
@property(nonatomic,strong) NSString *birthday;
//背景
@property (nonatomic,strong) UIImage    *roleBGImage;
//角色等级
@property (nonatomic,strong) UIImage    *roleImage;
//
@property (nonatomic,assign) CGSize     roleImgSize;

//直播信息
@property (nonatomic,strong) HSCSUserChatRoomModel    *chatRoomModel;

@end


@interface HSCSUserChatRoomModel : NSObject

@property(nonatomic,assign) NSInteger   roomId;

@property(nonatomic,strong) NSString    *link;

@property(nonatomic,assign) BOOL        isDefault;

@property(nonatomic,strong) NSString    *roomName;

@end

NS_ASSUME_NONNULL_END
