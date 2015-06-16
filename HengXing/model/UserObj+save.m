//
//  UserObj+save.m
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/25.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import "UserObj+save.h"
#define kUserName @"kUserName"
#define kPwd @"kPwd"

@implementation UserObj (save)
+(UserObj*)unarchive{
    return [self userObjWithUserName:[[NSUserDefaults standardUserDefaults] objectForKey:kUserName] withPwd:[[NSUserDefaults standardUserDefaults] objectForKey:kPwd]];
}

-(void)archive{
    [UserObj archiveWithUserName:self.userName withPwd:self.pwd];
}

+(UserObj*)userObjWithUserName:(NSString*)userName withPwd:(NSString*)pwd{
    UserObj *obj = [UserObj new];
    obj.userName = userName;
    obj.pwd = pwd;
    return obj;
}

+(void)archiveWithUserName:(NSString*)userName withPwd:(NSString*)pwd{
    if (userName) {
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:kUserName];
    }
    if (pwd) {
        [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:kPwd];
    }
}

+(UserObj*)userObjWithDictory:(NSDictionary*)dic{
    if (!dic) {
        return nil;
    }
    
    UserObj *user = [UserObj new];
    user.userId = dic[@"id"];
    user.userName = dic[@"name"];
    user.group = [dic[@"group"] stringValue];
    user.popedom = dic[@"popedom"];
    user.popedom_Id = dic[@"popedom_id"];
    return user;
}
@end
