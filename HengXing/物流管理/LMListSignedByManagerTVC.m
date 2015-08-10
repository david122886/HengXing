//
//  LMListSignedByManagerTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
#import "UICommon.h"
#import "LMListSignedByManagerTVC.h"
#import "LMSignedByManagerHistoryTVC.h"
#import "LMManagerSigningTVC.h"

@interface LMListSignedByManagerTVC ()

@end

@implementation LMListSignedByManagerTVC
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
        
        UILabel *senderLabel = (UILabel *)[contentView viewWithTag:1];   //发货人
        UILabel *sendCityLabel = (UILabel *)[contentView viewWithTag:2];  //发货城市
        UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:3]; //物流公司
        UILabel *trackingNumberLabel = (UILabel *)[contentView viewWithTag:4];   //运单号码
        UILabel *sendTimeLabel = (UILabel *)[contentView viewWithTag:5];           //发货时间
        UILabel *batteryQuantityLabel = (UILabel *)[contentView viewWithTag:6];           //电池数量
        UIButton *signButton = (UIButton *)[contentView viewWithTag:7];
        
        NSString *officeString = @"肖文伟";
        NSString *officeTelephoneString = @"137798886888";
        [UICommon handleLabel:senderLabel withVC:self withString:officeString withTelephoneNO:officeTelephoneString withSelector:@selector(tapAtSenderTelephone:)];
        
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
    [LMSignedByManagerHistoryTVC show:self.navigationController];
}

//点击发货人电话
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
- (void)clickAtSignButton:(UIButton *)sender {
    UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //根据indexPath进行签收
    [LMManagerSigningTVC show:self.navigationController];
}
@end
