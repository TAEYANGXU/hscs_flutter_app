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
//        File Name:       HSCSWatchLiveVideoView.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/7/31 10:54 AM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "HSCSWatchLiveVideoView.h"
#import "HSCSDefinitionListView.h"
#import "HSCSLiveVideoLightView.h"
#import <AVFoundation/AVFoundation.h>
#import "HSCSLiveNoDataView.h"
#import <VHLiveSDK/VHallApi.h>
#import <XyWidget/ConstHeader.h>
#import "Masonry.h"
#import "AppUtils.h"
#import "HSCSHUD.h"
#import "AppConst.h"
#import <XyWidget/UIView+Frame.h>
#import <XyWidget/UIView+Additions.h>
#import <XyWidget/UIFont+PingFangSC.h>

//控制面板隐藏时间
static const NSTimeInterval TimeInterval = 10.0;

@interface HSCSWatchLiveVideoView()<VHallMoviePlayerDelegate,VHallMoviePlayerDelegate,DefinitionListViewDelegate>

//微吼视频播放器
@property(nonatomic,copy) VHallMoviePlayer          *vhMoviePlayer;
//
@property(nonatomic,copy) UIView   *bgView;
//是否全屏
@property(nonatomic,assign)   BOOL  isFullScreen;
//静音
@property(nonatomic,assign)   BOOL  mute;
//静音
@property(nonatomic,assign)   BOOL  lock;
//锁屏
@property(nonatomic,copy) UIButton *lockButton;
//直播Id
@property(nonatomic,copy) NSNumber *vhallId;

//**************************小屏***************************//
@property(nonatomic,copy) UIView   *smallView;
@property(nonatomic,copy) UIView   *smallTapView;
//加载失败
@property(nonatomic,copy) HSCSLiveNoDataView *smallLiveNoDataView;
//播放
@property(nonatomic,copy) UIButton *playButton;
//全屏
@property(nonatomic,copy) UIButton *screenButton;
//音量
@property(nonatomic,copy) UIButton *volumeButton;
//清晰度
@property(nonatomic,copy) UIButton *definitionButton;
//清晰度列表
@property(nonatomic,copy) HSCSDefinitionListView *definitionListView;

//**************************全屏***************************//
@property(nonatomic,copy) UIView   *bigView;
@property(nonatomic,copy) UIView   *bigTapView;
//加载失败
@property(nonatomic,copy) HSCSLiveNoDataView *bigLiveNoDataView;
//播放
@property(nonatomic,copy) UIButton *bigPlayButton;
//标题
@property(nonatomic,copy) UILabel  *bigTitleLabel;
//返回
@property(nonatomic,copy) UIButton *bigBackButton;
//全屏
@property(nonatomic,copy) UIButton *bigScreenButton;
//音量
@property(nonatomic,copy) UIButton *bigVolumeButton;
//清晰度
@property(nonatomic,copy) UIButton *bigDefinitionButton;
//亮度调整
@property(nonatomic,copy) UIButton *brightnessButton;
//清晰度列表
@property(nonatomic,copy) HSCSDefinitionListView *bigDefinitionListView;
//屏幕亮度
@property(nonatomic,copy) HSCSLiveVideoLightView *liveVideoLightView;

@property(nonatomic,assign)CGRect superFrame;

@property(nonatomic,strong)NSArray *definitionList;

@property(nonatomic,assign)BOOL canPerform;

@end

@implementation HSCSWatchLiveVideoView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.superFrame = frame;
        [self makeUpUI];
        [self makeLayout];
        self.vhMoviePlayer.moviePlayerView.frame = frame;
//        [self addNotification];
//        [self addOrientationNotification];
    }
    return self;
}

- (void)makeUpUI{
    //阻止iOS设备锁屏
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 5;
    
    [self addSubview:self.vhMoviePlayer.moviePlayerView];
    [self sendSubviewToBack:self.vhMoviePlayer.moviePlayerView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.bgView];
    
    [self.vhMoviePlayer.moviePlayerView addSubview:self.smallView];
    [self.smallView addSubview:self.smallLiveNoDataView];
    [self.smallView addSubview:self.smallTapView];
    [self.smallView addSubview:self.playButton];
    [self.smallView addSubview:self.screenButton];
    [self.smallView addSubview:self.volumeButton];
    [self.smallView addSubview:self.definitionButton];
    [self.smallView addSubview:self.definitionListView];
    
    [self.vhMoviePlayer.moviePlayerView addSubview:self.bigView];
    [self.bigView addSubview:self.bigLiveNoDataView];
    [self.bigView addSubview:self.bigTapView];
    [self.bigView addSubview:self.bigBackButton];
    [self.bigView addSubview:self.bigTitleLabel];
    [self.bigView addSubview:self.bigPlayButton];
    [self.bigView addSubview:self.bigScreenButton];
    [self.bigView addSubview:self.bigVolumeButton];
    [self.bigView addSubview:self.bigDefinitionButton];
    [self.bigView addSubview:self.brightnessButton];
    [self.bigView addSubview:self.bigDefinitionListView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.lockButton];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.liveVideoLightView];
    
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.bgView addGestureRecognizer:tapGes];
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.smallTapView addGestureRecognizer:tapGes1];
    UITapGestureRecognizer *tapGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.bigTapView addGestureRecognizer:tapGes2];
}

