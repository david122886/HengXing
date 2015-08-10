//
//  UICommon.h
//  HengXing
//
//  Created by lihongliang on 15/8/4.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UICommon : NSObject
+ (void)numberNarrowFontForLabel:(UILabel *)label;

///处理一个label的string, 如有电话号码, 将号码变色, 并支持点击方法
+ (void)handleLabel:(UILabel *)officeLabel withVC:(UIViewController *)vc withString:(NSString *)officeString withTelephoneNO:(NSString *)officeTelephone withSelector:(SEL)selector;
@end
