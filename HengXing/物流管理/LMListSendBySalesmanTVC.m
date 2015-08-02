//
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "LMListSendBySalesmanTVC.h"

@interface LMListSendBySalesmanTVC ()

@end

@implementation LMListSendBySalesmanTVC

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
    return 87;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) { //第一行的功能按钮
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeader"];
        UIButton *sendButton = (UIButton *)[cell.contentView viewWithTag:1];
        UIButton *historyButton = (UIButton *)[cell.contentView viewWithTag:2];
        sendButton.layer.cornerRadius = 6.;
        [sendButton removeTarget:self action:@selector(clickAtSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [sendButton addTarget:self action:@selector(clickAtSendButton:) forControlEvents:UIControlEventTouchUpInside];
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
        UILabel *sendTimeLabel = (UILabel *)[contentView viewWithTag:1];   //发货时间
        UILabel *batteryQuantityLabel = (UILabel *)[contentView viewWithTag:2];  //电池数量
        UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:3]; //物流公司
        UILabel *trackingNumberLabel = (UILabel *)[contentView viewWithTag:4];   //运单号码
        UILabel *officeLabel = (UILabel *)[contentView viewWithTag:5];           //办事处
        
        NSString *officeString = @"高新区金沙路181号";
        NSString *officeTelephoneString = @"137798886888";
        [self _handleOfficeLabel:officeLabel withOfficeString:officeString withTelephoneNO:officeTelephoneString];
        
    }
    
    return cell;
}

//处理办事处label, 如有电话号码, 将号码变色, 并支持点击
- (void)_handleOfficeLabel:(UILabel *)officeLabel withOfficeString:(NSString *)officeString withTelephoneNO:(NSString *)officeTelephone {
    if (officeTelephone.length < 1) {
        officeLabel.text = officeString;
        officeLabel.userInteractionEnabled = NO;
    } else {
        NSString *combinedString = [NSString stringWithFormat:@"%@(%@)", officeString, officeTelephone];
        NSRange telephoneRange = [combinedString rangeOfString:officeTelephone options:NSBackwardsSearch];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:combinedString];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:telephoneRange];
        officeLabel.attributedText = attriString;
        
        officeLabel.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [officeLabel.gestureRecognizers firstObject];
        if (gesture) {
            [officeLabel removeGestureRecognizer:gesture];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAtOfficeTelephone:)];
        [officeLabel addGestureRecognizer:tap];
        
    }
}

#pragma mark user Interactions
//发货
- (void)clickAtSendButton:(id)sender {
    
}

//历史记录
- (void)clickAtHistoryButton:(id)sender {
    
}

//点击办事处电话
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
        
    }
    
}
@end