- (void)makeLayout{
    
//    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, self.width, 200);
    self.smallLiveNoDataView.frame = self.superFrame;
    self.bigLiveNoDataView.frame =  CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
        make.top.mas_equalTo(0);
    }];
    [self.smallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    [self.smallTapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-45);
        make.top.mas_equalTo(0);
    }];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.mas_equalTo(self.bigView.mas_centerY);
        make.centerX.mas_equalTo(self.bigView.mas_centerX);
//        make.bottom.mas_equalTo(0);
//        make.left.mas_equalTo(5);
//        make.size.mas_equalTo(CGSizeMake(40, 45));
    }];
    [self.screenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.volumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.equalTo(self.screenButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.definitionButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(0);
        make.centerY.equalTo(self.volumeButton.mas_centerY);
        make.right.equalTo(self.volumeButton.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 22));
    }];
    [self.definitionListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.definitionButton.mas_centerX);
        make.bottom.equalTo(self.definitionButton.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(50, 95));
    }];
    [self.bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    [self.bigTapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-60);
        make.top.mas_equalTo(0);
    }];
    [self.bigBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.bigTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bigBackButton.mas_right).offset(5);
        make.centerY.mas_equalTo(self.bigBackButton.mas_centerY);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(30);
    }];
    [self.bigPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerY.mas_equalTo(self.bigView.mas_centerY);
        make.centerX.mas_equalTo(self.bigView.mas_centerX);
    }];
    [self.bigScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-60);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    [self.bigDefinitionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bigScreenButton.mas_centerY);
        make.right.equalTo(self.bigScreenButton.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 22));
    }];
    [self.bigVolumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [self.brightnessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bigVolumeButton.mas_centerY);
        make.right.equalTo(self.bigVolumeButton.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [self.bigDefinitionListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bigDefinitionButton.mas_centerX);
        make.bottom.equalTo(self.bigDefinitionButton.mas_top).offset(-5);
        make.size.mas_equalTo(CGSizeMake(80, 129));
    }];
    [self.liveVideoLightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
    [self.lockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(40, 45));
    }];
}

- (void)dealloc
{
    NSLog(@"destory : %@",[self class]);
    
//    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

#pragma mark - private methods
//**播放视频**//
- (void)startPlayerWithId:(NSNumber *)vId title:(NSString *)title
{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self addNotification];
    [self addOrientationNotification];
    
    self.bigTitleLabel.text = [AppUtils nullEmpty:title];
    self.vhMoviePlayer.moviePlayerView.backgroundColor = [UIColor colorWithHexString:@"#333333"];
    if (vId) {
        self.vhallId = vId;
        [self playWithVhallId:self.vhallId toTiew:self];
    }
}

- (void)playWithVhallId:(NSNumber *)vhallId toTiew:(UIView *)view
{
    if (self.vhMoviePlayer.moviePlayerView) {
        if (self.isFullScreen) {
            [HSCSHUD showProgressHUDAddedToVideoView:self.bigView];
        }else {
            [HSCSHUD showProgressHUDAddedToVideoView:self.smallView];
        }
    }
    self.canPerform = YES;
//    NSString *iphone = [NSString stringWithFormat:@"%@password",[AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.mobile]];
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    param[@"id"] = vhallId;
//    param[@"name"] = [AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.nickname];
//    param[@"email"] = [AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.vhallEmail];
    [self.vhMoviePlayer startPlay:param];
}

- (void)addOrientationNotification
{
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(liveOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeOrientationNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];
}

//**销毁播放器**//
- (void)close
{
    [self.bgView removeFromSuperview];
    [self.bigView removeFromSuperview];
    [self.smallView removeFromSuperview];
    [self.vhMoviePlayer.moviePlayerView removeFromSuperview];
    [self cancelObserver];
    [self.vhMoviePlayer destroyMoivePlayer];
    self.vhMoviePlayer.delegate = nil;
    self.vhMoviePlayer = nil;
}

