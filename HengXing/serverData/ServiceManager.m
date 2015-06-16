//
//  ServiceManager.m
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/25.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import "ServiceManager.h"
#import "AFNetworking.h"
#import "NSURLRequest+Error.h"
@implementation ServiceManager

+(AFHTTPRequestOperationManager*)shareRequestManager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return manager;
}

///登录
+(void)loginInWithUserName:(NSString*)userName andPwd:(NSString*)pwd withFinishedBlock:(void(^)(BOOL success,UserObj *user,NSString *errorMsg))block{
    [[self shareRequestManager] POST:@"http://qsh.7x24sos.com/api/init.aspx" parameters:@{@"user":userName,@"pwd":pwd,@"op":@"login"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        if (data && data.count > 0 && [(NSNumber*)data[@"s"] intValue] == 1) {
            if(block)block(YES,[UserObj userObjWithDictory:data[@"user"]],nil);
        }else{
            if(block)block(NO,nil,data[@"msg"]?:@"获取数据失败...");
        }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if(block)block(NO,nil,[NSURLRequest errorDescriptionWithError:error]);
     }];
}

@end
