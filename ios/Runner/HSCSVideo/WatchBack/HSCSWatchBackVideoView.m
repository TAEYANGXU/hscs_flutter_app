
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
//        File Name:       HSCSWatchBackVideoView.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/5/25 3:22 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "HSCSWatchBackVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import <VHLiveSDK/VHallApi.h>
#import "HSCSCustomSlider.h"
#import "HSCSLiveNoDataView.h"
#import "NSString+MD5.h"
#import "HSCSWatchBackSpeedView.h"
#import "UIDevice+Mode.h"
#import "HSCSWatchBackVideoHelper.h"
#import <YYText/YYText.h>
#import "Masonry.h"
#import "AppUtils.h"
#import "HSCSHUD.h"
#import "AppConst.h"
#import <XyWidget/UIView+Frame.h>
#import <XyWidget/UIView+Additions.h>
#import "UIImageView+WebCache.h"
#import <XyWidget/UIFont+PingFangSC.h>
//控制面板隐藏时间
static const NSTimeInterval TimeInterval = 6.0;

@interface HSCSWatchBackVideoView()<VHallMoviePlayerDelegate>

//微吼视频播放器
@property(nonatomic,strong) VHallMoviePlayer          *vhMoviePlayer;
//
@property(nonatomic,copy) UIImageView   *coverImageView;
//
@property(nonatomic,copy) UIView   *bgView;
//是否全屏
@property(nonatomic,assign)   BOOL  isFullScreen;
//位置
@property (nonatomic,assign)  HSCSWatchBackVideoViewPositionType positionType;
//加载失败
@property(nonatomic,copy) HSCSLiveNoDataView *noDataView;
@property(nonatomic,copy) UIButton      *restartButton;

//**************************小屏***************************//
@property(nonatomic,copy) UIView   *smallView;

@property(nonatomic,copy) UIView   *smallTapView;
//播放
@property(nonatomic,copy) UIButton *smallPlayButton;
//标题
@property(nonatomic,copy) UILabel  *smallTitleLabel;
//进度条
@property(nonatomic,copy) HSCSCustomSlider *progressSlider;
//进度条2
@property(nonatomic,copy) UIProgressView *botProgressSlider;
//剩余和总时长
@property(nonatomic,copy) UILabel *timeValueLabel;
//全屏
@property(nonatomic,copy) UIButton *screenButton;
//倍数
@property(nonatomic,copy) UIButton             *smallSpeedButton;
//
@property(nonatomic,copy) UIButton             *smallNextButton;
//
@property (nonatomic, copy) UILabel     *videoTypeLabel;
//历史播放
@property (nonatomic, copy) YYLabel     *smallHistoryTimeLabel;

@property(nonatomic,copy) UIView *speedView;
@property(nonatomic,copy) HSCSWatchBackSpeedView *smallSpeedView;

//**************************全屏***************************//
@property(nonatomic,copy) UIView   *bigView;

@property(nonatomic,copy) UIView   *bigTapView;
//播放
@property(nonatomic,copy) UIButton *bigsmallPlayButton;
//标题
@property(nonatomic,copy) UILabel  *bigTitleLabel;
//返回
@property(nonatomic,copy) UIButton *bigBackButton;
//进度条
@property(nonatomic,copy) HSCSCustomSlider *bigProgressSlider;
//时长
@property(nonatomic,copy) UILabel  *bigTimeValueLabel;
//时长
@property(nonatomic,copy) UILabel  *bigTotalTimeValueLabel;
//全屏
@property(nonatomic,copy) UIButton *bigScreenButton;
//倍数
@property(nonatomic,copy) UIButton             *bigSpeedButton;
//
@property(nonatomic,copy) UIButton             *bigNextButton;
//历史播放
@property (nonatomic, copy) YYLabel     *bigHistoryTimeLabel;

//记录是否在拖动slider
@property(nonatomic,assign)BOOL isSlider;

@property(nonatomic,assign)BOOL canPerform;


@property(nonatomic,assign)CGRect superFrame;

@property(nonatomic,strong) NSString *vId;
@property(nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSArray *speedImageArray;
@property (nonatomic,strong) NSArray *bigSpeedImageArray;
@property (nonatomic,strong) NSArray *speedValueArray;

@end

@implementation HSCSWatchBackVideoView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame position:(HSCSWatchBackVideoViewPositionType)position
{
    self = [super initWithFrame:frame];
    if (self) {
        self.positionType = position;
        [self makeUpUI];
        [self makeLayout];
        [self configControlAction];
    }
    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, self.width, 200);
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame;
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUpUI];
        [self makeLayout];
        [self configControlAction];
        self.superFrame = frame;
        self.vhMoviePlayer.moviePlayerView.frame = frame;
        self.noDataView.frame = self.superFrame;
    }
    return self;
}

- (void)makeUpUI
{
    [self addSubview:self.vhMoviePlayer.moviePlayerView];
    [self sendSubviewToBack:self.vhMoviePlayer.moviePlayerView];
    
    [self.vhMoviePlayer.moviePlayerView addSubview:self.coverImageView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.bgView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.smallView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.noDataView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.bigView];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.botProgressSlider];
    [self.vhMoviePlayer.moviePlayerView addSubview:self.speedView];
    
    [self.noDataView addSubview:self.restartButton];
    
    [self.smallView addSubview:self.smallTapView];
    [self.smallView addSubview:self.smallTitleLabel];
    [self.smallView addSubview:self.smallPlayButton];
    [self.smallView addSubview:self.progressSlider];
    [self.smallView addSubview:self.timeValueLabel];
    [self.smallView addSubview:self.screenButton];
    [self.smallView addSubview:self.smallSpeedButton];
    [self.smallView addSubview:self.videoTypeLabel];
    [self.smallView addSubview:self.smallNextButton];
    [self.smallView addSubview:self.smallHistoryTimeLabel];
    
    self.timeValueLabel.text = @"0:00/0:00";
    
    
    [self.bigView addSubview:self.bigTapView];
    [self.bigView addSubview:self.bigBackButton];
    [self.bigView addSubview:self.bigTitleLabel];
    [self.bigView addSubview:self.bigsmallPlayButton];
    [self.bigView addSubview:self.bigProgressSlider];
    [self.bigView addSubview:self.bigTimeValueLabel];
    [self.bigView addSubview:self.bigTotalTimeValueLabel];
    [self.bigView addSubview:self.bigScreenButton];
    [self.bigView addSubview:self.bigSpeedButton];
    [self.bigView addSubview:self.bigNextButton];
    [self.bigView addSubview:self.bigHistoryTimeLabel];
    
    [self.speedView addSubview:self.smallSpeedView];
    
