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
//		File Name:		HSCSLiveNoDataView.m
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/12 10:50 AM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'

#import "HSCSLiveNoDataView.h"
#import "Masonry.h"
#import <XyWidget/UIFont+PingFangSC.h>

@interface HSCSLiveNoDataView()

@property(nonatomic,copy) UIView *contentView;
@property(nonatomic,copy) UIImageView *noDataImageView;
@property(nonatomic,copy) UILabel *messageLabel;
@property(nonatomic,copy) UIButton *refreButton;

@end

@implementation HSCSLiveNoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUpUI];
        [self makeLayout];
        self.backgroundColor = HEXA(@"#000000", 0.7);
    }
    return self;
}

- (void)makeUpUI{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.noDataImageView];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.refreButton];
}

- (void)makeLayout{
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(270, 152));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [self.noDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-25);
//        make.top.mas_equalTo(55);
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.noDataImageView.mas_bottom).offset(14);
    }];
    [self.refreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
//        make.top.equalTo(self.messageLabel.mas_bottom).offset(10);
    }];
}

- (void)setStatus:(NSInteger)status
{
    _status = status;
    
    if (status == 1) {
        self.noDataImageView.image = [UIImage imageNamed:@"watch_live_video_fail_icon"];
        self.messageLabel.text = @"视频加载失败  点击刷新";
    }
    else if (status == 2) {
        self.noDataImageView.image = [UIImage imageNamed:@"watch_live_video_close_icon"];
        self.messageLabel.text = @"直播结束啦 回放生成中 请稍候";
    }else if (status == 3){
        self.noDataImageView.image = [UIImage imageNamed:@"watch_live_video_close_icon"];
        self.messageLabel.text = @"视频结束啦";
    }
}

#pragma mark - events respone

- (void)refreshAction:(UIButton *)sender{
    
    
}

#pragma mark - getters and setters

-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

-(UIImageView *)noDataImageView{
    if (_noDataImageView == nil) {
        _noDataImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _noDataImageView.image = [UIImage imageNamed:@"watch_live_video_fail_icon"];
    }
    return _noDataImageView;
}

-(UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.font = [UIFont PingFangSCRegular:12];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

-(UIButton *)refreButton{
    if (_refreButton == nil) {
        _refreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _refreButton.backgroundColor = [UIColor clearColor];
        [_refreButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreButton;
}

@end
