//
//  UIMoreItem.m
//  iFans
//
//  Created by Zanilia on 16/8/16.
//  Copyright © 2016年 王宾. All rights reserved.
//

#import "UIMoreButtonItem.h"
#import "UIView+Methods.h"
#import <XyWidget/UIFont+PingFangSC.h>
@implementation UIMoreButtonItem

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.layer.cornerRadius = 12;
        _button.contentMode = UIViewContentModeScaleAspectFill;
        _button.layer.masksToBounds = YES;
        [_button addTarget:self action:@selector(buttonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont PingFangSCRegular:12.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = HEX(@"#999999");
    }
    return _titleLabel;
}

- (void)initWithTitle:(NSString *)title imageName:(NSString *)imageName{
    self.titleLabel.text = title;
    [self.button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)buttonEvent{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.button setHighlighted:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.button setHighlighted:NO];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _button.frame = CGRectMake(0, 0, self.width, self.width);
    _titleLabel.frame = CGRectMake(0,self.width, self.width, self.height -self.width + 10);
}

@end
