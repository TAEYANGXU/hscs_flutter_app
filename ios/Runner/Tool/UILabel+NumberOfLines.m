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
//        File Name:       UILabel+NumberOfLines.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/2/14 3:34 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "UILabel+NumberOfLines.h"
#import <CoreText/CoreText.h>
#import <XyWidget/UILabel+ChangeLineSpace.h>

@implementation UILabel (NumberOfLines)

//获取文本行数
- (int)getNumberOfLinesWithText:(NSAttributedString *)text andLabelWidth:(CGFloat)width
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 , width, INT_MAX));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    // 得到字串在frame中被自动分成了多少个行。
    CFArrayRef rows = CTFrameGetLines(frame);
    // 实际行数
    int numberOfLines = CFArrayGetCount(rows);
    CFRelease(frame);
    CGPathRelease(Path);
    CFRelease(framesetter);
    return numberOfLines;
}

+ (CGFloat)labelHeight:(NSString*)content font:(UIFont*)font width:(CGFloat)width lineNum:(NSInteger)lineNum lineSpacing:(NSInteger)lineSpacing
{
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 10)];
    lb.numberOfLines = lineNum;
    lb.font = font;
    lb.text = content;
    [UILabel changeLineSpaceForLabel:lb WithSpace:lineSpacing];
    
    return [lb sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)].height;
}

+ (CGSize)labelSize:(NSString*)content font:(UIFont*)font width:(CGFloat)width lineNum:(NSInteger)lineNum lineSpacing:(NSInteger)lineSpacing
{
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 10)];
    lb.numberOfLines = lineNum;
    lb.font = font;
    lb.text = content;
    [UILabel changeLineSpaceForLabel:lb WithSpace:lineSpacing];
    
    return [lb sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
}

@end
