//
//  LMSignedByManagerHistoryTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
#import "UICommon.h"
#import "LMSignedByManagerHistoryTVC.h"

@interface LMSignedByManagerHistoryTVC ()

@end

@implementation LMSignedByManagerHistoryTVC

+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    LMSignedByManagerHistoryTVC *tvc = [story instantiateViewControllerWithIdentifier:@"LMSignedByManagerHistoryTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史签收记录";
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
    UILabel *receiverLabel = (UILabel *)[contentView viewWithTag:1];  //收货人
    UILabel *receiveCityLabel = (UILabel *)[contentView viewWithTag:2];  //收货城市
    UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:3];   //物流公司
    UILabel *trackNOLabel = (UILabel *)[contentView viewWithTag:4];    //运单号码
    UILabel *sendTimeLabel = (UILabel *)[contentView viewWithTag:5];  //发货时间
    UILabel *signedQuantityLabel = (UILabel *)[contentView viewWithTag:6];        //签收数量
    UILabel *signedTimeLabel = (UILabel *)[contentView viewWithTag:7];      //签收时间
    UILabel *signedDifferenceLabel = (UILabel *)[contentView viewWithTag:8];      //签收差异
    
    [UICommon handleLabel:receiverLabel withVC:self withString:@"肖文伟" withTelephoneNO:@"18662212273" withSelector:@selector(tapAtTelephone:)];
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
