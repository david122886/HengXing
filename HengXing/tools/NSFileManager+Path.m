//
//  NSFileManager+Path.m
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/29.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import "NSFileManager+Path.h"

@implementation NSFileManager (Path)
+(NSString*)cacheFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths firstObject];
}
@end