//    self.bigTitleLabel.text = @"2019/01/09 视频报告会";
    self.bigTimeValueLabel.text = @"0:00";
    self.bigTotalTimeValueLabel.text = @"0:00";
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.bgView addGestureRecognizer:tapGes];
    UITapGestureRecognizer *tapGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.smallTapView addGestureRecognizer:tapGes1];
    UITapGestureRecognizer *tapGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.bigTapView addGestureRecognizer:tapGes2];
    UITapGestureRecognizer *tapGes3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(speedTapAction)];
    [self.speedView addGestureRecognizer:tapGes3];
}

- (void)makeLayout{
    
    [self.restartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
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
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    [self.smallTapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-50);
        make.top.mas_equalTo(0);
    }];
    
    [self.smallTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(45);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
    }];
    
    [self.videoTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.smallTitleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(HeightScale(36), HeightScale(20)));
        make.left.mas_equalTo(HeightScale(50));
    }];
    
    [self.screenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    [self.smallNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.timeValueLabel.mas_centerY);
        make.left.equalTo(self.smallPlayButton.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [self.smallPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
//        make.centerY.mas_equalTo(self.bigView.mas_centerY);
        make.centerY.mas_equalTo(self.timeValueLabel.mas_centerY);
        make.left.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.left.mas_equalTo(5);
//        make.size.mas_equalTo(CGSizeMake(40, 45));
    }];
    [self.timeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(90);
//        make.left.equalTo(self.smallNextButton.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(85, 40));
    }];
    [self.smallSpeedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-1);
        make.size.mas_equalTo(CGSizeMake(HeightScale(50), HeightScale(50)));
    }];
    
    [self.smallHistoryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-40);
        make.height.mas_equalTo(HeightScale(25));
        make.width.mas_equalTo(HeightScale(210));
    }];
    
    WS(weakSelf)
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.equalTo(self.screenButton.mas_left).offset(0);
//        make.right.equalTo(self.timeValueLabel.mas_left).offset(-8);
        make.left.equalTo(weakSelf.timeValueLabel.mas_right).offset(5);
        make.height.mas_equalTo(40);
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
    [self.bigTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.bigScreenButton.mas_centerY);
        make.left.mas_equalTo(120);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    [self.bigProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.bigScreenButton.mas_centerY);
        make.right.mas_equalTo(-120);
        make.left.equalTo(self.bigTimeValueLabel.mas_right).offset(5);
        make.height.mas_equalTo(45);
    }];
    [self.bigTotalTimeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.bigScreenButton.mas_centerY);
        make.left.equalTo(self.bigProgressSlider.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    [self.bigScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo([UIDevice isIPhoneXFull] ? -20 : -5);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    [self.bigsmallPlayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 45));
        make.centerY.mas_equalTo(self.bigScreenButton.mas_centerY);
        make.left.mas_equalTo(20);
    }];
    [self.bigNextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.bigScreenButton.mas_centerY);
        make.left.equalTo(self.bigsmallPlayButton.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    [self.bigHistoryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-60);
        make.width.mas_equalTo(HeightScale(210));
        make.height.mas_equalTo(HeightScale(25));
    }];
    [self.bigSpeedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.botProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_equalTo(3);
    }];
    
    [self.speedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.smallSpeedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(HeightScale(90));
    }];
    
    self.speedImageArray = @[@"small_speed_0.5",@"small_speed_1",@"small_speed_1.25",@"small_speed_1.5",@"small_speed_2"];
    self.bigSpeedImageArray = @[@"big_speed_0.5",@"big_speed_1",@"big_speed_1.25",@"big_speed_1.5",@"big_speed_2"];
    self.speedValueArray = @[@(0.5),@(1.0),@(1.25),@(1.5),@(2.0)];
    [self.smallSpeedView makeLayout:self.size.height];
    //点播倍速播放速率 0.50, 0.67, 0.80, 1.0, 1.25, 1.50, and 2.0
    self.smallSpeedView.speedSelectBlock = ^(NSInteger index) {
        CGFloat rate = [weakSelf.speedValueArray[index] floatValue];
        weakSelf.vhMoviePlayer.rate = rate;
        [weakSelf speedTapAction];
        [weakSelf.smallSpeedButton setImage:[UIImage imageNamed:weakSelf.speedImageArray[index]] forState:UIControlStateNormal];
        [weakSelf.bigSpeedButton setImage:[UIImage imageNamed:weakSelf.bigSpeedImageArray[index]] forState:UIControlStateNormal];
    };
}

- (void)dealloc
{
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    Log(@"destory : %@",[self class]);
}

#pragma mark - private methods
//**播放视频**//
- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title{
    
    self.vId = [AppUtils nullEmpty:vId];
    self.title = [AppUtils nullEmpty:title];
    self.noDataView.hidden = YES;
    self.smallView.hidden = NO;
    self.canPerform = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self showHistoryTime];
    if (self.vhMoviePlayer.moviePlayerView) {
        [HSCSHUD showProgressHUDAddedToVideoView:self.vhMoviePlayer.moviePlayerView];
    }
    self.bigTitleLabel.text = [AppUtils nullEmpty:title];
    self.smallTitleLabel.text = [AppUtils nullEmpty:title];
    [self.vhMoviePlayer stopPlay];
//    NSString *iphone = [NSString stringWithFormat:@"%@password",[AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.mobile]];
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    param[@"id"] = [AppUtils nullEmpty:vId];
//    param[@"name"] = [AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.nickname];
//    param[@"email"] = [AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.vhallEmail];
    if (self.vhMoviePlayer) {
        [self.vhMoviePlayer startPlayback:param];
    }
}

- (void)nextStartPlayerWithId:(NSString *)vId title:(NSString *)title{
    
    self.vId = [AppUtils nullEmpty:vId];
    self.title = [AppUtils nullEmpty:title];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self showHistoryTime];
    if (self.vhMoviePlayer.moviePlayerView) {
        [HSCSHUD showProgressHUDAddedToVideoView:self.vhMoviePlayer.moviePlayerView];
    }
    self.bigTitleLabel.text = [AppUtils nullEmpty:title];
    self.smallTitleLabel.text = [AppUtils nullEmpty:title];
