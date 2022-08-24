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
//        File Name:       UIColor+Theme.m
//        Product Name:    HSCSApp
//        Author:          xuyanzhang@利事果
//        Swift Version:   5.0
//        Created Date:    2020/12/3 2:45 PM
//
//        Copyright © 2020 利事果.
//        All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
        

#import "UIColor+Theme.h"
#import <XyWidget/ConstHeader.h>

@implementation UIColor (Theme)

+(UIColor *)themeColor
{
    return HEX(@"#FB6700");
}

+ (UIColor *)textColor
{
    return HEX(@"#2C2E3A");
}

+(UIColor *)lineColor
{
    return HEX(@"#EDEDEE");
}

+(UIColor *)lineBGColor
{
    return HEX(@"#F0F0F0");
}

+(UIColor *)darkGrayColor
{
    return HEX(@"#9194A4");
}

+(UIColor *)VCBGColor
{
    return HEX(@"#F7F7F7");
}

+(UIColor *)orangeTextColor
{
    return HEX(@"#F39D30");
}
@end
