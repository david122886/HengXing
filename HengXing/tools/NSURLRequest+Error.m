//
//  NSURLRequest+Error.m
//  DRCahceWebView
//
//  Created by xxsy-ima001 on 15/5/20.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "NSURLRequest+Error.h"

@implementation NSURLRequest (Error)
///根据错误代码翻译成提示信息
+(NSString*)errorDescriptionWithErrorCode:(NSInteger)errorCode{
    NSString *description = @"请求失败.";
    if(errorCode == NSURLErrorNotConnectedToInternet)description = @"无法连接网络,请稍后再试.";else
    if(errorCode == NSURLErrorCancelled)description = nil;else
    if(errorCode == NSURLErrorBadURL)description = @"请求地址错误.";else
    if(errorCode == NSURLErrorUnsupportedURL)description = @"请求地址错误.";else
    if(errorCode == NSURLErrorTimedOut)description = @"无法连接到服务器,请稍后重试.";else
    if(errorCode == kCFURLErrorDNSLookupFailed)description = @"无法连接到服务器,请稍后重试.";else
    if(errorCode == NSURLErrorCannotFindHost)description = @"无法连接到服务器,请稍后重试.";else
    if(errorCode == NSURLErrorCannotConnectToHost)description = @"无法连接到服务器,请稍后重试.";
    return description;
}
+(NSString*)errorDescriptionWithError:(NSError*)error{
    return [self errorDescriptionWithErrorCode:error.code];
}
@end