- (void)cancelObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fullScreen:(BOOL)state{
    if (state) {
        //全屏
        self.lock = NO;
        [self lockSreem];
        self.smallView.hidden = YES;
        self.bigView.hidden = NO;
        self.isFullScreen = YES;
        self.lockButton.hidden = NO;
    }else{
        //退出全屏
        self.liveVideoLightView.hidden = YES;
        self.smallView.hidden = NO;
        self.bigView.hidden = YES;
        self.lockButton.hidden = YES;
        self.isFullScreen = NO;
    }
    self.canPerform = YES;
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
//    [self performSelector:@selector(canHiden) withObject:self afterDelay:TimeInterval];
}

- (void) hideNoDataView{
    self.smallLiveNoDataView.hidden = YES;
    self.bigLiveNoDataView.hidden = YES;
    
    self.playButton.hidden = NO;
    self.bigPlayButton.hidden = NO;
}

/*
 *status 1失败 2结束
 */
- (void) showNoDataView:(NSInteger)status{
    self.smallLiveNoDataView.hidden = NO;
    self.bigLiveNoDataView.hidden = NO;
    
    self.smallLiveNoDataView.status = status;
    self.bigLiveNoDataView.status = status;
    
    self.playButton.hidden = YES;
    self.bigPlayButton.hidden = YES;
}

//停止播放
- (void)pausePlay{
    [self.vhMoviePlayer pausePlay];
}

//开始播放
- (void)reconnectPlay{
    [self.vhMoviePlayer reconnectPlay];
}

#pragma mark - events respone - 点击事件

//**按钮事件**//
- (void)buttonAction:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1000:
            //播放、暂停
            if (self.vhMoviePlayer.playerState == VHPlayerStatePlaying) {
                [self pausePlay];
            }else{
                [self reconnectPlay];
            }
            [self resetPlayUI];
            break;
        case 1001:
            //全屏切换
            if (self.isFullScreen) {
//                ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
                [self doEndFullScreen];
            }else{
//                ScreenRotateToPortrait(UIInterfaceOrientationLandscapeRight);
                [self doFullScreen];
            }
            break;
        case 1002:
            //静音
            [self setSilence];
            break;
        case 1003:
            //返回
            if (self.isFullScreen) {
//                ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
                [self doEndFullScreen];
            }else{
//                ScreenRotateToPortrait(UIInterfaceOrientationLandscapeRight);
                [self doFullScreen];
            }
            break;
        case 1004:
            //清晰度
            self.liveVideoLightView.hidden = YES;
            [self showDefinitionListView];
            break;
        case 1005:
            //亮度
            self.liveVideoLightView.hidden = !self.liveVideoLightView.hidden;
            break;
        case 1006:
            //锁屏
            self.lock = !self.lock;
            [self lockSreem];
            [self performSelector:@selector(canHiden) withObject:self afterDelay:TimeInterval];
            break;
        default:
            break;
    }
}

- (void)lockSreem{
    
    self.bigView.hidden = self.lock;
    self.bigView.alpha = self.lock ? 0.0 : 1.0;
    [self.lockButton setImage:[UIImage imageNamed:self.lock ? @"watch_live_lock_icon" : @"watch_live_unlock_icon"] forState:UIControlStateNormal];
}

//**设置静音**//
- (void) setSilence
{
    self.mute = !self.mute;
    UIImage *image = self.mute ? [UIImage imageNamed:@"watch_back_ silence_icon"] : [UIImage imageNamed:@"watch_back_ volume_icon"];
    UIImage *image2 = self.mute ? [UIImage imageNamed:@"watch_back_ silence_fullscreen_icon"] : [UIImage imageNamed:@"watch_back_ volume_fullscreen_icon"];
    [self.volumeButton setImage:image forState:UIControlStateNormal];
    [self.bigVolumeButton setImage:image2 forState:UIControlStateNormal];
    [self.vhMoviePlayer setMute:self.mute];
}

//**点击 显示隐藏控制面板**//
-(void)tapAction:(UITapGestureRecognizer *)ges{
    if (self.vhMoviePlayer.playerState == VHPlayerStateStoped) {
        if ((!self.smallLiveNoDataView.hidden && self.smallLiveNoDataView.status==2) || (!self.bigLiveNoDataView.hidden && self.bigLiveNoDataView.status==2)) {
            //直播结束
            return;
        }
        [self playWithVhallId:self.vhallId toTiew:self];
    }else{
        [self showHideView];
        self.liveVideoLightView.hidden = YES;
        [[self class] cancelPreviousPerformRequestsWithTarget:self];
//        [self performSelector:@selector(canHiden) withObject:self afterDelay:TimeInterval];
    }
}

- (void) canHiden{
    if (!self.smallView.hidden || !self.bgView.hidden) {
        [self showHideView];
    }
}