//    [self.vhMoviePlayer stopPlay];
//    NSString *iphone = [NSString stringWithFormat:@"%@password",[AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.mobile]];
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
    param[@"id"] = [AppUtils nullEmpty:vId];
//    param[@"name"] = [AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.nickname];
//    param[@"email"] = [AppUtils nullEmpty:[HSCSUserInfoManager sharedManager].userInfo.vhallEmail];
    if (self.vhMoviePlayer) {
        [self.vhMoviePlayer startPlayback:param];
    }
}

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg
{
    self.canPerform = YES;
    self.smallView.hidden = NO;
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *picUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%.f/h/%.f",surfaceImg,SCREEN_WIDTH*2, self.frame.size.height * 2];
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:picUrl]];
    [self startPlayerWithId:vId title:title];
}

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg showNext:(BOOL)show
{
    if (!show) {
        self.smallNextButton.hidden = YES;
        self.bigNextButton.hidden = YES;
        [self.bigTimeValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(70);
        }];
        [self.timeValueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(40);
        }];
        self.vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFill;
        [self.smallView layoutIfNeeded];
    }
    self.canPerform = YES;
    self.smallView.hidden = NO;
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    NSString *picUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%.f/h/%.f",surfaceImg,SCREEN_WIDTH*2, self.frame.size.height * 2];
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:picUrl]];
    [self startPlayerWithId:vId title:title];
}

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg isBack:(BOOL)isBack completeBlock: (PlayCompleteBlock)completeBlock nextVideoBlock:(NextVideoBlock)nextVideoBlock
{
    self.canPerform = YES;
    self.smallView.hidden = NO;
    self.videoTypeLabel.hidden = !isBack;
    self.completeBlock = [completeBlock copy];
    self.nextVideoBlock = [nextVideoBlock copy];
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *picUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%.f/h/%.f",surfaceImg,SCREEN_WIDTH*2, self.frame.size.height * 2];
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:picUrl]];
    [self startPlayerWithId:vId title:title];
}

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg currentTimeBlock:(CurrentTimeBlock)currentTimeBlock
{
    self.canPerform = YES;
    self.smallView.hidden = NO;
    self.currentTimeBlock = [currentTimeBlock copy];
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *picUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%.f/h/%.f",surfaceImg,SCREEN_WIDTH*2, self.frame.size.height * 2];
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:picUrl]];
    [self startPlayerWithId:vId title:title];
}

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg
            completeBlock: (PlayCompleteBlock)completeBlock nextVideoBlock:(NextVideoBlock)nextVideoBlock
{
    self.canPerform = YES;
    self.smallView.hidden = NO;
    self.completeBlock = [completeBlock copy];
    self.nextVideoBlock = [nextVideoBlock copy];
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *picUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%.f/h/%.f",surfaceImg,SCREEN_WIDTH*2, self.frame.size.height * 2];
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:picUrl]];
    [self startPlayerWithId:vId title:title];
}

- (void)nextPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg
            completeBlock: (PlayCompleteBlock)completeBlock nextVideoBlock:(NextVideoBlock)nextVideoBlock
{
    
    
    [self.coverImageView removeFromSuperview];
    [self.bgView removeFromSuperview];
    [self.smallView removeFromSuperview];
    [self.noDataView removeFromSuperview];
    [self.bigView removeFromSuperview];
    [self.botProgressSlider removeFromSuperview];
    [self.speedView removeFromSuperview];
    
    [self.restartButton removeFromSuperview];
    [self.smallTapView removeFromSuperview];
    [self.smallTitleLabel removeFromSuperview];
    [self.smallPlayButton removeFromSuperview];
    [self.progressSlider removeFromSuperview];
    [self.timeValueLabel removeFromSuperview];
    [self.screenButton removeFromSuperview];
    [self.smallSpeedButton removeFromSuperview];
    [self.videoTypeLabel removeFromSuperview];
    [self.smallNextButton removeFromSuperview];
    
    [self.bigTapView removeFromSuperview];
    [self.bigBackButton removeFromSuperview];
    [self.bigTitleLabel removeFromSuperview];
    [self.bigsmallPlayButton removeFromSuperview];
    [self.bigProgressSlider removeFromSuperview];
    [self.bigTimeValueLabel removeFromSuperview];
    [self.bigTotalTimeValueLabel removeFromSuperview];
    [self.bigScreenButton removeFromSuperview];
    [self.bigSpeedButton removeFromSuperview];
    [self.bigNextButton removeFromSuperview];
    [self.smallSpeedView removeFromSuperview];
    
    for (UIView *view in self.smallView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.bigView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in self.speedView.subviews) {
        [view removeFromSuperview];
    }
    
    _coverImageView = nil;
    _bgView = nil;
    _smallView = nil;
    _noDataView = nil;
    _bigView = nil;
    _botProgressSlider = nil;
    _speedView = nil;
    
    [self close];
    
    self.vhMoviePlayer = [[VHallMoviePlayer alloc]initWithDelegate:self];
    self.vhMoviePlayer.moviePlayerView.backgroundColor = [UIColor blackColor];
    self.vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFit;
    
    self.vhMoviePlayer.moviePlayerView.frame = self.superFrame;
    self.noDataView.frame = self.superFrame;
    Log(@"nextPlayerWithId ------------ ");
    [self makeUpUI];
    [self makeLayout];
    [self configControlAction];
    [self showHistoryTime];
    
    if (self.vhMoviePlayer.moviePlayerView) {
        [HSCSHUD showProgressHUDAddedToVideoView:self.vhMoviePlayer.moviePlayerView];
    }
    
    self.smallView.hidden = NO;
    self.bigView.hidden = YES;
    
    if (self.isFullScreen) {
        self.smallView.hidden = YES;
        self.bigView.hidden = NO;
        self.botProgressSlider.hidden = YES;
        self.vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFit;
//        [self fullScreen:self.isFullScreen];
        [MAIN_WINDOW addSubview:self.vhMoviePlayer.moviePlayerView];
        CGFloat width = SCREEN_HEIGHT;
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(width);
        }];
        self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.noDataView.frame = self.vhMoviePlayer.moviePlayerView.frame;
        [self.smallSpeedView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.width.mas_equalTo(140);
        }];
        [self.smallSpeedView makeLayout:self.superFrame.size.width];
