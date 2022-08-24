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
//		File Name:		HSCSProgressHUD.m
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/27 4:50 PM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import "HSCSProgressHUD.h"
#import <objc/runtime.h>
#import <CoreMotion/CoreMotion.h>
#import <XyWidget/ConstHeader.h>

@interface HSCSProgressHUD ()

@property (nonatomic, strong) CMMotionManager           *motionManager;
@property (nonatomic, assign) UIInterfaceOrientation    lastOrientation;

@end

@implementation HSCSProgressHUD

+ (void)initialize
{
//    [self setSuccessImage:[UIImage imageNamed:@"HUD_success"]];
//    [self setInfoImage:[UIImage imageNamed:@"HUD_info"]];
//    [self setErrorImage:[UIImage imageNamed:@"HUD_error"]];
    self.minimumDismissTimeInterval = 2;
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setCornerRadius:8.0];
}

// 根据 提示文字字数，判断 HUD 显示时间
//- (NSTimeInterval)displayDurationForString:(NSString*)string
//{
//    return MIN((float)string.length*0.05 + 0.5, 1.5);
//}

// 修改 HUD 颜色，需要取消混合效果(使`backgroundColroForStyle`方法有效)
- (void)updateBlurBounds{
}

// HUD 颜色
//- (UIColor*)backgroundColorForStyle{
//    return HEXA(@"#9194A4", 0.3);
//}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if([self.motionManager isAccelerometerAvailable]){
//        [self orientationChange];
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    if (self.motionManager) {
        [self.motionManager stopAccelerometerUpdates];
        self.motionManager = nil;
    }
}

#pragma mark - 屏幕方向旋转
- (void)orientationChange
{
    WS(weakSelf)
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration acceleration = accelerometerData.acceleration;
        __block UIInterfaceOrientation orientation;
        if (acceleration.x >= 0.75) {
            orientation = UIInterfaceOrientationLandscapeLeft;
        }
        else if (acceleration.x <= -0.75) {
            orientation = UIInterfaceOrientationLandscapeRight;
            
        }
        else if (acceleration.y <= -0.75) {
            orientation = UIInterfaceOrientationPortrait;
            
        }
        else if (acceleration.y >= 0.75) {
            orientation = UIInterfaceOrientationPortraitUpsideDown;
            return ;
        }
        else {
            // Consider same as last time
            return;
        }
        
        if (orientation != weakSelf.lastOrientation) {
            [weakSelf configHUDOrientation:orientation];
            weakSelf.lastOrientation = orientation;
            Log(@"%tu=-------%tu",orientation,weakSelf.lastOrientation);
        }
        
    }];
}

- (void)configHUDOrientation:(UIInterfaceOrientation )orientation
{
    CGFloat angle = [self calculateTransformAngle:orientation];
    self.transform = CGAffineTransformRotate(self.transform, angle);
}


- (CGFloat)calculateTransformAngle:(UIInterfaceOrientation )orientation
{
    CGFloat angle = 0.0;
    if (self.lastOrientation == UIInterfaceOrientationPortrait) {
        switch (orientation) {
            case UIInterfaceOrientationLandscapeRight:
                angle = M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                angle = -M_PI_2;
                break;
            default:
                break;
        }
    } else if (self.lastOrientation == UIInterfaceOrientationLandscapeRight) {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                angle = -M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                angle = M_PI;
                break;
            default:
                break;
        }
    } else {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                angle = M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeRight:
                angle = M_PI;
                break;
            default:
                break;
        }
    }
    return angle;
}

#pragma mark - Lazy Load
- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 1./15.;
        
    }
    return _motionManager;
}

@end
