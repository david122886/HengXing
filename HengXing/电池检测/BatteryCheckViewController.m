//
//  BatteryCheckViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/7/2.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "BatteryCheckViewController.h"
#import "BatteryCheckVCManager.h"
@interface BatteryCheckViewController ()
@property (strong, nonatomic) IBOutlet BatteryCheckVCManager *batteryCheckVCManager;

@end

@implementation BatteryCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.batteryCheckVCManager connectBlueTooth:YES];
    NSArray *data = @[@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",@".电芯1电压:3.69V",];
    
//    [self.batteryCheckVCManager checkSuccess:NO withResult:@"存在故障" withReslutDetal:@"经检测电池存在故障,需要进行更换处理" withStatusDetail:@".电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n.电芯1电压:3.69V\n"];
    
    [self.batteryCheckVCManager checkSuccess:NO withResult:@"存在故障" withReslutDetal:@"经检测电池存在故障,需要进行更换处理" withStatusDetail:[self getDetailStringWithDatas:data]];
    // Do any additional setup after loading the view.
}

-(NSString*)getDetailStringWithDatas:(NSArray*)datas{
    NSMutableString *string = [NSMutableString new];
    [datas enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL *stop) {
        [string appendString:str];
        [string appendString:@"\n"];
    }];
    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
