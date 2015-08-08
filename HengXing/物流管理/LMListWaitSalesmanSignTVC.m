//
//  LMListWaitMySignTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "LMListWaitSalesmanSignTVC.h"
#import "UICommon.h"
#import "LMSalesmanSignedHistoryTVC.h"

@interface LMListWaitSalesmanSignTVC ()

@end

@implementation LMListWaitSalesmanSignTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
}

- (void)_initView {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 60;
    }
    return 164;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) { //第一行的功能按钮
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeader"];
        UIButton *sendButton = (UIButton *)[cell.contentView viewWithTag:1];
        UIButton *historyButton = (UIButton *)[cell.contentView viewWithTag:2];
        sendButton.layer.cornerRadius = 6.;
        [sendButton removeTarget:self action:@selector(clickAtScanButton:) forControlEvents:UIControlEventTouchUpInside];
        [sendButton addTarget:self action:@selector(clickAtScanButton:) forControlEvents:UIControlEventTouchUpInside];
        [historyButton removeTarget:self action:@selector(clickAtHistoryButton:) forControlEvents:UIControlEventTouchUpInside];
        [historyButton addTarget:self action:@selector(clickAtHistoryButton:) forControlEvents:UIControlEventTouchUpInside];
        NSAttributedString *attriTitle = [[NSAttributedString alloc] initWithString:historyButton.titleLabel.text
                                                                         attributes:@{NSFontAttributeName : historyButton.titleLabel.font,
                                                                                      NSUnderlineColorAttributeName : historyButton.titleLabel.textColor,
                                                                                      NSUnderlineStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                                                                      NSForegroundColorAttributeName : historyButton.titleLabel.textColor}];
        [historyButton setAttributedTitle:attriTitle forState:UIControlStateNormal];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellData"];
        UIView *contentView = cell.contentView;
        
        UILabel *compensationTimeLabel = (UILabel *)[contentView viewWithTag:1];   //补赔时间
        UILabel *returnBatterLabel = (UILabel *)[contentView viewWithTag:2];  //原样返回电池
        UILabel *newBatteryLabel = (UILabel *)[contentView viewWithTag:3]; //补赔全新电池
        UILabel *servBatteryLabel = (UILabel *)[contentView viewWithTag:4];   //补赔服务电池
        UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:5];           //物流公司
        UILabel *trackNOLabel = (UILabel *)[contentView viewWithTag:6];           //运单号码
        UILabel *officeLabel = (UILabel *)[contentView viewWithTag:7];           //办事处
        UIButton *signButton = (UIButton *)[contentView viewWithTag:8];         //签收按钮
        
        NSString *officeString = @"苏州市苏州客服中心";
        NSString *officeTelephoneString = @"";
        [UICommon handleLabel:officeLabel withVC:self withString:officeString withTelephoneNO:officeTelephoneString withSelector:@selector(tapAtOfficeTelephone:)];
        
        signButton.layer.cornerRadius = 6.;
        [signButton addTarget:self action:@selector(clickAtSignButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

#pragma mark user Interactions
//扫条码查询
- (void)clickAtScanButton:(id)sender {
    
}

//历史记录
- (void)clickAtHistoryButton:(id)sender {
    [LMSalesmanSignedHistoryTVC show:self.navigationController];
}

//点击发货人电话
- (void)tapAtOfficeTelephone:(UITapGestureRecognizer *)sender {
    UILabel *officeLabel = (UILabel *)sender.view;
    UITableViewCell *cell = (UITableViewCell *)officeLabel.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //根据indexPath找到电话号码 并拨号
    NSString *phoneNO = @"0752-88984521";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNO]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法拨号" message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
    
}

//点击签收
- (void)clickAtSignButton:(UIButton *)sender {
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //根据indexPath进行签收
}

@end