//**显示隐藏控制面板**//
- (void) showDefinitionListView{
    WS(weakSelf)
    if (self.isFullScreen) {
        if (self.bigDefinitionListView.hidden) {
            self.bigDefinitionListView.hidden = NO;
            self.bigDefinitionListView.alpha = 0.0;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.bigDefinitionListView.alpha = 1.0;
            }];
        }else{
            self.bigDefinitionListView.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.bigDefinitionListView.alpha = 0.0;
            } completion:^(BOOL finished) {
                weakSelf.bigDefinitionListView.hidden = YES;
            }];
        }
    }else{
        if (self.definitionListView.hidden) {
            self.definitionListView.hidden = NO;
            self.definitionListView.alpha = 0.0;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.definitionListView.alpha = 1.0;
            }];
        }else{
            self.definitionListView.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.definitionListView.alpha = 0.0;
            } completion:^(BOOL finished) {
                weakSelf.definitionListView.hidden = YES;
            }];
        }
    }
}

//**显示隐藏锁**//
- (void)showHideLock{
    
    if (self.lockButton.hidden) {
        self.lockButton.hidden = NO;
        self.lockButton.alpha = 0.0;
        [UIView animateWithDuration:0.3 animations:^{
            self.lockButton.alpha = 1.0;
        }];
    }else{
        self.lockButton.alpha = 1.0;
        [UIView animateWithDuration:0.3 animations:^{
            self.lockButton.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.lockButton.hidden = YES;
        }];
    }
}

//**显示隐藏控制面板**//
- (void) showHideView{
    if (self.lock) {
        [self showHideLock];
        return;
    }
    WS(weakSelf)
    if (self.isFullScreen) {
        if (self.bigView.hidden) {
            self.canPerform = YES;
            self.bigView.hidden = NO;
            self.bigView.alpha = 0.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.bigView.alpha = 1.0;
                weakSelf.lockButton.hidden = NO;
            }];
        }else{
            self.bigView.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.bigView.alpha = 0.0;
            } completion:^(BOOL finished) {
                weakSelf.bigView.hidden = YES;
                weakSelf.lockButton.hidden = YES;
            }];
        }
    }else{
        if (self.smallView.hidden) {
            self.canPerform = YES;
            self.smallView.hidden = NO;
            self.smallView.alpha = 0.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.smallView.alpha = 1.0;
            }];
        }else{
            self.smallView.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.smallView.alpha = 0.0;
            } completion:^(BOOL finished) {
                weakSelf.smallView.hidden = YES;
            }];
        }
    }
}

#pragma mark - fullScreen - 全屏模式

- (void)doEndFullScreen
{
    ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
    if (@available(iOS 16.0, *)) {
        self.isFullScreen = NO;
        [self performSelector:@selector(didEndFullScreenLive) withObject:self afterDelay:0.1];
    }
}

- (void)doFullScreen{
    ScreenRotateToPortrait(UIInterfaceOrientationLandscapeRight);
    if (@available(iOS 16.0, *)) {
        self.isFullScreen = YES;
        [self performSelector:@selector(didFullScreenLive) withObject:self afterDelay:0.1];
    }
}

