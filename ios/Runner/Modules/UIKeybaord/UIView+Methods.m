//
//  UIView+Methods.m
//  ChatKeyboard
//
//  Created by Zanilia on 2017/6/13.
//  Copyright © 2017年 王宾. All rights reserved.
//

#import "UIView+Methods.h"

@implementation UIView (Methods)

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)width{
    
    return self.frame.size.width;
}

- (CGFloat)height{
    
    return self.frame.size.height;
}

-  (CGFloat)maxX{
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)minX{
    
    return CGRectGetMinX(self.frame);
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)centerX{
    return self.center.x;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (CGFloat)top{
    return [self minY];
}

- (CGFloat)bottom
{
    return [self maxY];
}

- (CGFloat)left{
    return [self minX];
}

- (CGFloat)right{
    return [self maxX];
}

@end
