//
//  LoginFilter.m
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/25.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import "LoginFilter.h"

@implementation LoginFilter
+(void)verifyUserName:(NSString*)userName withFinshed:(void(^)(BOOL success,NSString *errorMsg))block{
    if (!userName || [userName isEqualToString:@""]) {
        if(block)block(NO,@"用户名不能为空");
        return;
    }
    if ([[userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        if(block)block(NO,@"用户名不能为空");
        return;
    }
     if(block)block(YES,nil);
}

+(void)verifyPwd:(NSString*)pwd withFinshed:(void(^)(BOOL success,NSString *errorMsg))block{
    if (!pwd || [pwd isEqualToString:@""]) {
        if(block)block(NO,@"密码不能为空");
        return;
    }
    if ([[pwd stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        if(block)block(NO,@"密码不能为空");
        return;
    }
    if(block)block(YES,nil);
}
@end
