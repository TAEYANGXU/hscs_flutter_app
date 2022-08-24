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
//		File Name:		AppUtils.h
//		Product Name:    HSCSApp
//		Author:			xuyanzhang@利事果
//		Swift Version:	4.0
//		Created Date:	2018/12/26 10:21 AM
//		
//		Copyright © 2018 利事果.
//		All rights reserved.
// )                                                                  (
//'--------------------------------------------------------------------'
	

#import <Foundation/Foundation.h>
//#import <XyWidget/ConstHeader.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppUtils : NSObject

/**
 *  将null转换为@""
 *
 *  @param text     文本
 *
 *  @return 文本
 */
+(NSString *)nullEmpty:(NSString *)text;

/**
 计算缓存大小

 @param size byte
 @return return value description
 */
+ (NSString *)fileSizeWithInterge:(NSInteger)size;

/**
 *  计算文本高度/宽度
 *
 *  @param text     文本内容
 *  @param font     字体大小
 *  @param width 最大宽度
 *
 *  @return 文本大小
 */
+ (CGSize)sizeWithText:(NSString*)text font:(UIFont*)font with:(CGFloat)width;

//对网址和参数进行拼接,方便展示带有参数的网址,用于测试或者浏览器直接打开
+ (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr Parameters:(NSDictionary *)parameters;

+ (void)closeIQKeyboardManager:(BOOL)isClose;

@end

NS_ASSUME_NONNULL_END