//        [self.vhMoviePlayer.moviePlayerView layoutIfNeeded];
    }
    
    self.botProgressSlider.progress = 0;
    self.canPerform = YES;
    self.completeBlock = [completeBlock copy];
    self.nextVideoBlock = [nextVideoBlock copy];
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString *picUrl = [NSString stringWithFormat:@"%@?imageView2/1/w/%.f/h/%.f",surfaceImg,SCREEN_WIDTH*2, self.frame.size.height * 2];
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:picUrl]];
    [self nextStartPlayerWithId:vId title:title];
}

-(void)setSurfaceImg:(NSString *)surfaceImg
{
    _surfaceImg = surfaceImg;
    [self.coverImageView sd_setImageWithURL: [NSURL URLWithString:surfaceImg]];
}

- (void)pausePlay
{
    [self.vhMoviePlayer pausePlay];
}

- (void)reconnectPlay
{
    [self.vhMoviePlayer reconnectPlay];
}

- (void)configControlAction{
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self setProgressSliderMaxMinValues];
    [self monitorVideoPlayback];
}

- (void)showHistoryTime
{
    double time = [[HSCSWatchBackVideoHelper shareInstance] timeWithKey:self.vId];
    if (time > 0) {
        
        self.smallHistoryTimeLabel.hidden = NO;
        self.bigHistoryTimeLabel.hidden = NO;
        
        double minutesElapsed = floor(time / 60.0);
        double secondsElapsed = fmod(time, 60.0);
        NSString *timeElapsedString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
        
        NSMutableAttributedString *smallText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"记录您上次播放到%@ 点击跳转",timeElapsedString] attributes:@{NSFontAttributeName:[UIFont PingFangSCRegular:13], NSForegroundColorAttributeName: [UIColor whiteColor]}];
        //设置高亮色和点击事件
        smallText.yy_alignment = NSTextAlignmentCenter;
        WS(weakSelf)
        [smallText yy_setTextHighlightRange:[[smallText string] rangeOfString:@" 点击跳转"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            Log(@"  点击跳转1");
            if (weakSelf.vhMoviePlayer.moviePlayerView) {
                [HSCSHUD showProgressHUDAddedToVideoView:weakSelf.vhMoviePlayer.moviePlayerView];
            }
            weakSelf.smallHistoryTimeLabel.hidden = YES;
            weakSelf.bigHistoryTimeLabel.hidden = YES;
            [weakSelf.vhMoviePlayer setCurrentPlaybackTime:time];
        }];
        self.smallHistoryTimeLabel.attributedText = smallText;
        
        NSMutableAttributedString *bigText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"记录您上次播放到%@ 点击跳转",timeElapsedString] attributes:@{NSFontAttributeName:[UIFont PingFangSCRegular:13], NSForegroundColorAttributeName: [UIColor whiteColor]}];
        //设置高亮色和点击事件
        bigText.yy_alignment = NSTextAlignmentCenter;
        [bigText yy_setTextHighlightRange:[[bigText string] rangeOfString:@" 点击跳转"] color:[UIColor orangeColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            Log(@"  点击跳转2");
            if (weakSelf.vhMoviePlayer.moviePlayerView) {
                [HSCSHUD showProgressHUDAddedToVideoView:weakSelf.vhMoviePlayer.moviePlayerView];
            }
            weakSelf.bigHistoryTimeLabel.hidden = YES;
            weakSelf.smallHistoryTimeLabel.hidden = YES;
            [weakSelf.vhMoviePlayer setCurrentPlaybackTime:time];
        }];
        self.bigHistoryTimeLabel.attributedText = bigText;
    }
}

//**更新进度条**//
- (void)monitorVideoPlayback
{
    double currentTime = self.vhMoviePlayer.currentPlaybackTime;
    double totalTime = self.vhMoviePlayer.duration;
    [self setTimeLabelValues:currentTime totalTime:totalTime];
    if (self.isSlider) {//拖动slider时 不更新进度,时间依然更新
        return;
    }
    CGFloat duration = self.vhMoviePlayer.duration;
    if (duration > 0 && currentTime > 0) {
        self.botProgressSlider.progress = currentTime/duration;
    }
    self.progressSlider.value = floor(currentTime);
    self.bigProgressSlider.value = floor(currentTime);
}

//**设置进度条的初始值**//
- (void)setProgressSliderMaxMinValues {
    
    CGFloat duration = self.vhMoviePlayer.duration;
    self.progressSlider.minimumValue = 0.0f;
    self.progressSlider.maximumValue = floor(duration);
    self.bigProgressSlider.minimumValue = 0.0f;
    self.bigProgressSlider.maximumValue = floor(duration);
}

//**更新进度时间**//
- (void)setTimeLabelValues:(double)currentTime totalTime:(double)totalTime {
    
    double minutesElapsed = floor(currentTime / 60.0);
    if (currentTime == 0) {
        minutesElapsed = 0.00;
    }
    double secondsElapsed = fmod(currentTime, 60.0);
    NSString *timeElapsedString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesElapsed, secondsElapsed];
    
    double minutesRemaining = floor(totalTime / 60.0);;
    double secondsRemaining = floor(fmod(totalTime, 60.0));;
    NSString *timeRmainingString = [NSString stringWithFormat:@"%02.0f:%02.0f", minutesRemaining, secondsRemaining];
    
    self.timeValueLabel.text = [NSString stringWithFormat:@"%@/%@",timeElapsedString,timeRmainingString];
    self.bigTimeValueLabel.text = timeElapsedString;
    self.bigTotalTimeValueLabel.text = timeRmainingString;
    
    //记录用户播放位置
    [[HSCSWatchBackVideoHelper shareInstance] saveTime:currentTime forKey:self.vId];
}

//**销毁播放器**//
- (void)close
{
    Log(@"close ss");
    [self.bgView removeFromSuperview];
    [self.bigView removeFromSuperview];
    [self.smallView removeFromSuperview];
    [self.coverImageView removeFromSuperview];
    [self.vhMoviePlayer.moviePlayerView removeFromSuperview];
    [self.vhMoviePlayer destroyMoivePlayer];
    [self cancelObserver];
    self.vhMoviePlayer.delegate = nil;
    self.vhMoviePlayer = nil;
}

- (BOOL)isPlaying
{
    if (self.vhMoviePlayer.playerState == VHPlayerStatePlaying || self.vhMoviePlayer.playerState == VHPlayerStateStarting) {
        return YES;
    }
    return NO;
}

- (void)stopPlay
{
//    self.smallView.hidden = YES;
    if (self.vhMoviePlayer.playerState == VHPlayerStatePlaying) {
        [self.vhMoviePlayer stopPlay];
    }
}

