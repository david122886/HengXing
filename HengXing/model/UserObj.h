//
//  UserObj.h
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/19.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObj : NSObject
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *group;
@property (nonatomic,strong) NSString *userId;
///职务ID
@property (nonatomic,strong) NSString *popedom_Id;
@property (nonatomic,strong) NSString *popedom;
@property (nonatomic,strong) NSString *pwd;
@end
