//
//  HSCSCacheHandle.h
//  LYLiveApp
//
//  Created by QD on 2017/9/16.
//  Copyright © 2017年 览益信息科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSCSCacheHandle : NSObject
/**
 *  缓存网络数据
 *
 *  @param responseCache 服务器返回的数据
 *  @param key           缓存数据对应的key值,推荐填入请求的URL
 */
+(void)saveResponseCache:(id)responseCache forKey:(NSString *)key;

/**
 *  取出缓存的数据
 *
 *  @param key 根据存入时候填入的key值来取出对应的数据
 *
 *  @return 缓存的数据
 */
+(id)getResponseCacheForKey:(NSString *)key;
/**
 *   根据某个值删除缓存
 *
 *  @param key key
 */
+(void)removeCacheForKey:(NSString *)key;
/**
 *  清除所有数据
 */
+(void)removAllCache;
@end
