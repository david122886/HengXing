//
//  LMManagerSigningVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
#import "UICommon.h"
#import "LMManagerSigningTVC.h"

@interface LMManagerSigningTVC () {
    NSMutableArray *_recordsArray;
}

@end

@implementation LMManagerSigningTVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    LMManagerSigningTVC *tvc = [story instantiateViewControllerWithIdentifier:@"LMManagerSigningTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
    
    _recordsArray = [@[@"", @"", @"", @"", @""] mutableCopy];
}

- (void)_initView {
    self.title = @"签收返厂电池";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + _recordsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) { //头
        return 302;
    }
    if (indexPath.row == 1 + _recordsArray.count) { //确认提交
        return 60;
    }
    return 34;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) { //头
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeader"];
        [self _buildCellHeader:cell];
    } else if (indexPath.row == 1 + _recordsArray.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellConfirm"];
        [self _buildCellConfirm:cell];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellData"];
        [self _buildCellData:cell atIndexPath:indexPath];
    }
    return cell;
}

- (void)_buildCellHeader:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    UILabel *senderLabel = (UILabel *)[contentView viewWithTag:1];   //发货人
    UILabel *senderCityLabel = (UILabel *)[contentView viewWithTag:2];  //发货城市
    UILabel *logisticsCompanyLabel = (UILabel *)[contentView viewWithTag:3];  //物流公司
    UILabel *trackNOLabel = (UILabel *)[contentView viewWithTag:4];      //运单号码
    UILabel *sendTimeLabel = (UILabel *)[contentView viewWithTag:5];    //发货时间
    UILabel *batterQuantityLabel = (UILabel *)[contentView viewWithTag:6];   //电池数量
    UIButton *scanButton = (UIButton *)[contentView viewWithTag:7];     //扫描电池条码
    UIButton *typeButton = (UIButton *)[contentView viewWithTag:8];    //输入电池条码
    UILabel *indexLabel = (UILabel *)[contentView viewWithTag:9];       //序号
    UILabel *batteryNOLabel = (UILabel *)[contentView viewWithTag:10];  //电池条码
    
    scanButton.layer.cornerRadius = 6.;
    [scanButton removeTarget:self action:@selector(clickAtScanButton:) forControlEvents:UIControlEventTouchUpInside];
    [scanButton addTarget:self action:@selector(clickAtScanButton:) forControlEvents:UIControlEventTouchUpInside];
    typeButton.layer.cornerRadius = 6.;
    [typeButton removeTarget:self action:@selector(clickAtTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    [typeButton addTarget:self action:@selector(clickAtTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    indexLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    indexLabel.layer.borderWidth = .5;
    batteryNOLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    batteryNOLabel.layer.borderWidth = .5;
    
    [UICommon handleLabel:senderLabel withVC:self withString:@"肖文伟" withTelephoneNO:@"18898982113" withSelector:@selector(tapAtTelephone:)];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor grayColor]};
    senderCityLabel.attributedText = [LMManagerSigningTVC attriStringWithTitle:@"发货城市:"
                                                                       content:@"苏州市"
                                                             contentAttributes:attributes];
    logisticsCompanyLabel.attributedText = [LMManagerSigningTVC attriStringWithTitle:@"物流公司:"
                                                                       content:@"圆通速递"
                                                             contentAttributes:attributes];
    trackNOLabel.attributedText = [LMManagerSigningTVC attriStringWithTitle:@"运单号码:"
                                                                       content:@"NP22331122421"
                                                             contentAttributes:attributes];
    sendTimeLabel.attributedText = [LMManagerSigningTVC attriStringWithTitle:@"发货时间:"
                                                                       content:@"2015-12-12 10:10:12"
                                                             contentAttributes:attributes];
    batterQuantityLabel.attributedText = [LMManagerSigningTVC attriStringWithTitle:@"电池数量:"
                                                                       content:@"2组"
                                                             contentAttributes:attributes];
    
}

//字符串处理
+ (NSMutableAttributedString *)attriStringWithTitle:(NSString *)title content:(NSString *)content contentAttributes:(NSDictionary *)attributes {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", title, content]];
    if (content.length > 0) {
        NSRange contentRange = NSMakeRange(attriString.length - content.length, content.length);
        [attriString setAttributes:attributes range:contentRange];
    }
    return attriString;
}

- (void)_buildCellConfirm:(UITableViewCell *)cell {
    UIButton *confirmButton = (UIButton *)[cell.contentView viewWithTag:1];
    confirmButton.layer.cornerRadius = 6.;
    [confirmButton removeTarget:self action:@selector(clickAtConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton addTarget:self action:@selector(clickAtConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)_buildCellData:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UIView *contentView = cell.contentView;
    UILabel *indexLabel = (UILabel *)[contentView viewWithTag:1];   //序号
    UILabel *trackNOLabel = (UILabel *)[contentView viewWithTag:2];  //电池条码
    
    indexLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    indexLabel.layer.borderWidth = .5;
    trackNOLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    trackNOLabel.layer.borderWidth = .5;
    
    NSInteger index = indexPath.row - 1;
    indexLabel.text = [NSString stringWithFormat:@"%ld", (long)index];
    trackNOLabel.text = @"PN235EAC3258293";
}

#pragma mark user interactions
- (void)tapAtTelephone:(id)sender {
    //点击发货人电话
    NSString *phoneNO = @"0752-88984521";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNO]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法拨号" message:@"" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
    }
}

//点击输入条码
- (void)clickAtTypeButton:(id)sender {
    
}

//点击扫描条码
- (void)clickAtScanButton:(id)sender {
    
}

//确定签收
- (void)clickAtConfirmButton:(id)sender {
    
}
@end
