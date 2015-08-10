//
//  BatteryCheckVCManager.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/7/9.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class BatteryCheckVCManager;
@protocol BatteryCheckVCManagerDelegate <NSObject>
-(void)startCheckBattery;
@end
@interface BatteryCheckVCManager : NSObject
@property (nonatomic,weak) id<BatteryCheckVCManagerDelegate> delegate;
-(void)connectBlueTooth:(BOOL)success;
-(void)checkSuccess:(BOOL)success withResult:(NSString*)reslut withReslutDetal:(NSString*)detailResult withStatusDetail:(NSString*)stautsDetail;
@end
