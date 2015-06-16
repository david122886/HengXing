//
//  UserObj+save.h
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/25.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import "UserObj.h"

@interface UserObj (save)
+(UserObj*)unarchive;
-(void)archive;
+(UserObj*)userObjWithUserName:(NSString*)userName withPwd:(NSString*)pwd;
+(void)archiveWithUserName:(NSString*)userName withPwd:(NSString*)pwd;
+(UserObj*)userObjWithDictory:(NSDictionary*)dic;
@end
