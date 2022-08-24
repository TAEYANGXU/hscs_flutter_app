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
//        File Name:       HSCSWatchBackVideoView.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/5/25 3:22 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

typedef NS_ENUM(NSInteger, HSCSWatchBackVideoViewPositionType) {
    //顶部
    HSCSWatchBackVideoViewPositionTop = 0,
    //居中
    HSCSWatchBackVideoViewPositionCenter
};

typedef void(^CurrentTimeBlock)(NSTimeInterval timeInterval);
typedef void(^PlayCompleteBlock)(BOOL isFullScreen);
typedef void(^NextVideoBlock)(BOOL isFullScreen);

@class HSCSWatchBackVideoView;
@protocol HSCSWatchBackVideoViewDelegate <NSObject>

@optional
- (void)didWatchPlayBackView:(HSCSWatchBackVideoView *_Nullable)watchPlayBackView index:(NSInteger)index;

@optional   ///试看逻辑
- (void)didWatchPlayBackView:(HSCSWatchBackVideoView *_Nullable)watchPlayBackView timeInterval:(NSTimeInterval)timeInterval;

@optional  ///播放结束
- (void)VHPlayerStateComplete:(HSCSWatchBackVideoView *_Nullable)watchPlayBackView vId:(NSString *_Nullable)vId;

@optional  ///下一个
- (void)nextVideo:(HSCSWatchBackVideoView *_Nullable)watchPlayBackView vId:(NSString *_Nullable)vId;


@optional
- (void)didEndFullScreen:(HSCSWatchBackVideoView *_Nullable)watchPlayBackView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HSCSWatchBackVideoView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame position:(HSCSWatchBackVideoViewPositionType)position;

@property(nonatomic,weak) id<HSCSWatchBackVideoViewDelegate>   delegate;

//**播放视频**//
- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title;

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg;

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg showNext:(BOOL)show;

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg isBack:(BOOL)isBack completeBlock: (PlayCompleteBlock)completeBlock nextVideoBlock:(NextVideoBlock)nextVideoBlock;

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg currentTimeBlock:(CurrentTimeBlock)currentTimeBlock;

- (void)startPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg
            completeBlock: (PlayCompleteBlock)completeBlock nextVideoBlock:(NextVideoBlock)nextVideoBlock;

- (void)nextPlayerWithId:(NSString *)vId title:(NSString *)title surfaceImg:(NSString *)surfaceImg
           completeBlock: (PlayCompleteBlock)completeBlock nextVideoBlock:(NextVideoBlock)nextVideoBlock;

//** 暂停播放 **//
- (void)pausePlay;

//** 继续播放 **//
- (void)reconnectPlay;

//** 停止播放 **//
- (void)stopPlay;

//销毁
- (void)close;

//播放中
- (BOOL)isPlaying;

//全屏
- (void)didFullScreen;
//结束全屏
- (void)endFullScreen;

@property(nonatomic,strong) NSString   *surfaceImg;

@property(nonatomic,copy) CurrentTimeBlock   currentTimeBlock;

@property(nonatomic,copy) PlayCompleteBlock   completeBlock;

@property(nonatomic,copy) NextVideoBlock   nextVideoBlock;
                                                                                                                   
@end

NS_ASSUME_NONNULL_END
