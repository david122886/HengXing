//
//  SIStatisticalInformationTVC.m
//  HengXing
//
//  Created by lihongliang on 15/7/12.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "SIStatisticalInformationTVC.h"

@interface SIStatisticalInformationTVC ()
@property (weak, nonatomic) IBOutlet UIView *leftCircleView;
@property (weak, nonatomic) IBOutlet UIView *rightCircleView;
@property (weak, nonatomic) IBOutlet UIView *haloView;
@property (weak, nonatomic) IBOutlet UILabel *label1; //授权更换的故障电池数
@property (weak, nonatomic) IBOutlet UILabel *label2; //已收到的故障电池数
@property (weak, nonatomic) IBOutlet UILabel *label3; //已补偿的电池数
@property (weak, nonatomic) IBOutlet UILabel *label4; //待补贴的邮费
@property (weak, nonatomic) IBOutlet UILabel *labelNumberThisMonth; //本月更换故障电池数
@property (weak, nonatomic) IBOutlet UILabel *labelNumberThreeMonth; //近三个月更换的故障电池数

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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _initView];
}

- (void)_initView {
    [self _makeViewRound:_leftCircleView];
    [self _makeViewRound:_rightCircleView];
    [self _makeViewRound:_haloView];
}

- (void)_makeViewRound:(UIView *)view {
    if ([view isKindOfClass:[UIView class]]) {
        view.layer.cornerRadius = view.frame.size.width / 2;
//        view.layer.shouldRasterize = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
