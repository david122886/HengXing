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

+(void)verifyAccount:(NSString*)account withFinshed:(void(^)(BOOL success,NSString *errorMsg))block{
    if (!account || [account isEqualToString:@""]) {
        if(block)block(NO,@"账号不能为空");
        return;
    }
    if ([[account stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        if(block)block(NO,@"账号不能为空");
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

+(void)verifyPhoneNumber:(NSString*)phoneNumber withFinshed:(void(^)(BOOL success,NSString *errorMsg))block{
    if (!phoneNumber || [phoneNumber isEqualToString:@""]) {
        if(block)block(NO,@"手机号码不能为空");
        return;
    }
    if ([[phoneNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        if(block)block(NO,@"手机号码不能为空");
        return;
    }
    NSRange range = [phoneNumber rangeOfString:@"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$" options:NSRegularExpressionSearch];
    if (range.location == NSNotFound || range.length != phoneNumber.length) {
        if(block)block(NO,@"手机号码格式不正确");
        return;
    }
    if(block)block(YES,nil);
}
@end