- (void)cancelObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)fullScreen:(BOOL)state{
    if (state) {
        //全屏
        self.smallView.hidden = YES;
        self.bigView.hidden = NO;
        self.isFullScreen = YES;
    }else{
        //退出全屏
        self.smallView.hidden = NO;
        self.bigView.hidden = YES;
        self.isFullScreen = NO;
    }
    self.canPerform = YES;
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
//    [self performSelector:@selector(canHiden) withObject:self afterDelay:TimeInterval];
}

- (void) resetButtonImageWithStop
{
    [self.smallPlayButton setImage:[UIImage imageNamed:@"watch_back_play_icon"] forState:UIControlStateNormal];
    [self.bigsmallPlayButton setImage:[UIImage imageNamed:@"watch_back_play_icon"] forState:UIControlStateNormal];
//    [self.bigsmallPlayButton setImage:[UIImage imageNamed:@"watch_back_full_play_icon"] forState:UIControlStateNormal];
}

- (void) resetButtonImageWithPlay
{
    [self.smallPlayButton setImage:[UIImage imageNamed:@"watch_back_pause_icon"] forState:UIControlStateNormal];
//    [self.bigsmallPlayButton setImage:[UIImage imageNamed:@"watch_back_full_pause_icon"] forState:UIControlStateNormal];
    [self.bigsmallPlayButton setImage:[UIImage imageNamed:@"watch_back_pause_icon"] forState:UIControlStateNormal];
}

- (void)hideHUD
{
    if (self.vhMoviePlayer.playerState == VHPlayerStatePlaying) {
        [HSCSHUD hideHUDTo:self.vhMoviePlayer.moviePlayerView];
    }
}

/*
 *status 1失败 2结束
 */
- (void) showNoDataView:(NSInteger)status
{
    self.noDataView.hidden = NO;
    self.noDataView.status = status;
}

#pragma mark - VHMoviePlayerDelegate
- (void)playError:(VHSaasLivePlayErrorType)livePlayErrorType info:(NSDictionary *)info;
{
    [HSCSHUD hideHUDTo:self.vhMoviePlayer.moviePlayerView];
//    [self performSelector:@selector(hideHUD) withObject:self afterDelay:3];
    NSString * msg = @"";
    switch (livePlayErrorType) {
        case VHSaasLivePlayGetUrlError:
        {
            msg = @"获取活动信息错误";
            Log(@"%@",msg);
            [self showNoDataView:1];
        }
            break;
        case VHSaasVodPlayError:
        {
            Log( @"播放失败 %@ %@",info[@"code"],info[@"content"]);
            [self showNoDataView:1];
        }
            break;
        case VHSaasLivePlayRecvError:
        {
            Log( @"播放失败 %@ %@",info[@"code"],info[@"content"]);
            [self showNoDataView:1];
        }
            break;
        case VHSaasLivePlayParamError:
        {
            Log( @"播放失败 %@ %@",info[@"code"],info[@"content"]);
            [self showNoDataView:1];
        }
            break;
        case VHSaasLivePlayCDNConnectError:
        {
            Log( @"播放失败 %@ %@",info[@"code"],info[@"content"]);
            [self showNoDataView:1];
        }
            break;
        default:
            break;
    }
}

-(void)ActiveState:(VHMovieActiveState)activeState
{
    Log(@"activeState-%ld",(long)activeState);
    if (activeState == VHMovieActiveStateEnd) {
        Log(@"播放结束");
    }
}


/**
 *  该直播支持的清晰度列表
 *
 *  @param definitionList  支持的清晰度列表
 */
- (void)VideoDefinitionList:(NSArray*)definitionList
{
   
}

-(void)bufferStart:(VHallMoviePlayer *)moviePlayer info:(NSDictionary *)info
{
    Log(@"bufferStart");
}

-(void)bufferStop:(VHallMoviePlayer *)moviePlayer info:(NSDictionary *)info
{
    Log(@"bufferStop");
}

- (void)moviePlayer:(VHallMoviePlayer *)player statusDidChange:(int)state
{
    switch (state) {
        case VHPlayerStateStoped:
//            [HSCSHUD hideHUDTo:self.vhMoviePlayer.moviePlayerView];
            [self resetButtonImageWithStop];
            if (player.currentPlaybackTime != player.duration) {
//                [self performSelector:@selector(showHideView) withObject:self afterDelay:0.2];
            }
            break;
        case VHPlayerStateStarting:
            Log(@"开始");
            [self monitorVideoPlayback];
            break;
        case VHPlayerStatePlaying:
            Log(@"播放");
            [self resetButtonImageWithPlay];
            [[self class] cancelPreviousPerformRequestsWithTarget:self];
            if (!self.smallView.hidden || !self.bigView.hidden) {
                self.canPerform = YES;
            }
//            [self performSelector:@selector(canHiden) withObject:self afterDelay:TimeInterval];
//            [self performSelector:@selector(canHiden) withObject:self afterDelay:2];
            break;
        case VHPlayerStatePause:
            Log(@"暂停");
//            [HSCSHUD hideHUDTo:self.vhMoviePlayer.moviePlayerView];
            [self resetButtonImageWithStop];
            if (!self.isFullScreen) {
                self.smallView.alpha = 1.0;
                self.smallView.hidden = NO;
            }
            break;
        case VHPlayerStateStreamStoped:
            Log(@"暂停2");
//            [HSCSHUD hideHUDTo:self.vhMoviePlayer.moviePlayerView];
            [self resetButtonImageWithStop];
            break;
        case VHPlayerStateComplete:
            Log(@"回放播放完成");
            [self finishAction];
            if ([self.delegate respondsToSelector:@selector(VHPlayerStateComplete:vId:)]) {
                [self.delegate VHPlayerStateComplete:self vId:[AppUtils nullEmpty:self.vId]];
            }
            if (self.completeBlock != nil) {
                self.completeBlock(self.isFullScreen);
            }
            break;
        default:
            break;
    }
}

- (void)moviePlayer:(VHallMoviePlayer*)player currentTime:(NSTimeInterval)currentTime
{
    [self performSelector:@selector(hideHUD) withObject:self afterDelay:1.0];
    if ((!self.smallView.hidden || !self.bigView.hidden) && self.canPerform) {
        self.canPerform = NO;
        [self performSelector:@selector(showHideView) withObject:self afterDelay:5];
    }
    [self monitorVideoPlayback];
    [self setProgressSliderMaxMinValues];
    self.coverImageView.hidden = YES;
    if ([self.delegate respondsToSelector:@selector(didWatchPlayBackView:timeInterval:)]) {
        [self.delegate didWatchPlayBackView:self timeInterval:currentTime];
    }
    if (self.currentTimeBlock != nil) {
        self.currentTimeBlock(currentTime);
    }
}

