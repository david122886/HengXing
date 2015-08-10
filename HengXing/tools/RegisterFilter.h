//
//  RegisterFilter.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/27.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterFilter : NSObject
+(void)verifyUserName:(NSString*)userName withFinshed:(void(^)(BOOL success,NSString *errorMsg))block;
+(void)verifyAccount:(NSString*)account withFinshed:(void(^)(BOOL success,NSString *errorMsg))block;
+(void)verifyPwd:(NSString*)pwd withFinshed:(void(^)(BOOL success,NSString *errorMsg))block;
+(void)verifyPhoneNumber:(NSString*)phoneNumber withFinshed:(void(^)(BOOL success,NSString *errorMsg))block;
@end
