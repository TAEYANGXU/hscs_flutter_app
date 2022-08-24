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
//        File Name:       UILabel+NumberOfLines.h
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/2/14 3:34 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (NumberOfLines)

//获取文本行数
- (int)getNumberOfLinesWithText:(NSAttributedString *)text andLabelWidth:(CGFloat)width;

+ (CGFloat)labelHeight:(NSString*)content font:(UIFont*)font width:(CGFloat)width lineNum:(NSInteger)lineNum lineSpacing:(NSInteger)lineSpacing;

+ (CGSize)labelSize:(NSString*)content font:(UIFont*)font width:(CGFloat)width lineNum:(NSInteger)lineNum lineSpacing:(NSInteger)lineSpacing;

@end

NS_ASSUME_NONNULL_END
