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
//		File Name:		HSCSHUD.m
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/27 5:01 PM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import "HSCSHUD.h"
#import "HSCSProgressHUD.h"
//#import <MBProgressHUD/MBProgressHUD.h>
#import "UIImage+GIFImage.h"
#import "Runner-Swift.h"
#import "Masonry.h"
#import "AppUtils.h"

@implementation HSCSHUD

+ (void)showGifToView:(UIView *)view
{
    HSCSGIFLoadingView *gifView  = [HSCSGIFLoadingView shared];
    [view addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

+ (void)hideGifToView
{
    [self performSelector:@selector(hideGif) withObject:self afterDelay:0.5];
}

+ (void)hideGif
{
    HSCSGIFLoadingView *gifView  = [HSCSGIFLoadingView shared];
    [gifView removeFromSuperview];
}

/**
 *  显示纯文本
 *
 *  @param text 要显示的文本
 */
+ (void)showText:(NSString *)text;
{
    [HSCSProgressHUD showImage:[UIImage imageNamed:@"AA"] status:text];
    [HSCSProgressHUD dismissWithDelay:2.0f];
}

/**
 *  显示纯文本 加一个转圈
 *
 *  @param text 要显示的文本
 */
+ (void)showProgressText:(NSString *)text
{
    [HSCSProgressHUD dismiss];
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [HSCSProgressHUD showWithStatus:text];
    [HSCSProgressHUD dismissWithDelay:1.5f];
}

+ (void)showText:(NSString *)text completion:(void (^)(void))completion;
{
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [HSCSProgressHUD showWithStatus:text];
    [HSCSProgressHUD dismissWithDelay:1.5f];
    if (completion) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            completion();
        });
    }
}
/**
 *  显示错误信息
 *
 *  @param text 错误信息文本
 */
+ (void)showErrorText:(NSString *)text
{
    if ([AppUtils nullEmpty:text].length == 0) {
        return;
    }
    [HSCSProgressHUD dismiss];
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [HSCSProgressHUD showErrorWithStatus:text];
    [HSCSProgressHUD dismissWithDelay:1.5f];
}

/**
 *  显示成功信息
 *
 *  @param text 成功信息文本
 */
+ (void)showSuccessText:(NSString *)text
{
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [HSCSProgressHUD showSuccessWithStatus:text];
    [HSCSProgressHUD dismissWithDelay:1.5f];
}

+ (void)showSuccessText:(NSString *)text completion:(void (^)(void))completion;
{
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [HSCSProgressHUD showSuccessWithStatus:text];
    [HSCSProgressHUD dismissWithDelay:1.5f completion:^{
        if (completion) {
            completion();
        }
    }];
    
}

/**
 *  只显示一个加载框
 */
+ (void)showLoading
{
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [HSCSProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [HSCSProgressHUD setContainerView:nil];
    [HSCSProgressHUD show];
    //防止长连接没回应toast不消失
    [self performSelector:@selector(delayDismiss) withObject:nil afterDelay:10];
}
+(void)delayDismiss{
    if ([HSCSProgressHUD isVisible]) {
        [HSCSProgressHUD dismiss];
//        [HSCSHUD showErrorText:@"服务器超时"];
    }
}
/**
 *  隐藏加载框（所有类型的加载框 都可以通过这个方法 隐藏）
 */
+ (void)dismissLoading
{
    [HSCSProgressHUD dismiss];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayDismiss) object:nil];
}

/**
 *  显示一个加载框在superView上
 */
+ (void)showLoading:(UIView *)superView
{
    [HSCSProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [HSCSProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [HSCSProgressHUD setContainerView:superView];
    [HSCSProgressHUD show];
}

/**
 *  显示百分比
 *
 *  @param progress 百分比（整型 100 = 100%）
 */
+ (void)showProgress:(NSInteger)progress
{
    [HSCSProgressHUD showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
}

/**
 *  显示图文提示
 *
 *  @param image 自定义的图片
 *  @param text 要显示的文本
 */
+ (void)showImage:(UIImage*)image text:(NSString*)text
{
    [HSCSProgressHUD showImage:image status:text];
    [HSCSProgressHUD dismissWithDelay:1.5f];
}


+ (void)showProgressHUDAddedToVideoView:(UIView *)view
{
    [HSCSHUD hideHUDTo:view];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.backgroundColor = [UIColor clearColor];
//    [hud showAnimated:YES];
}
/**
 *  转菊花
 *
 *  @param view 父视图
 */
+ (void)showProgressHUDAddedTo:(UIView *)view
{
    [HSCSHUD hideHUDTo:view];
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.contentColor = RGBA(101, 101, 101, 0.96);
//    [hud showAnimated:YES];
}

/**
 *  提示失败消息
 *
 *  @param title    内容
 *  @param view     父视图
 *  @param interval 显示时间
 */
+(void) showFailedHUD:(NSString *)title AddedTo:(UIView *)view interval:(int)interval {
    
    [HSCSHUD hideHUDTo:view];
    if ([AppUtils nullEmpty:title].length == 0) {
        return;
    }
    [HSCSHUD showHUD:title AddedTo:view interval:interval];
}

/**
 *  提示成功消息
 *
 *  @param title    内容
 *  @param view     父视图
 *  @param interval 显示时间
 */
+(void) showSuccessHUD:(NSString *)title AddedTo:(UIView *)view interval:(int)interval {
    
    [HSCSHUD hideHUDTo:view];
    [HSCSHUD showHUD:title AddedTo:view interval:interval];
}

+ (void)showHUD:(NSString *)title AddedTo:(UIView *)view interval:(int)interval {
    
    [HSCSHUD hideHUDTo:view];
    
//    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.contentColor = RGBA(101, 101, 101, 0.96);
//
//    CGFloat titleW = 170;
//    if (title) {
//        titleW = [AppUtils sizeWithText:title font:[UIFont systemFontOfSize:13] with:50].width+20;
//    }
//    UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, titleW, 50)];
//    titleView.backgroundColor = [UIColor clearColor];
//    titleView.font = [UIFont systemFontOfSize:13];
//    titleView.textColor = [UIColor whiteColor];
//    titleView.textAlignment = NSTextAlignmentCenter;
//    titleView.layer.cornerRadius = 3;
//    titleView.layer.masksToBounds = YES;
//
//    hud.customView = titleView;
//
//    if (title != nil && [title length]>0) {
//        titleView.text = title;
//    }
//
//    hud.removeFromSuperViewOnHide = YES;
//    if (interval>0) {
//        [hud hideAnimated:YES afterDelay:interval];
//    } else {
//        [hud hideAnimated:YES];
//    }
}

/**
 *  隐藏
 *
 *  @param view 父视图
 */
+ (void)hideHUDTo:(UIView *)view
{
//    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