#pragma mark - notification events - 通知事件

- (void)orientationChanged:(NSNotification *)note
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
            self.isFullScreen = NO;
            [self didEndFullScreen];
            Log(@"退出全屏");
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:{
            [self.viewController setNeedsStatusBarAppearanceUpdate];
            Log(@"全屏");
            self.isFullScreen = YES;
            [self didFullScreen];
        }
            break;
        default:
            break;
    }
}

- (void)doFullScreen
{
    ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
}

#pragma mark - events respone - 点击事件

//**按钮事件**//
- (void)videoButtonAction:(UIButton *)sender{
    
    switch (sender.tag) {
        case 1000:
            //播放、暂停
            if (self.vhMoviePlayer.playerState == VHPlayerStateComplete) {
                [self restartPlay];
            }else{
                if (self.vhMoviePlayer.currentPlaybackTime == self.vhMoviePlayer.duration || self.progressSlider.value == 0) {
                    [self.vhMoviePlayer setCurrentPlaybackTime:0.0];
                    [self.vhMoviePlayer pausePlay];
                }else{
                    if (self.vhMoviePlayer.playerState == VHPlayerStatePlaying) {
                        [self.vhMoviePlayer pausePlay];
                    }else{
                        [self.vhMoviePlayer reconnectPlay];
                    }
                }
            }
            break;
        case 1001:
            //全屏切换
            if (self.isFullScreen) {
                ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
            }else{
                ScreenRotateToPortrait(UIInterfaceOrientationLandscapeRight);
            }
            break;
        case 1002:
            //静音
            [self setSilence];
            break;
        case 1003:
            //返回
            if (self.isFullScreen) {
                ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
            }else{
                ScreenRotateToPortrait(UIInterfaceOrientationLandscapeRight);
            }
            break;
        default:
            break;
    }
}

- (void)endFullScreen
{
    if (self.isFullScreen) {
        ScreenRotateToPortrait(UIInterfaceOrientationPortrait);
    }
}

//**设置静音**//
- (void) setSilence
{
//    self.mute = !self.mute;
//    UIImage *image = self.mute ? [UIImage imageNamed:@"watch_back_ silence_icon"] : [UIImage imageNamed:@"watch_back_ volume_icon"];
}

//**拖拽 进度条**//
-(void)changeAction:(UISlider *)slider{
    self.isSlider = YES;
}

-(void)speedAction:(UIButton *)sender
{
    [self showHideView];
    self.canPerform = NO;
    if (self.speedView.hidden) {
        self.speedView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.smallSpeedView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)nextVideoAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(nextVideo:vId:)]) {
        [self.delegate nextVideo:self vId:[AppUtils nullEmpty:self.vId]];
    }
    if (self.nextVideoBlock != nil) {
        self.nextVideoBlock(self.isFullScreen);
    }
}

-(void)speedTapAction{
    if (!self.speedView.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.smallSpeedView.alpha = 0;
        } completion:^(BOOL finished) {
            self.speedView.hidden = YES;
        }];
    }
}

-(void)restartPlay
{
    if ([AppUtils nullEmpty:self.vId].length) {
        self.noDataView.hidden = YES;
        [self.vhMoviePlayer pausePlay];
        [self.vhMoviePlayer setCurrentPlaybackTime:(0)];
        [self.vhMoviePlayer reconnectPlay];
//        [self startPlayerWithId:self.vId title:self.title];
    }
}

//MARK: - slider拖动结束
-(void)sliderEnd:(UISlider *)slider{
    NSTimeInterval time = 0;
    [HSCSHUD showProgressHUDAddedToVideoView:self.vhMoviePlayer.moviePlayerView];
    self.canPerform = YES;
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    if (time != 0 && slider.value>time) {
        slider.value = time;
        [self.vhMoviePlayer pausePlay];
        [self.vhMoviePlayer setCurrentPlaybackTime:(slider.value)];
    }
    else {
        [self.vhMoviePlayer pausePlay];
        [self.vhMoviePlayer setCurrentPlaybackTime:(slider.value)];
        [self.vhMoviePlayer reconnectPlay];
    }
    
//    double currentTime = floor(slider.value);
//    double totalTime = floor(self.vhMoviePlayer.duration);
//    [self setTimeLabelValues:currentTime totalTime:totalTime];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.22 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//防止每秒更新引起的跳动
        self.isSlider = NO;
    });
    
}

//**点击 显示隐藏控制面板**//
-(void)tapAction:(UITapGestureRecognizer *)ges{
    [self showHideView];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
//    [self performSelector:@selector(canHiden) withObject:self afterDelay:TimeInterval];
}

- (void) canHiden{
    if (!self.smallView.hidden || !self.bgView.hidden) {
        [self showHideView];
    }
}

//**显示隐藏控制面板**//
- (void) showHideView{
    
    self.smallHistoryTimeLabel.hidden = YES;
    self.bigHistoryTimeLabel.hidden = YES;
    
    if (self.vhMoviePlayer.playerState != VHPlayerStatePlaying) {
        if (self.isFullScreen) {
            self.bigView.hidden = NO;
        }else{
            self.smallView.hidden = NO;
        }
        return;
    }
    WS(weakSelf)
    if (self.isFullScreen) {
        if (self.bigView.hidden && self.speedView.hidden) {
            self.canPerform = YES;
            self.bigView.hidden = NO;
            self.bigView.alpha = 0.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.bigView.alpha = 1.0;
            }];
        }else{
            self.bigView.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.bigView.alpha = 0.0;
            } completion:^(BOOL finished) {
                weakSelf.bigView.hidden = YES;
            }];
        }
    }else{
        if (self.smallView.hidden && self.speedView.hidden) {
            self.canPerform = YES;
            self.smallView.hidden = NO;
            self.botProgressSlider.hidden = !weakSelf.smallView.hidden;
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
                weakSelf.botProgressSlider.hidden = !weakSelf.smallView.hidden;
            }];
        }
    }
}

