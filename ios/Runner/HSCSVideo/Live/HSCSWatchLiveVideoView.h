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
//        File Name:       HSCSWatchLiveVideoView.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/7/31 10:54 AM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

NS_ASSUME_NONNULL_BEGIN

@class HSCSWatchLiveVideoView;
@protocol HSCSWatchLiveVideoViewDelegate <NSObject>

@optional
- (void)didWatchLiveVideoView:(HSCSWatchLiveVideoView *)watchLiveVideoView index:(NSInteger)selectType;

@optional
- (void)liveVideoFinish:(HSCSWatchLiveVideoView *)watchLiveVideoView;

@end

@interface HSCSWatchLiveVideoView : UIView

@property(nonatomic,weak) id<HSCSWatchLiveVideoViewDelegate>   delegate;

@property(nonatomic,assign) NSInteger playerState;  //播放器状态

- (instancetype)initWithFrame:(CGRect)frame;

//**播放视频**//
- (void)startPlayerWithId:(NSNumber *)vId title:(NSString *)title;

//** 停止播放 **//
- (void)pausePlay;

//** 开始播放 **//
- (void)reconnectPlay;

//** 销毁 **//
- (void)close;

@end
NS_ASSUME_NONNULL_END