//全屏
- (void)didFullScreenLive{
    
    [self fullScreen:self.isFullScreen];
    
    self.vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFit;
    
    [MAIN_WINDOW addSubview:self.vhMoviePlayer.moviePlayerView];
    
    CGFloat width = SCREEN_HEIGHT;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//    [self.viewController.navigationController setNavigationBarHidden:YES animated:NO];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(width);
    }];
    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self layoutIfNeeded];
    self.bigLiveNoDataView.frame =  self.vhMoviePlayer.moviePlayerView.frame;
    [self.bigView layoutIfNeeded];
    [self.vhMoviePlayer.moviePlayerView layoutIfNeeded];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kVideoOrientationChangeNotification object:nil];
}
//退出全屏
- (void)didEndFullScreenLive{

    [self fullScreen:self.isFullScreen];
    
    [self.vhMoviePlayer.moviePlayerView removeFromSuperview];
    [self addSubview:self.vhMoviePlayer.moviePlayerView];
    
    self.vhMoviePlayer.moviePlayerView.transform = CGAffineTransformIdentity;
    self.vhMoviePlayer.moviePlayerView.transform = CGAffineTransformMakeRotation(0);
    [self addSubview:self.vhMoviePlayer.moviePlayerView];
//    [weakSelf.selectedCell insertSubview:weakSelf.selectedCell.videoView.overView aboveSubview:[LYPlaybackInstance sharedInstance].moviePlayer.moviePlayerView];
    self.vhMoviePlayer.moviePlayerView.frame = self.superFrame;
    self.frame = self.superFrame;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    [self.viewController.navigationController setNavigationBarHidden:YES animated:NO];
//
//    if (self.positionType == HSCSWatchBackVideoViewPositionCenter) {
//        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(0);
//            make.centerY.mas_equalTo(self.superview.mas_centerY);
//            make.height.mas_equalTo(200);
//        }];
//    }else{
//        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.top.mas_equalTo(0);
//            make.height.mas_equalTo(200);
//        }];
//    }
//    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, self.width, 200);
    [self layoutIfNeeded];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kVideoOrientationChangeNotification object:nil];
}
//
////全屏
//- (void)didFullScreenLive{
//
//    [self fullScreen:self.isFullScreen];
//
//    [MAIN_WINDOW addSubview:self.vhMoviePlayer.moviePlayerView];
//
//    CGFloat width = SCREEN_HEIGHT;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//    [self.viewController.navigationController setNavigationBarHidden:YES animated:NO];
//    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(0);
//        make.height.mas_equalTo(width);
//    }];
//
//    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    self.bigLiveNoDataView.frame =  self.vhMoviePlayer.moviePlayerView.frame;
//    [self.bigView layoutIfNeeded];
//    [self.vhMoviePlayer.moviePlayerView layoutIfNeeded];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kVideoOrientationChangeNotification object:nil];
//
//}
////退出全屏
//- (void)didEndFullScreenLive{
//
//    [self fullScreen:self.isFullScreen];
//
//    [self.vhMoviePlayer.moviePlayerView removeFromSuperview];
//    [self addSubview:self.vhMoviePlayer.moviePlayerView];
//
////    [[UIScreen mainScreen] setBrightness: 0.5];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//    [self.viewController.navigationController setNavigationBarHidden:YES animated:NO];
//    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(0);
//        make.height.mas_equalTo(self.height);
//    }];
//
//    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, self.width, 200);
//    [self layoutIfNeeded];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kVideoOrientationChangeNotification object:nil];
//
//}

#pragma mark - notification events - 通知事件

- (void)liveOrientationChanged:(NSNotification *)note
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
            self.isFullScreen = NO;
            [self didEndFullScreenLive];
            NSLog(@"退出全屏");
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:{
            [self.viewController setNeedsStatusBarAppearanceUpdate];
            NSLog(@"全屏");
            self.isFullScreen = YES;
            [self didFullScreenLive];
        }
            break;
        default:
            break;
    }
}

- (void)appEnterBackground{
    NSLog(@"appEnterBackground");
}

- (void)appEnterForeground{
    if (!self.vhallId) {
        return;
    }
    [self playWithVhallId:self.vhallId toTiew:self];
    if (self.isFullScreen) {
//        ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
        [self doEndFullScreen];
    }
}

#pragma mark - DefinitionListViewDelegate
/**
 *  设置清晰度
 */
- (void)didDefinitionListView:(HSCSDefinitionListView *)definitionListView definition:(NSInteger)definition title:(NSString *)title{
    
    [self.bigDefinitionListView selectWith:definition];
    [self.definitionListView selectWith:definition];
    [self showDefinitionListView];
    [self.vhMoviePlayer setCurDefinition:[self isExistsDefinition:definition] ? definition : 0];
    [self playWithVhallId:self.vhallId toTiew:self];
    
    [self.definitionButton setTitle:title forState:UIControlStateNormal];
    [self.bigDefinitionButton setTitle:title forState:UIControlStateNormal];
    
}

- (BOOL)isExistsDefinition:(NSInteger)definition
{
    BOOL has = NO;
    for (NSNumber *de in self.definitionList) {
        if (de.intValue == definition) {
            has = YES;
            break;
        }
    }
    return has;
}

#pragma mark - VHMoviePlayerDelegate
/**
 *  播放连接成功
 */
- (void)connectSucceed:(VHallMoviePlayer*)moviePlayer info:(NSDictionary*)info {
    Log(@"播放连接成功");
    [self hideNoDataView];
    [HSCSHUD hideHUDTo:self.smallView];
    [HSCSHUD hideHUDTo:self.bigView];
    [self performSelector:@selector(canHiden) withObject:self afterDelay:0.2];
}

/**
 *  缓冲开始回调
 */
