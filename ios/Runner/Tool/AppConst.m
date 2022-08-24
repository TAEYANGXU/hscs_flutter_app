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
//        File Name:       AppConst.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/12/3 9:19 AM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        
#import <UIKit/UIKit.h>

/**
 *  1 生产环境
 *
 *  2 测试环境
 *
 *  3 开发环境
 *
 *  切换环境请修改该参数
 */
NSInteger const TARGET_RELEASE_ENVIRONMENT        = 1; //(作废)    新 -> 关于我们页面  长按logo 3秒  切换后台服务

/**
 *  服务器API地址
 */
NSString *const HSCS_SERVER_DEV                  = @"http://api-test.huashengfe.cn";
NSString *const HSCS_SERVER_PRO                  = @"https://api.jinoufe.com";
NSString *const HSCS_SERVER_TES                  = @"http://api-test.huashengfe.cn";

/**
 *  QS服务器API地址
 */
NSString *const HSCS_SERVER_QS_DEV               = @"http://social-api-test.huashengfe.cn";
NSString *const HSCS_SERVER_QS_PRO               = @"https://socapi.jinoufe.com";
NSString *const HSCS_SERVER_QS_TES               = @"http://social-api-test.huashengfe.cn";

/**
 *  H5地址
 */
NSString *const HSCS_SERVER_H5_DEV               = @"http://wxpay-test.huashengfe.cn";
NSString *const HSCS_SERVER_H5_PRO               = @"https://wxpay.jinoufe.com";
NSString *const HSCS_SERVER_H5_TES               = @"http://wxpay-test.huashengfe.cn";


/**
 *  视频直播socket服务器
 */
NSString *const LIVE_VIDEO_SOCKET_DEV            = @"ws://192.168.99.149:8096/chat";
NSString *const LIVE_VIDEO_SOCKET_PRO            = @"wss://chat3.jinoufe.com/socket.io";
NSString *const LIVE_VIDEO_SOCKET_TES            = @"ws://47.104.228.200:8099";


/**
 *  版本更新
 */
NSString *const HSCS_SERVER_VERVION_DEV          = @"http://live-api.lanyife.com";
NSString *const HSCS_SERVER_VERVION_PRO          = @"https://live-api.huashengfe.com";
NSString *const HSCS_SERVER_VERVION_TES          = @"http://live-api-test.huashengfe.com";


NSString *const HSCSPL                        = @"iOS";
NSString *const HSCSSVTYPE                    = @"UM";
NSString *const HSCSCHANNEL                   = @"jius0001";
NSString *const HSCSTESCHANNEL                = @"jitf0001";
NSString *const HSCSSECRET                    = @"f9d39537-a9fc-4099-ac88-b2c3105cc81d";
NSString *const HSCSPROJECT                   = @"82";

/**
 *  请求异常消息
 */
NSString *const kNetWorkFailMsg             = @"连接失败，请稍后尝试";
NSString *const kSocketConnectFailMsg       = @"正在连接...";
NSString *const kSocketVerifyFailMsg        = @"验证失败";
NSString *const kUserLoginLoseMsg           = @"登录失效，请重新登录";

/**
 *  微吼key
 */
NSString *const kVHAppKey                   = @"5c08f284d0e0f6d0084746bc63c1279d";
NSString *const kVHAppSecretKey             = @"acd2da2b734725d145ab22f09993c916";

/**
 *  阿里一键登录
 */
NSString *const kOneLoginAppSecret          = @"IyM0UUnex98C8U3U7kpXO7DuMDhyF8+NKaU59o0tHVxX9j3ecUbeyQ6SPoiBoerN2p9by38mDoV6hYwoTPAv8bFrl9w8m9HcaNinBGWXMV7kMi9B2ffj+3E6enFMntq0UXNBCR+MjvIuaodJ25y7ebtVQiV4icpN6Gb4w3c49pA3jZAj9/FHKW4kgrBa8zWZxIyrusbefNoj2t8Ejc9I6ydmbvnbPll8kwyBSWCaInt5c1KKZCcOVXlT8dQp0rwRor4GqZtkgDQ=";

NSString *const kDeeplinkScheme             = @"lyitp";

NSInteger const kVHMovieDefinitionCount = 4;//微吼sdk 清晰度个数


/**
 *  微信平台配置信息
 */
NSString *const WechatAppID = @"wx017fbdb8a1e59f04";
NSString *const WechatAppSecret = @"c46eccccc158831c2afa1885dd221372";
NSString *const WechatUniversalLink = @"https://www.jinoufe.com/app/";
NSString *const WechatTemplateId = @"OiqqADn7mk81q3ksBbP6ZVWCvpgH_HSvsgj6AY8mKUo";

NSString *const WechatUserNameId_PRO = @"gh_41743c09c39b";
NSString *const WechatUserNameId_DEV = @"gh_96d7ec51cd2f";

/**
 *  神策
 */
NSString *const SA_SERVER_URL         = @"https://lanyi.datasink.sensorsdata.cn/sa?project=business_school&token=04ee23e52f0616b0";

/**
 *  极光平台配置信息
 */
NSString *const JPushAppKey           = @"d6974867e19c2efa6920187c";

/**
 *  崩溃日志
 */
NSString *const BuglyAppId            = @"2f3030867f";


/**
 *  deeplink
 */
NSString *const DeepLink_unlock_popup = @"lyitp://diqiu/unlock_popup";//Jiesuo弹窗
NSString *const DeepLink_unlock_popup_wx = @"lyitp://diqiu/unlock_popup_wx";//微信一次性订阅
NSString *const DeepLink_vp_popup = @"lyitp://diqiu/vip_popup";//VP弹窗
NSString *const DeepLink_open_vp_web = @"lyitp://diqiu/open_vip_web";//开通vip
NSString *const DeepLink_vp_sudoku_more = @"lyitp://diqiu/vip_sudoku_more";//九宫格更多

/**
 *  notification
 */
NSString *const kAppUserLoginNotification         = @"kAppUserLoginNotification";
NSString *const kAppUserLoginOutNotification      = @"kAppUserLoginOutNotification";
NSString *const kAppUserAgreementNotification     = @"kAppUserAgreementNotification";
NSString *const kAppWealthLiveNotification        = @"kAppWealthLiveNotification";
NSString *const kAppUserUnhandledNumNotification  = @"kAppUserUnhandledNumNotification";
NSString *const kAppWealthTextLiveNotification    = @"kAppWealthTextLiveNotification";
NSString *const kAppRefreshVipNotification        = @"kAppRefreshVipNotification";
NSString *const kAppRefreshVipLiveRoomNotification= @"kAppRefreshVipLiveRoomNotification";
NSString *const kAppRefreshHomeNotification       = @"kAppRefreshHomeNotification";
NSString *const kAppRefreshHomeAudioNotification  = @"kAppRefreshHomeAudioNotification";
NSString *const kAppRefreshChatListNotification   = @"kAppRefreshChatListNotification";
NSString *const kAppRefreshMSGCountNotification   = @"kAppRefreshMSGCountNotification";
NSString *const kAppRefreshVPMSGCountNotification = @"kAppRefreshVPMSGCountNotification";
NSString *const kAppLiveReceiveMessageNotification = @"kAppLiveReceiveMessageNotification";
