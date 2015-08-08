//
//  LMSendBySalesmanHistoryTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
#import "UICommon.h"
#import "LMSendBySalesmanHistoryTVC.h"

@interface LMSendBySalesmanHistoryTVC ()

@end

@implementation LMSendBySalesmanHistoryTVC

+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    LMSendBySalesmanHistoryTVC *tvc = [story instantiateViewControllerWithIdentifier:@"LMSendBySalesmanHistoryTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史发货记录";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellData"];
    UIView *contentView = cell.contentView;
    UILabel *signedQuantityLabel = (UILabel *)[contentView viewWithTag:1];  //签收数量
    UILabel *sendedQuantityLabel = (UILabel *)[contentView viewWithTag:2];  //发货电池数量
    UILabel *signedTimeLabel = (UILabel *)[contentView viewWithTag:3];   //签收时间
    UILabel *sendedTimeLabel = (UILabel *)[contentView viewWithTag:4];    //发货时间
    UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:5];  //物流公司
    UILabel *trackNOLabel = (UILabel *)[contentView viewWithTag:6];        //运单号码
    UILabel *officLabel = (UILabel *)[contentView viewWithTag:7];      //办事处
    
    [UICommon handleLabel:officLabel withVC:self withString:@"高新区金沙路181号" withTelephoneNO:@"18662212273" withSelector:@selector(tapAtTelephone:)];
    return cell;
}

#pragma mark user interaction
- (void)tapAtTelephone:(UIGestureRecognizer *)gesture {
    UILabel *label = (UILabel *)gesture.view;
    UITableViewCell *cell = (UITableViewCell *)label.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    //根据indexPath找到电话号码
    NSString *phoneNO = @"0752-88984521";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNO]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法拨号" message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}
@end
