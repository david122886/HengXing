//
//  BatteryCheckVCManager.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/7/9.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "BatteryCheckVCManager.h"
@interface BatteryCheckVCManager()
#pragma mark -
#pragma mark -- topView
@property (weak, nonatomic) IBOutlet UIImageView *leftFlagImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightFlagImageView;
@property (weak, nonatomic) IBOutlet UILabel *connectStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *batteryCheckBt;
- (IBAction)batteryCheckBtClicked:(UIButton *)sender;

#pragma mark -

#pragma mark -
#pragma mark -- bottomView
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *checkReslutLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkResultDetailLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextStepBt;
- (IBAction)nextStepBtClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *errorDetailTextView;
#pragma mark -


@end

@implementation BatteryCheckVCManager
- (IBAction)batteryCheckBtClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(startCheckBattery)]) {
        [self.delegate startCheckBattery];
    }
}
- (IBAction)nextStepBtClicked:(UIButton *)sender {
    
}

-(void)connectBlueTooth:(BOOL)success{
    [self.bottomView setHidden:YES];
    if (success) {
        [self.batteryCheckBt setBackgroundColor:[UIColor blueColor]];
        self.connectStatusLabel.text = @"手机与锂电检测仪之间正确连接";
        [self.connectStatusLabel setTextColor:[UIColor colorWithRed:100/255.0 green:200/255.0 blue:100/255.0 alpha:1]];
        [self.rightFlagImageView setHidden:YES];
        self.rightFlagImageView.image = [UIImage imageNamed:@""];
        [self.leftFlagImageView setHidden:NO];
        self.leftFlagImageView.image = [UIImage imageNamed:@""];
    }else{
        [self.batteryCheckBt setBackgroundColor:[UIColor darkGrayColor]];
        self.connectStatusLabel.text = @"手机与锂电检测仪之间连接断开";
        [self.connectStatusLabel setTextColor:[UIColor redColor]];
        [self.rightFlagImageView setHidden:NO];
        self.rightFlagImageView.image = [UIImage imageNamed:@""];
        [self.leftFlagImageView setHidden:NO];
        self.leftFlagImageView.image = [UIImage imageNamed:@""];
    }
}

-(void)checkSuccess:(BOOL)success
         withResult:(NSString*)reslut
    withReslutDetal:(NSString*)detailResult
   withStatusDetail:(NSString*)stautsDetail{
    [self.bottomView setHidden:NO];
    self.checkReslutLabel.text = reslut;
    self.checkResultDetailLabel.text = detailResult;
    self.errorDetailTextView.text = stautsDetail;
    if (success) {
        [self.checkReslutLabel setTextColor:[UIColor greenColor]];
        [self.nextStepBt setHidden:YES];
        
    }else{
        [self.checkReslutLabel setTextColor:[UIColor redColor]];
        [self.nextStepBt setHidden:NO];
    }
}

@end
