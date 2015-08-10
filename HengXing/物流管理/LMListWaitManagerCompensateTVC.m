//
//  LMListWaitManagerCompensateTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
#import "UICommon.h"
#import "LMManagerCompensateHistoryTVC.h"
#import "LMListWaitManagerCompensateTVC.h"
#import "LMManagerCompensatingTVC.h"

@interface LMListWaitManagerCompensateTVC ()

@end

@implementation LMListWaitManagerCompensateTVC
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
    return 137;
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
        sendButton.hidden = YES; //本界面没有第一个按钮
        
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
        //        for (UIView *view in contentView.subviews) {
        //            view.layer.borderColor = [UIColor redColor].CGColor;
        //            view.layer.borderWidth = .6;
        //        }
        
        UILabel *senderLabel = (UILabel *)[contentView viewWithTag:1];   //xx人
        UILabel *cityLabel = (UILabel *)[contentView viewWithTag:2];  //城市
        UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:3]; //可预补电池
        UILabel *returnBatteryLabel = (UILabel *)[contentView viewWithTag:4];   //需原样返回电池
        UILabel *newBatteryLabel = (UILabel *)[contentView viewWithTag:5];           //需补偿全新电池
        UILabel *servBatteryLabel = (UILabel *)[contentView viewWithTag:6];           //需补赔服务电池
        UIButton *compensationButton = (UIButton *)[contentView viewWithTag:7];
        
        NSString *officeString = @"肖文伟";
        NSString *officeTelephoneString = @"137798886888";
        [UICommon handleLabel:senderLabel withVC:self withString:officeString withTelephoneNO:officeTelephoneString withSelector:@selector(tapAtSenderTelephone:)];
        
        compensationButton.layer.cornerRadius = 6.;
        [compensationButton addTarget:self action:@selector(clickAtCompensationButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return cell;
}

#pragma mark user Interactions
- (void)clickAtScanButton:(id)sender {
    
}

//历史记录
- (void)clickAtHistoryButton:(id)sender {
    [LMManagerCompensateHistoryTVC show:self.navigationController];
}

//点击人电话
- (void)tapAtSenderTelephone:(UITapGestureRecognizer *)sender {
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
- (void)clickAtCompensationButton:(UIButton *)sender {
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //根据indexPath进行签收
    [LMManagerCompensatingTVC show:self.navigationController];
}

@end
