//
//  LoginFilter.h
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/25.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginFilter : NSObject
+(void)verifyUserName:(NSString*)userName withFinshed:(void(^)(BOOL success,NSString *errorMsg))block;

+(void)verifyPwd:(NSString*)pwd withFinshed:(void(^)(BOOL success,NSString *errorMsg))block;
@end
