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
//        File Name:       AppConst.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/12/3 9:19 AM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSInteger const TARGET_RELEASE_ENVIRONMENT;

/**
 *  服务器API地址
 */
extern NSString *const HSCS_SERVER_DEV;
extern NSString *const HSCS_SERVER_PRO;
extern NSString *const HSCS_SERVER_TES;

/**
 *  QS服务器API地址
 */
extern NSString *const HSCS_SERVER_QS_DEV;
extern NSString *const HSCS_SERVER_QS_PRO;
extern NSString *const HSCS_SERVER_QS_TES;

/**
 *  H5地址
 */
extern NSString *const HSCS_SERVER_H5_DEV;
extern NSString *const HSCS_SERVER_H5_PRO;
extern NSString *const HSCS_SERVER_H5_TES;

/**
 *  版本更新
 */
extern NSString *const HSCS_SERVER_VERVION_DEV;
extern NSString *const HSCS_SERVER_VERVION_PRO;
extern NSString *const HSCS_SERVER_VERVION_TES;

/**
 *  视频直播socket服务器
 */
extern NSString *const LIVE_VIDEO_SOCKET_DEV;
extern NSString *const LIVE_VIDEO_SOCKET_PRO;
extern NSString *const LIVE_VIDEO_SOCKET_TES;

/**
 *  益K线
 */
extern NSString *const YKX_SERVER_DEV;
extern NSString *const YKX_SERVER_PRO;
extern NSString *const YKX_SERVER_TES;

/**
 *  微吼key
 */
extern NSString *const kVHAppKey;
extern NSString *const kVHAppSecretKey;

extern NSString *const HSCSPL;
extern NSString *const HSCSSVTYPE;
extern NSString *const HSCSCHANNEL;
extern NSString *const HSCSTESCHANNEL;
extern NSString *const HSCSSECRET;
extern NSString *const HSCSPROJECT;

extern NSString *const kDeeplinkScheme;

/**
*  请求异常消息
*/
extern NSString *const kNetWorkFailMsg;
extern NSString *const kSocketConnectFailMsg;
extern NSString *const kSocketVerifyFailMsg;
extern NSString *const kUserLoginLoseMsg;

/**
 *  阿里一键登录
 */
extern NSString *const kOneLoginAppSecret;


UIKIT_EXTERN NSInteger const kVHMovieDefinitionCount;//微吼sdk提供的清晰度个数


/**
 *  微信平台配置信息
 */
UIKIT_EXTERN NSString *const WechatAppID;
UIKIT_EXTERN NSString *const WechatAppSecret;
UIKIT_EXTERN NSString *const WechatUniversalLink;
UIKIT_EXTERN NSString *const WechatTemplateId;

UIKIT_EXTERN NSString *const WechatUserNameId_PRO;//微信小程序
UIKIT_EXTERN NSString *const WechatUserNameId_DEV;//微信小程序

/**
 *  神策
 */
UIKIT_EXTERN NSString *const SA_SERVER_URL;

/**
 *  极光平台配置信息
 */
UIKIT_EXTERN NSString *const JPushAppKey;

/**
 *  崩溃日志
 */
UIKIT_EXTERN NSString *const BuglyAppId;


/**
 *  deeplink
 */
UIKIT_EXTERN NSString *const DeepLink_unlock_popup;//Jiesuo弹窗
UIKIT_EXTERN NSString *const DeepLink_unlock_popup_wx;//微信一次性订阅
UIKIT_EXTERN NSString *const DeepLink_vp_popup;//VP弹窗
UIKIT_EXTERN NSString *const DeepLink_open_vp_web;//开通会员
UIKIT_EXTERN NSString *const DeepLink_vp_sudoku_more;//九宫格更多

/**
 *  notification
 */
UIKIT_EXTERN NSString *const kAppUserLoginNotification;
UIKIT_EXTERN NSString *const kAppUserLoginOutNotification;
UIKIT_EXTERN NSString *const kAppUserAgreementNotification;
UIKIT_EXTERN NSString *const kAppWealthLiveNotification;
UIKIT_EXTERN NSString *const kAppUserUnhandledNumNotification;
UIKIT_EXTERN NSString *const kAppWealthTextLiveNotification;
UIKIT_EXTERN NSString *const kAppRefreshVipNotification;
UIKIT_EXTERN NSString *const kAppRefreshVipLiveRoomNotification;
UIKIT_EXTERN NSString *const kAppRefreshHomeNotification;
UIKIT_EXTERN NSString *const kAppRefreshHomeAudioNotification;
UIKIT_EXTERN NSString *const kAppRefreshChatListNotification;
UIKIT_EXTERN NSString *const kAppRefreshMSGCountNotification;
UIKIT_EXTERN NSString *const kAppRefreshVPMSGCountNotification;
UIKIT_EXTERN NSString *const kAppLiveReceiveMessageNotification;

NS_ASSUME_NONNULL_END