- (void)finishAction
{
    if (self.isFullScreen) {
        self.bigView.alpha = 1.0;
        self.bigView.hidden = NO;
    }else{
        self.smallView.alpha = 1.0;
        self.smallView.hidden = NO;
    }
    self.canPerform = YES;
    self.coverImageView.hidden = NO;
    self.progressSlider.value = 0.0;
    self.botProgressSlider.progress = 0.f;
    self.bigProgressSlider.value = 0.0;
    [self setTimeLabelValues:0 totalTime:self.vhMoviePlayer.duration];
}

#pragma mark - fullScreen - 全屏模式
//全屏
- (void)didFullScreen{
    
    self.botProgressSlider.hidden = YES;
    self.vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFit;
    
    [self fullScreen:self.isFullScreen];
    
    [MAIN_WINDOW addSubview:self.vhMoviePlayer.moviePlayerView];
    
    CGFloat width = SCREEN_HEIGHT;
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
//    [self.viewController.navigationController setNavigationBarHidden:YES animated:NO];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(width);
    }];
    self.vhMoviePlayer.moviePlayerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.noDataView.frame = self.vhMoviePlayer.moviePlayerView.frame;
    
//    [self.speedView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(0);
//        make.height.mas_equalTo(width);
//    }];
    [self.smallSpeedView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(140);
    }];
    [self.smallSpeedView makeLayout:self.superFrame.size.width];
//    [self layoutIfNeeded];
    
    [self.bigView layoutIfNeeded];
    [self.vhMoviePlayer.moviePlayerView layoutIfNeeded];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kVideoOrientationChangeNotification object:nil];
}
//退出全屏
- (void)didEndFullScreen{

    if ([self.delegate respondsToSelector:@selector(didEndFullScreen:)]) {
        [self.delegate didEndFullScreen:self];
    }
    [self fullScreen:self.isFullScreen];
    
    [self.vhMoviePlayer.moviePlayerView removeFromSuperview];
    [self addSubview:self.vhMoviePlayer.moviePlayerView];
    
    self.vhMoviePlayer.moviePlayerView.transform = CGAffineTransformIdentity;
    self.vhMoviePlayer.moviePlayerView.transform = CGAffineTransformMakeRotation(0);
//    [self addSubview:self.vhMoviePlayer.moviePlayerView];
//    [weakSelf.selectedCell insertSubview:weakSelf.selectedCell.videoView.overView aboveSubview:[LYPlaybackInstance sharedInstance].moviePlayer.moviePlayerView];
    self.vhMoviePlayer.moviePlayerView.frame = self.superFrame;
    self.noDataView.frame = self.vhMoviePlayer.moviePlayerView.frame;
//    [self.speedView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.mas_equalTo(0);
//    }];
    [self.smallSpeedView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(HeightScale(90));
    }];
    [self.smallSpeedView makeLayout:self.noDataView.size.height];
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

#pragma mark - getters and setters

-(HSCSLiveNoDataView *)noDataView{
    if (_noDataView == nil) {
        _noDataView = [[HSCSLiveNoDataView alloc] initWithFrame:CGRectZero];
        _noDataView.backgroundColor = [UIColor blackColor];
        _noDataView.userInteractionEnabled = YES;
        _noDataView.hidden = YES;
    }
    return _noDataView;
}

