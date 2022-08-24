//
//  UIView+Methods.h
//  ChatKeyboard
//
//  Created by Zanilia on 2017/6/13.
//  Copyright © 2017年 王宾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XyWidget/ConstHeader.h>

#define MainScreenSizeWidth         [UIScreen mainScreen].bounds.size.width
#define MainScreenSizeHeight        [UIScreen mainScreen].bounds.size.height

@interface UIView (Methods)

@property (nonatomic, readonly)CGFloat x;
@property (nonatomic, readonly)CGFloat y;
@property (nonatomic, readonly)CGFloat width;
@property (nonatomic, readonly)CGFloat height;
@property (nonatomic, readonly)CGFloat maxX;
@property (nonatomic, readonly)CGFloat minX;
@property (nonatomic, readonly)CGFloat maxY;
@property (nonatomic, readonly)CGFloat minY;
@property (nonatomic, readonly)CGFloat centerX;
@property (nonatomic, readonly)CGFloat centerY;
@property (nonatomic, readonly)CGFloat left;
@property (nonatomic, readonly)CGFloat right;
@property (nonatomic, readonly)CGFloat top;
@property (nonatomic, readonly)CGFloat bottom;

@end
