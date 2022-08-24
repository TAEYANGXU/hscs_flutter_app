//
//  HSCSCacheHandle.m
//  LYLiveApp
//
//  Created by QD on 2017/9/16.
//  Copyright © 2017年 览益信息科技. All rights reserved.
//

#import "HSCSCacheHandle.h"
#import <YYCache/YYCache.h>

@implementation HSCSCacheHandle
static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;

+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];    
}

+ (void)saveResponseCache:(id)responseCache forKey:(NSString *)key
{
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:responseCache forKey:key withBlock:nil];
}

+ (id)getResponseCacheForKey:(NSString *)key
{
    return [_dataCache objectForKey:key];
}

+(void)removeCacheForKey:(NSString *)key
{
    [_dataCache removeObjectForKey:key];
}
+(void)removAllCache
{
    [_dataCache removeAllObjects];
}


@end
