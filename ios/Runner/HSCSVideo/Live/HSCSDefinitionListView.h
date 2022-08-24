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
//		File Name:		HSCSDefinitionListView.h
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2019/3/11 3:21 PM
//		
//		Copyright © 2019 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

@class HSCSDefinitionListView;
@protocol DefinitionListViewDelegate <NSObject>

@optional
- (void)didDefinitionListView:(HSCSDefinitionListView *_Nullable)definitionListView definition:(NSInteger)definition title:(NSString *)title;

@end

NS_ASSUME_NONNULL_BEGIN

@interface HSCSDefinitionListView : UIView

@property(nonatomic,assign) id<DefinitionListViewDelegate>   delegate;


/**
 选择的清晰度

 @param index 清晰度  VHMovieDefinition
 */
- (void)selectWith:(NSInteger)index;

@property(nonatomic,assign)NSInteger minDefinition;//清晰度最小值 0为原画 详情见VHMovieDefinition
@end

NS_ASSUME_NONNULL_END