- (void)bufferStart:(VHallMoviePlayer*)moviePlayer info:(NSDictionary*)info {
    Log(@"缓冲开始回调");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/**
 *  缓冲结束回调
 */
-(void)bufferStop:(VHallMoviePlayer*)moviePlayer info:(NSDictionary*)info {
    Log(@"缓冲结束回调");
    [self resetPlayUI];
    [HSCSHUD hideHUDTo:self.smallView];
    [HSCSHUD hideHUDTo:self.bigView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}
/**
 *  下载速率的回调
 *
 *  @param moviePlayer
 *  @param info        下载速率信息 单位kbps
 */
- (void)downloadSpeed:(VHallMoviePlayer*)moviePlayer info:(NSDictionary*)info {
//    Log(@"下载速率的回调");
    [self resetPlayUI];
    [self hideNoDataView];
    [HSCSHUD hideHUDTo:self.smallView];
    [HSCSHUD hideHUDTo:self.bigView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

-(void)resetPlayUI{
//    if ((!self.smallView.hidden || !self.bigView.hidden) && self.canPerform) {
//        self.canPerform = NO;
//        [self performSelector:@selector(showHideView) withObject:self afterDelay:3];
//    }
    if (self.vhMoviePlayer.playerState == VHPlayerStatePlaying) {
        [self.playButton setImage:[UIImage imageNamed:@"watch_back_pause_icon"] forState:UIControlStateNormal];
        [self.bigPlayButton setImage:[UIImage imageNamed:@"watch_back_full_pause_icon"] forState:UIControlStateNormal];
    }else{
        [self.playButton setImage:[UIImage imageNamed:@"watch_back_play_icon"] forState:UIControlStateNormal];
        [self.bigPlayButton setImage:[UIImage imageNamed:@"watch_back_full_play_icon"] forState:UIControlStateNormal];
    }
}

/**
 *  网络状态的回调
 *
 *  @param moviePlayer
 *  @param info        网络状态信息  content的值越大表示网络越好
 */
- (void)netWorkStatus:(VHallMoviePlayer*)moviePlayer info:(NSDictionary*)info {
    Log(@"网络状态的回调");
    
    //    Log(@"netWorkStatus:%f",[info[@"content"]floatValue]);
}
/**
 *  cdn 发生切换时的回调
 *
 *  @param moviePlayer
 *  @param info
 */
- (void)cdnSwitch:(VHallMoviePlayer*)moviePlayer info:(NSDictionary*)info {
    Log(@"发生切换时的回调");
    //    [self.moviePlayer.moviePlayerView addSubview:self.indicator];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/**
 *  播放时错误的回调
 *
 *  @param livePlayErrorType 解盘错误类型
 */
- (void)playError:(VHSaasLivePlayErrorType)livePlayErrorType info:(NSDictionary*)info {
    NSString * msg = @"";
    void (^resetStartPlay)(NSString * msg) = ^(NSString * msg){
        Log(@"msg -----  %@",msg);
        [HSCSHUD hideHUDTo:self.smallView];
        [HSCSHUD hideHUDTo:self.bigView];
        [HSCSHUD showErrorText:msg];
    };
    
    switch (livePlayErrorType) {
        case VHSaasLivePlayParamError:
        {
            msg = @"参数错误";
            resetStartPlay(msg);
            [self showNoDataView:1];
        }
            break;
        case VHSaasLivePlayRecvError:
        {
            msg = @"对方已经停止解盘";
            resetStartPlay(msg);
            [self showNoDataView:1];
        }
            break;
        case VHSaasLivePlayCDNConnectError:
        {
            msg = @"服务器任性...连接失败";
            resetStartPlay(msg);
            [self showNoDataView:1];
        }
            break;
        case VHSaasVodPlayError:
        {
            msg = @"播放器错误信息";
            resetStartPlay(msg);
            [self showNoDataView:1];
        }
            break;
        case VHSaasLivePlayGetUrlError:
        {
            msg = @"获取服务器地址报错";
            resetStartPlay(msg);
            [self showNoDataView:1];
            Log(@"error  ------%@",info[@"content"]);
        }
            break;
        default:
            break;
    }
}

/**
 *  code       含义
 *  10030    身份验证出错
 *  10402    当前活动ID错误
 *  10404    KEY值验证出错
 *  10046    当前活动已结束
 *  10047    您已被踢出，请联系活动组织者
 *  10048    活动现场太火爆，已超过人数上限
 */

#pragma mark - VHallMoviePlayerDelegate
/**
 *  包含文档 获取翻页图片路径
 *
 *  @param changeImage  图片更新
 */
- (void)PPTScrollNextPagechangeImagePath:(NSString*)changeImagePath {
    
}
/**
 *  获取视频播放模式
 *
 *  @param playMode  视频播放模式
 */
- (void)VideoPlayMode:(VHMovieVideoPlayMode)playMode {
    Log(@"model %ld",(long)playMode);
    
}
/**
 *  获取视频活动状态
 *
 *  @param playMode  视频活动状态
 */
- (void)ActiveState : (VHMovieActiveState)activeState {
    switch (activeState) {
        case VHMovieActiveStateLive:
            Log(@"解盘");
            break;
        case VHMovieActiveStateReservation:
            Log(@"预约");
            break;
        case VHMovieActiveStateEnd:
            Log(@"结束");
            [self showNoDataView:2];
            break;
        case VHMovieActiveStateReplay:
            Log(@"回放");
            break;
        default:
            break;
    }
    
}

/**
 *  该解盘支持的清晰度列表
 *
 *  @param definitionList  支持的清晰度列表
 */
- (void)VideoDefinitionList: (NSArray*)definitionList {
    Log(@"definitionList %@ , %ld",definitionList,self.vhMoviePlayer.defaultDefinition);
    
    self.definitionList = definitionList;
    //    self.definitionArray = [NSArray arrayWithArray:definitionList];
    NSInteger minDefinition = [[definitionList valueForKeyPath:@"@min.integerValue"] integerValue];
    //根据返回的清晰度 刷新UI 规则：如果最小值是原画0 那么低于原画的清晰度默认全都有
    [self.definitionListView mas_updateConstraints:^(MASConstraintMaker *make) {
       make.size.mas_equalTo(CGSizeMake(50, 25*(kVHMovieDefinitionCount-minDefinition)));
    }];
    [self.bigDefinitionListView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 40*(kVHMovieDefinitionCount-minDefinition)));
    }];
}

/**
 *  直播结束 如果视频正在播放 等下一次loading 解盘即结束
 *
 *  直播结束
 */
- (void)LiveStoped {
    Log(@"解盘结束");
    if (self.isFullScreen) {
//        ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
        [self doEndFullScreen];
    }
    [self.vhMoviePlayer stopPlay];
    [self showHideView];
    [self showNoDataView:2];
    if ([self.delegate respondsToSelector:@selector(liveVideoFinish:)]) {
        [self.delegate liveVideoFinish:self];
    }
//    [[NSNotificationCenter defaultCenter] postNotificationName:kSetVideoLiveStateNotification object:nil userInfo:@{@"LIVESTATE":@{@"status":@(0),@"vhall":@(0)}}];
}

#pragma mark - getters and setters

-(NSInteger)playerState
{
    return self.vhMoviePlayer.playerState;
}

-(VHallMoviePlayer *)vhMoviePlayer{
    if (_vhMoviePlayer == nil) {
        _vhMoviePlayer = [[VHallMoviePlayer alloc]initWithDelegate:self];
        _vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFit;
        [_vhMoviePlayer setCurDefinition:VHMovieDefinitionHD];
    }
    return _vhMoviePlayer;
}

-(UIView *)smallView{
    if (_smallView == nil) {
        _smallView = [[UIView alloc] initWithFrame:CGRectZero];
        _smallView.backgroundColor = HEXA(@"#000000", 0.2);
        _smallView.layer.masksToBounds = YES;
        _smallView.layer.cornerRadius = 5;
    }
    return _smallView;
}

-(UIView *)smallTapView{
    if (_smallTapView == nil) {
        _smallTapView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _smallTapView;
}

-(HSCSLiveNoDataView *)smallLiveNoDataView{
    if (_smallLiveNoDataView == nil) {
        _smallLiveNoDataView = [[HSCSLiveNoDataView alloc] initWithFrame:CGRectZero];
        _smallLiveNoDataView.hidden = YES;
    }
    return _smallLiveNoDataView;
}

-(UIButton *)playButton{
    if (_playButton == nil) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playButton.tag = 1000;
        [_playButton setImage:[UIImage imageNamed:@"watch_back_play_icon"] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
- (UIButton *)screenButton{
    if (_screenButton == nil) {
        _screenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _screenButton.tag = 1001;
        [_screenButton setImage:[UIImage imageNamed:@"watch_back_fullscreem_icon"] forState:UIControlStateNormal];
        [_screenButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenButton;
}

- (UIButton *)volumeButton{
    if (_volumeButton == nil) {
        _volumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _volumeButton.tag = 1002;
        [_volumeButton setImage:[UIImage imageNamed:@"watch_back_ volume_icon"] forState:UIControlStateNormal];
        [_volumeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _volumeButton;
}

-(UIButton *)definitionButton{
    if (_definitionButton == nil) {
        _definitionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _definitionButton.tag = 1004;
        _definitionButton.backgroundColor = [UIColor whiteColor];
        _definitionButton.layer.cornerRadius = 11;
        [_definitionButton setTitle:@"高清" forState:UIControlStateNormal];
        [_definitionButton setTitleColor:HEX(@"#1C1E23") forState:UIControlStateNormal];
        _definitionButton.titleLabel.font = FONT_PingFang_Medium(16);
        [_definitionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _definitionButton;
}

-(HSCSDefinitionListView *)definitionListView{
    if (_definitionListView == nil) {
        _definitionListView = [[HSCSDefinitionListView alloc] initWithFrame:CGRectMake(0, 0, 60, 90)];
        _definitionListView.hidden = YES;
        _definitionListView.delegate = self;
        _definitionListView.minDefinition = 0;
        [_definitionListView selectWith:2];
    }
    return _definitionListView;
}

-(UIView *)bigView{
    if (_bigView == nil) {
        _bigView = [[UIView alloc] initWithFrame:CGRectZero];
        _bigView.backgroundColor = HEXA(@"#000000", 0.2);
        _bigView.hidden = YES;
    }
    return _bigView;
}

-(UIView *)bigTapView{
    if (_bigTapView == nil) {
        _bigTapView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bigTapView;
}

-(UIButton *)bigBackButton{
    if (_bigBackButton == nil) {
        _bigBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigBackButton.tag = 1003;
        [_bigBackButton setImage:[UIImage imageNamed:@"video_back_withe_icon"] forState:UIControlStateNormal];
        [_bigBackButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigBackButton;
}

-(UILabel *)bigTitleLabel{
    if (_bigTitleLabel == nil) {
        _bigTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bigTitleLabel.textColor = HEX(@"#FFFFFF");
        _bigTitleLabel.font = [UIFont PingFangSCBold:16];
    }
    return _bigTitleLabel;
}

-(UIButton *)bigPlayButton{
    if (_bigPlayButton == nil) {
        _bigPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigPlayButton.tag = 1000;
        [_bigPlayButton setImage:[UIImage imageNamed:@"watch_back_full_pause_icon"] forState:UIControlStateNormal];
        [_bigPlayButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigPlayButton;
}

- (UIButton *)bigScreenButton{
    if (_bigScreenButton == nil) {
        _bigScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigScreenButton.tag = 1001;
        [_bigScreenButton setImage:[UIImage imageNamed:@"watch_back_smallscreem_icon"] forState:UIControlStateNormal];
        [_bigScreenButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigScreenButton;
}

- (UIButton *)bigVolumeButton{
    if (_bigVolumeButton == nil) {
        _bigVolumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigVolumeButton.tag = 1002;
        [_bigVolumeButton setImage:[UIImage imageNamed:@"watch_back_ volume_fullscreen_icon"] forState:UIControlStateNormal];
        [_bigVolumeButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigVolumeButton;
}

-(UIButton *)bigDefinitionButton{
    if (_bigDefinitionButton == nil) {
        _bigDefinitionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigDefinitionButton.tag = 1004;
        _bigDefinitionButton.backgroundColor = [UIColor whiteColor];
        _bigDefinitionButton.layer.cornerRadius = 11;
        [_bigDefinitionButton setTitle:@"原画" forState:UIControlStateNormal];
        [_bigDefinitionButton setTitleColor:HEX(@"#1C1E23") forState:UIControlStateNormal];
        _bigDefinitionButton.titleLabel.font = FONT_PingFang_Medium(16);
        [_bigDefinitionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigDefinitionButton;
}

-(UIButton *)brightnessButton{
    if (_brightnessButton == nil) {
        _brightnessButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _brightnessButton.tag = 1005;
        [_brightnessButton setImage:[UIImage imageNamed:@"watch_live_light_icon"] forState:UIControlStateNormal];
        [_brightnessButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _brightnessButton;
}

-(UIButton *)lockButton{
    if (_lockButton == nil) {
        _lockButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lockButton.tag = 1006;
        _lockButton.hidden = YES;
        [_lockButton setImage:[UIImage imageNamed:@"watch_live_unlock_icon"] forState:UIControlStateNormal];
        [_lockButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lockButton;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bgView;
}

-(HSCSDefinitionListView *)bigDefinitionListView{
    if (_bigDefinitionListView == nil) {
        _bigDefinitionListView = [[HSCSDefinitionListView alloc] initWithFrame:CGRectMake(0, 0, 70, 120)];
        _bigDefinitionListView.hidden = YES;
        _bigDefinitionListView.delegate = self;
        _bigDefinitionListView.minDefinition = 0;
        [_bigDefinitionListView selectWith:2];
    }
    return _bigDefinitionListView;
}

-(HSCSLiveVideoLightView *)liveVideoLightView{
    if (_liveVideoLightView == nil) {
        _liveVideoLightView = [[HSCSLiveVideoLightView alloc] initWithFrame:CGRectZero];
        _liveVideoLightView.hidden = YES;
    }
    return _liveVideoLightView;
}

-(HSCSLiveNoDataView *)bigLiveNoDataView{
    if (_bigLiveNoDataView == nil) {
        _bigLiveNoDataView = [[HSCSLiveNoDataView alloc] initWithFrame:CGRectZero];
        _bigLiveNoDataView.hidden = YES;
    }
    return _bigLiveNoDataView;
}

@end
