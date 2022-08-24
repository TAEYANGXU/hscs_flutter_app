//
//  UIMoreItem.h
//  Baseframework
//
//  Created by Zanilia on 16/8/16.
//

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

@interface UIMoreButtonItem : UIControl

//The default background image is nil
@property (nonatomic, strong) UIButton *button;

//The title of item
@property (nonatomic, strong) UILabel *titleLabel;

//Initialize the set the title and pictures
- (void)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
