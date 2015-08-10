//
//  WPWarrantyPeriodQueryVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "WPWarrantyPeriodQueryVC.h"

@interface WPWarrantyPeriodQueryVC ()
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;
@property (weak, nonatomic) IBOutlet UILabel *productDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *repairDataLabel;
@property (weak, nonatomic) IBOutlet UILabel *useTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *repairStatusLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation WPWarrantyPeriodQueryVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    WPWarrantyPeriodQueryVC *tvc = [story instantiateViewControllerWithIdentifier:@"WPWarrantyPeriodQueryVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保修期查询";
    _scanButton.layer.cornerRadius = 6.;
    _queryButton.layer.cornerRadius = 6.;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
