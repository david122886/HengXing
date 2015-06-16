//
//  ServiceManager.h
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/25.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserObj+save.h"
@interface ServiceManager : NSObject
/**
 * @brief 登录
 *
 * @param  userName 用户名
 *
 * @return pwd 密码
 */

+(void)loginInWithUserName:(NSString*)userName andPwd:(NSString*)pwd withFinishedBlock:(void(^)(BOOL success,UserObj *user,NSString *errorMsg))block;
@end
