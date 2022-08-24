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
//		File Name:		AppUtils.m
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2018/12/26 10:21 AM
//		
//		Copyright © 2018 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import "AppUtils.h"
#import <sys/utsname.h>
//#import "IQKeyboardManager.h"

@implementation AppUtils

/**
 *  将null转换为@""
 *
 *  @param text     文本
 *
 *  @return 文本
 */
+(NSString *)nullEmpty:(NSString *)text
{    
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([text isKindOfClass:[NSNull class]]|| text == nil) {
        return @"";
    }else {
        return text;
    }
}

/**
 计算缓存大小

 @param size byte
 @return return value description
 */
+ (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

/**
 *  计算文本高度
 *
 *  @param text     文本内容
 *  @param font     字体大小
 *  @param width    最大宽度
 *
 *  @return 文本大小
 */
+ (CGSize)sizeWithText:(NSString*)text font:(UIFont*)font with:(CGFloat)width{
    
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    /// 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [text boundingRectWithSize:maxSize
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    textSize = rect.size;
    
    return textSize;
}

//对网址和参数进行拼接,方便展示带有参数的网址,用于测试或者浏览器直接打开
+(NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr Parameters:(NSDictionary *)parameters
{
    if (!parameters) {
        return urlStr;
    }
    if ([[parameters allKeys] count]<1) {
        return urlStr;
    }
    
    
    NSMutableArray *parts = [NSMutableArray array];
    //遍历参数,将key和value 进行拼接
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //接收key
        if ([key isKindOfClass:[NSNumber class]]) {
            key = [NSString stringWithFormat:@"%@",key];
        }
        if ([obj isKindOfClass:[NSNumber class]]) {
            obj = [NSString stringWithFormat:@"%@",obj];
        }
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //接收值
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        
        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];
        
        [parts addObject:part];
        
    }];
    
    NSString *queryString = [parts componentsJoinedByString:@"&"];
    
    queryString = queryString ? [NSString stringWithFormat:@"?%@",queryString] : @"";
    
    NSString *pathStr = [NSString stringWithFormat:@"%@%@",urlStr,queryString];
    
    return pathStr;
    
}

+ (void)closeIQKeyboardManager:(BOOL)isClose
{
//    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
//    keyboardManager.enable = isClose; // 控制整个功能是否启用
//    keyboardManager.shouldResignOnTouchOutside = isClose;
}

@end
