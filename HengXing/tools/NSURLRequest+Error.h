//
//  NSURLRequest+Error.h
//  DRCahceWebView
//
//  Created by xxsy-ima001 on 15/5/20.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * 错误过滤
 *https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Miscellaneous/Foundation_Constants/index.html#//apple_ref/doc/constant_group/URL_Loading_System_Error_Codes
 *
 */
@interface NSURLRequest (Error)
///根据错误代码翻译成提示信息
+(NSString*)errorDescriptionWithErrorCode:(NSInteger)errorCode;
+(NSString*)errorDescriptionWithError:(NSError*)error;
@end