-(UIButton *)restartButton
{
    if (_restartButton == nil) {
        _restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_restartButton addTarget:self action:@selector(restartPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _restartButton;
}

-(UIView *)smallView{
    if (_smallView == nil) {
        _smallView = [[UIView alloc] initWithFrame:CGRectZero];
        _smallView.backgroundColor = HEXA(@"#000000", 0.2);
//        _smallView.hidden = YES;
        _smallView.layer.masksToBounds = YES;
        _smallView.layer.cornerRadius = 5;
    }
    return _smallView;
}

-(UIImageView *)coverImageView
{
    if (_coverImageView == nil) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _coverImageView.userInteractionEnabled = YES;
//        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

-(UIView *)smallTapView{
    if (_smallTapView == nil) {
        _smallTapView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _smallTapView;
}

-(UILabel *)smallTitleLabel{
    if (_smallTitleLabel == nil) {
        _smallTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _smallTitleLabel.textColor = HEX(@"#FFFFFF");
        _smallTitleLabel.font = [UIFont PingFangSCBold:16];
    }
    return _smallTitleLabel;
}

-(UILabel *)videoTypeLabel
{
    if (_videoTypeLabel == nil) {
        _videoTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _videoTypeLabel.layer.cornerRadius = 3;
        _videoTypeLabel.layer.masksToBounds = YES;
        _videoTypeLabel.font = [UIFont PingFangSCRegular:12];
        _videoTypeLabel.textColor = [UIColor whiteColor];
        _videoTypeLabel.textAlignment = NSTextAlignmentCenter;
        _videoTypeLabel.alpha = 0.7;
        _videoTypeLabel.hidden = YES;
        _videoTypeLabel.text = @"回放";
        _videoTypeLabel.backgroundColor = HEX(@"#2178FF");
    }
    return _videoTypeLabel;
}

-(UIButton *)smallPlayButton{
    if (_smallPlayButton == nil) {
        _smallPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _smallPlayButton.tag = 1000;
        [_smallPlayButton setImage:[UIImage imageNamed:@"watch_back_play_icon"] forState:UIControlStateNormal];
        [_smallPlayButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallPlayButton;
}

-(UIView *)speedView
{
    if (_speedView == nil) {
        _speedView = [[UIView alloc] initWithFrame:CGRectZero];
        _speedView.backgroundColor = [UIColor clearColor];
        _speedView.hidden = YES;
    }
    return _speedView;
}

-(HSCSWatchBackSpeedView *)smallSpeedView
{
    if (_smallSpeedView == nil) {
        _smallSpeedView = [[HSCSWatchBackSpeedView alloc] initWithFrame:CGRectZero];
        _smallSpeedView.alpha = 0;
    }
    return _smallSpeedView;
}

-(UIButton *)smallSpeedButton
{
    if (_smallSpeedButton == nil) {
        _smallSpeedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallSpeedButton setImage:[UIImage imageNamed:@"small_speed_1"] forState:UIControlStateNormal];
        [_smallSpeedButton addTarget:self action:@selector(speedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallSpeedButton;
}

-(UIButton *)smallNextButton
{
    if (_smallNextButton == nil) {
        _smallNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallNextButton setImage:[UIImage imageNamed:@"watch_back_small_next_icon"] forState:UIControlStateNormal];
        [_smallNextButton addTarget:self action:@selector(nextVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smallNextButton;
}

-(YYLabel *)smallHistoryTimeLabel
{
    if (_smallHistoryTimeLabel == nil) {
        _smallHistoryTimeLabel = [YYLabel new];
        _smallHistoryTimeLabel.textColor = [UIColor whiteColor];
        _smallHistoryTimeLabel.backgroundColor = HEXA(@"#000000", 0.4);
        _smallHistoryTimeLabel.layer.cornerRadius = HeightScale(5);
        _smallHistoryTimeLabel.layer.masksToBounds = YES;
        _smallHistoryTimeLabel.textAlignment = NSTextAlignmentCenter;
        _smallHistoryTimeLabel.hidden = YES;
    }
    return _smallHistoryTimeLabel;
}

-(HSCSCustomSlider *)progressSlider{
    if (_progressSlider == nil) {
        _progressSlider = [[HSCSCustomSlider alloc] initWithFrame:CGRectZero];
        _progressSlider.minimumTrackTintColor = HEX(@"#D7A881");
        _progressSlider.maximumTrackTintColor = HEX(@"#FFFFFF");
        _progressSlider.continuous= YES;
        [_progressSlider setThumbImage:[UIImage imageNamed:@"watch_back_slider_icon"] forState:UIControlStateNormal];
        //添加点击事件
        [_progressSlider addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
        [_progressSlider addTarget:self action:@selector(sliderEnd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _progressSlider;
}

-(UIProgressView *)botProgressSlider
{
    if (_botProgressSlider == nil) {
        _botProgressSlider = [[UIProgressView alloc] initWithFrame:CGRectZero];
        _botProgressSlider.progressTintColor = HEX(@"#FB6700");
        _botProgressSlider.trackTintColor = HEX(@"#D8D8D8");
//        _botProgressSlider.continuous= YES;
        _botProgressSlider.progress = 0;
        _botProgressSlider.hidden = YES;
//        _botProgressSlider.thumbTintColor = [UIColor clearColor];
    }
    return _botProgressSlider;
}

-(UILabel *)timeValueLabel{
    if (_timeValueLabel == nil) {
        _timeValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeValueLabel.textColor = HEX(@"#FFFFFF");
        _timeValueLabel.font = [UIFont PingFangSCRegular:12];
        _timeValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeValueLabel;
}

- (UIButton *)screenButton{
    if (_screenButton == nil) {
        _screenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _screenButton.tag = 1001;
        [_screenButton setImage:[UIImage imageNamed:@"watch_back_fullscreem_icon"] forState:UIControlStateNormal];
        [_screenButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _screenButton;
}

-(VHallMoviePlayer *)vhMoviePlayer{
    if (_vhMoviePlayer == nil) {
        _vhMoviePlayer = [[VHallMoviePlayer alloc]initWithDelegate:self];
        _vhMoviePlayer.moviePlayerView.backgroundColor = [UIColor blackColor];
        _vhMoviePlayer.movieScalingMode = VHRTMPMovieScalingModeAspectFit;
    }
    return _vhMoviePlayer;
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
        [_bigBackButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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

-(UIButton *)bigsmallPlayButton{
    if (_bigsmallPlayButton == nil) {
        _bigsmallPlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigsmallPlayButton.tag = 1000;
        [_bigsmallPlayButton setImage:[UIImage imageNamed:@"watch_back_full_pause_icon"] forState:UIControlStateNormal];
        [_bigsmallPlayButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigsmallPlayButton;
}

-(HSCSCustomSlider *)bigProgressSlider{
    if (_bigProgressSlider == nil) {
        _bigProgressSlider = [[HSCSCustomSlider alloc] initWithFrame:CGRectZero];
        _bigProgressSlider.minimumTrackTintColor = HEX(@"#FF7700");
        _bigProgressSlider.maximumTrackTintColor = HEX(@"#E8E8E8");
        _bigProgressSlider.continuous= YES;
        [_bigProgressSlider setThumbImage:[UIImage imageNamed:@"watch_back_slider_icon"] forState:UIControlStateNormal];
        //添加点击事件
        [_bigProgressSlider addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
        [_bigProgressSlider addTarget:self action:@selector(sliderEnd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigProgressSlider;
}

-(UILabel *)bigTimeValueLabel{
    if (_bigTimeValueLabel == nil) {
        _bigTimeValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bigTimeValueLabel.textColor = HEX(@"#FFFFFF");
        _bigTimeValueLabel.font = [UIFont PingFangSCBold:12];
        _bigTimeValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _bigTimeValueLabel;
}

-(UILabel *)bigTotalTimeValueLabel{
    if (_bigTotalTimeValueLabel == nil) {
        _bigTotalTimeValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bigTotalTimeValueLabel.textColor = HEX(@"#FFFFFF");
        _bigTotalTimeValueLabel.font = [UIFont PingFangSCBold:12];
    }
    return _bigTotalTimeValueLabel;
}

- (UIButton *)bigScreenButton{
    if (_bigScreenButton == nil) {
        _bigScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bigScreenButton.tag = 1001;
        [_bigScreenButton setImage:[UIImage imageNamed:@"watch_back_smallscreem_icon"] forState:UIControlStateNormal];
        [_bigScreenButton addTarget:self action:@selector(videoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigScreenButton;
}

-(UIButton *)bigSpeedButton
{
    if (_bigSpeedButton == nil) {
        _bigSpeedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bigSpeedButton setImage:[UIImage imageNamed:@"big_speed_1"] forState:UIControlStateNormal];
        [_bigSpeedButton addTarget:self action:@selector(speedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigSpeedButton;
}

-(UIButton *)bigNextButton
{
    if (_bigNextButton == nil) {
        _bigNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bigNextButton setImage:[UIImage imageNamed:@"watch_back_full_next_icon"] forState:UIControlStateNormal];
        [_bigNextButton addTarget:self action:@selector(nextVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigNextButton;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _bgView;
}

-(YYLabel *)bigHistoryTimeLabel
{
    if (_bigHistoryTimeLabel == nil) {
        _bigHistoryTimeLabel = [YYLabel new];
        _bigHistoryTimeLabel.textColor = [UIColor whiteColor];
        _bigHistoryTimeLabel.backgroundColor = HEXA(@"#000000", 0.4);
        _bigHistoryTimeLabel.layer.cornerRadius = HeightScale(5);
        _bigHistoryTimeLabel.layer.masksToBounds = YES;
        _bigHistoryTimeLabel.hidden = YES;
    }
    return _bigHistoryTimeLabel;
}

@end
