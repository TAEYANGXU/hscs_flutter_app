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
//		File Name:		HSCSHUD.h
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/27 5:01 PM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <XyWidget/ConstHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSCSHUD : NSObject

+ (void)showGifToView:(UIView *)view;

+ (void)hideGifToView;

/**
 *  显示纯文本
 *
 *  @param text 要显示的文本
 */
+ (void)showText:(NSString *)text;

/**
 *  显示纯文本 加一个转圈
 *
 *  @param text 要显示的文本
 */
+ (void)showProgressText:(NSString *)text;

+ (void)showText:(NSString *)text completion:(void (^)(void))completion;

/**
 *  显示错误信息
 *
 *  @param text 错误信息文本
 */
+ (void)showErrorText:(NSString *)text;

/**
 *  显示成功信息
 *
 *  @param text 成功信息文本
 */
+ (void)showSuccessText:(NSString *)text;

+ (void)showSuccessText:(NSString *)text completion:(void (^)(void))completion;
/**
 *  只显示一个加载框
 */
+ (void)showLoading;

+ (void)delayDismiss;

/**
 *  显示一个加载框在superView上
 */
+ (void)showLoading:(UIView *)superView;

/**
 *  隐藏加载框（所有类型的加载框 都可以通过这个方法 隐藏）
 */
+ (void)dismissLoading;

/**
 *  显示百分比
 *
 *  @param progress 百分比（整型 100 = 100%）
 */
+ (void)showProgress:(NSInteger)progress;

/**
 *  显示图文提示
 *
 *  @param image 自定义的图片
 *  @param text 要显示的文本
 */
+ (void)showImage:(UIImage*)image text:(NSString*)text;

/**
 *  视频播放页面转菊花
 *
 *  @param view   父视图
 */
+ (void)showProgressHUDAddedToVideoView:(UIView *)view;

/**
 *  转菊花
 *
 *  @param view 父视图
 */
+ (void)showProgressHUDAddedTo:(UIView *)view;

/**
 *  提示失败消息
 *
 *  @param title    内容
 *  @param view     父视图
 *  @param interval 显示时间
 */
+ (void)showFailedHUD:(NSString *)title AddedTo:(UIView *)view interval:(int)interval;

/**
 *  隐藏
 *
 *  @param view 父视图
 */
+ (void)hideHUDTo:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
