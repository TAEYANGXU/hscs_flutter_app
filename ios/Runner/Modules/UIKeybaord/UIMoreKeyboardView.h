//
//  UIMoreKeyboardView.h
//  Baseframework
//
//  Created by Zanilia on 16/8/15.
//

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

@protocol UIMoreKeyboardViewDelegate;       //The callback operation
@protocol UIMoreKeyboardViewDataSource;     //The callback data set

@interface UIMoreKeyboardView : UIView

@property (nonatomic, weak) id<UIMoreKeyboardViewDelegate> delegate; // default nil

//UIKeyboardBar KeyboardMoreImages, and title KeyboardMoreTitles, Can't be nil
@property (nonatomic, weak) id<UIMoreKeyboardViewDataSource> dataSource;

//According to the need to refresh data and page
- (void)reloadData;
@end


@protocol UIMoreKeyboardViewDelegate <NSObject>

@optional

//Methods the callback, more operating keyboard click event, according to the index to distinguish
- (void)keyboard:(UIMoreKeyboardView *)keyboard selectIndex:(NSInteger)itemIndex title:(NSString *)title;
@end

@protocol UIMoreKeyboardViewDataSource <NSObject>

@optional

//Set the display the title of the UIMoreButtonItem is title
- (NSArray *)keyboardMoreViewTitlesOfMoreView:(UIMoreKeyboardView *)keyboard;

//Set the display the image of the UIMoreButtonItem is button backgroundImage
- (NSArray *)keyboardMoreViewImageNamesOfMoreView:(UIMoreKeyboardView *)keyboard;
@end
