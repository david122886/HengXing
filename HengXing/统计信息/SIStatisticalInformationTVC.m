//
//  SIStatisticalInformationTVC.m
//  HengXing
//
//  Created by lihongliang on 15/7/12.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "SIStatisticalInformationTVC.h"
#import "LogisticsTableViewCell.h"
@interface SIStatisticalInformationTVC ()

@property (weak, nonatomic) IBOutlet UILabel *label1; //授权更换的故障电池数
@property (weak, nonatomic) IBOutlet UILabel *label2; //已收到的故障电池数
@property (weak, nonatomic) IBOutlet UILabel *label3; //已补偿的电池数
@property (weak, nonatomic) IBOutlet UILabel *label4; //待补贴的邮费

@property (weak, nonatomic) IBOutlet LogisticsTableViewCell *logisticsTableCell;

@end

@implementation SIStatisticalInformationTVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    SIStatisticalInformationTVC *tvc = [story instantiateViewControllerWithIdentifier:@"SIStatisticalInformationTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"统计信息";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
