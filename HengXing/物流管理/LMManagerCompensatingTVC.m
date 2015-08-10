//
//  LMManagerCompensatingTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
#import "UICommon.h"
#import "LMManagerCompensatingTVC.h"

@interface LMManagerCompensatingTVC () {
    NSMutableArray *_returnBatteryArray; //原样返回电池
    NSMutableArray *_needPreCompensationArray; //需预补电池
    NSMutableArray *_allBatterBarcodeArray; //发货的所有电池条码
}

@end

@implementation LMManagerCompensatingTVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    LMManagerCompensatingTVC *tvc = [story instantiateViewControllerWithIdentifier:@"LMManagerCompensatingTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
    _returnBatteryArray = [@[@"", @"", @"", @""] mutableCopy];
    _needPreCompensationArray = [@[@"", @"", @"", @""] mutableCopy];
    _allBatterBarcodeArray = [@[@"", @"", @"", @""] mutableCopy];
}

- (void)_initView {
    self.title = @"补赔电池发货";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 + _returnBatteryArray.count + _needPreCompensationArray.count + _allBatterBarcodeArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {  //头
        return 234;
    }
    NSInteger usedIndex = 0;
    if (_returnBatteryArray.count > 0) {
        if (indexPath.row <= _returnBatteryArray.count) { //原样返回电池条码
            return 34;
        }
        usedIndex = _returnBatteryArray.count;
    }
    if (indexPath.row == usedIndex + 1) { //预补赔电池header
        return 81;
    }
    if (_needPreCompensationArray.count > 0) {
        if (indexPath.row > usedIndex + 1 && indexPath.row <= usedIndex + 1 + _needPreCompensationArray.count) { //需预补电池的检测记录
            return 34;
        }
        usedIndex = usedIndex + 1 + _needPreCompensationArray.count;
    }
    if (indexPath.row == usedIndex + 1) { //补赔物流信息
        return 112;
    }
    if (indexPath.row == usedIndex + 2) { //电池条码control
        return 134;
    }
    if (_allBatterBarcodeArray.count > 0) {
        if (indexPath.row > usedIndex + 2 && indexPath.row <= usedIndex + 2 + _allBatterBarcodeArray.count) {  //电池条码
            return 34;
        }
    }
    return 60; //确认按钮
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {  //头
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellHeader"];
        [self _buildCellHeader:cell];
        return cell;
    }
    NSInteger usedIndex = 0;
    if (_returnBatteryArray.count > 0) {
        if (indexPath.row > 0 && indexPath.row <= _returnBatteryArray.count) { //原样返回电池条码
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellReturnBattery"];
            [self _buildCellReturnBattery:cell forIndexPath:indexPath];
            return cell;
        }
        usedIndex = _returnBatteryArray.count;
    }
    if (indexPath.row == usedIndex + 1) { //预补赔电池header
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellPreCompensationHeader"];
        [self _buildCellPreCompensationHeader:cell];
        return cell;
    }
    if (_needPreCompensationArray.count > 0) {
        if (indexPath.row > usedIndex + 1 && indexPath.row <= usedIndex + 1 + _needPreCompensationArray.count) { //需预补电池的检测记录
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellPreCompensation"];
            [self _buildCellPreCompensation:cell forIndexPath:indexPath];
            return cell;
        }
        usedIndex = usedIndex + 1 + _needPreCompensationArray.count;
    }
    if (indexPath.row == usedIndex + 1) { //补赔物流信息
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellLogisticsInfo"];
        [self _buildCellLogisticsInfo:cell];
        return cell;
    }
    if (indexPath.row == usedIndex + 2) { //电池条码control
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellBarCodeControl"];
        [self _buildCellBarCodeControl:cell];
        return cell;
    }
    if (_allBatterBarcodeArray.count > 0) {
        if (indexPath.row > usedIndex + 2 && indexPath.row <= usedIndex + 2 + _allBatterBarcodeArray.count) {  //电池条码
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellBarCode"];
            [self _buildCellBarCode:cell forIndexPath:indexPath];
            return cell;
        }
    }
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellConfirm"];
    [self _buildCellConfirm:cell];
    return cell; //确认按钮
}
//头
- (void)_buildCellHeader:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    UILabel *addressLabel = (UILabel *)[contentView viewWithTag:1];    //地址
    UILabel *telephoneLabel = (UILabel *)[contentView viewWithTag:2];  //电话
    UILabel *contactLabel = (UILabel *)[contentView viewWithTag:3];    //联系人
    UILabel *contactTitleLabel = (UILabel *)[contentView viewWithTag:4];  //需要补赔给"xxx"的电池:
    UILabel *newBatteryLabel = (UILabel *)[contentView viewWithTag:5];   //全新电池
    UILabel *servBatteryLabel = (UILabel *)[contentView viewWithTag:6];  //服务电池
    UILabel *returnBatteryLabel = (UILabel *)[contentView viewWithTag:7]; //原样返回
    UILabel *returnBatteryTitleLabel = (UILabel *)[contentView viewWithTag:8];  //"原样返回电池条码"
    
    returnBatteryTitleLabel.backgroundColor = [UIColor whiteColor];
    returnBatteryTitleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    returnBatteryTitleLabel.layer.borderWidth = .5;
}

//原样返回电池条码
- (void)_buildCellReturnBattery:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    UIView *contentView = cell.contentView;
    UILabel *barCodeLabel = (UILabel *)[contentView viewWithTag:1];    //电池条码
    
    barCodeLabel.backgroundColor = [UIColor whiteColor];
    barCodeLabel.layer.borderWidth = .5;
    barCodeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

//需预补赔电池header
- (void)_buildCellPreCompensationHeader:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    UILabel *canPreCompensationLabel = (UILabel *)[contentView viewWithTag:1]; //可预补赔电池
    UILabel *selectLabel = (UILabel *)[contentView viewWithTag:2];
    UILabel *barCodeLabel = (UILabel *)[contentView viewWithTag:3];
    UILabel *changeBatteryLabel = (UILabel *)[contentView viewWithTag:4];
    
    selectLabel.backgroundColor = [UIColor whiteColor];
    selectLabel.layer.borderWidth = .5;
    selectLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    barCodeLabel.backgroundColor = [UIColor whiteColor];
    barCodeLabel.layer.borderWidth = .5;
    barCodeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    changeBatteryLabel.backgroundColor = [UIColor whiteColor];
    changeBatteryLabel.layer.borderWidth = .5;
    changeBatteryLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

//需预补电池的检测记录
- (void)_buildCellPreCompensation:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    UIView *contentView = cell.contentView;
    UIButton *selectButton = (UIButton *)[contentView viewWithTag:1]; //选择按钮
    UILabel *barCodeLabel = (UILabel *)[contentView viewWithTag:2];   //电池条码
    UILabel *batteryLabel = (UILabel *)[contentView viewWithTag:3];   //更换的电池
    
    selectButton.backgroundColor = [UIColor whiteColor];
    selectButton.layer.borderWidth = .5;
    selectButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    barCodeLabel.backgroundColor = [UIColor whiteColor];
    barCodeLabel.layer.borderWidth = .5;
    barCodeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    batteryLabel.backgroundColor = [UIColor whiteColor];
    batteryLabel.layer.borderWidth = .5;
    batteryLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

//补赔物流信息
- (void)_buildCellLogisticsInfo:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    UITextField *logisticsCompanyField = (UITextField *)[contentView viewWithTag:1]; //物流公司
    UITextField *trackNOField = (UITextField *)[contentView viewWithTag:2];   //运单号码
    UIButton *scanButton = (UIButton *)[contentView viewWithTag:3];   //扫描单号
    
    scanButton.layer.cornerRadius = 6.;
    [scanButton removeTarget:self action:@selector(clickAtScanTrackNO:) forControlEvents:UIControlEventTouchUpInside];
    [scanButton addTarget:self action:@selector(clickAtScanTrackNO:) forControlEvents:UIControlEventTouchUpInside];
}

//电池条码control
- (void)_buildCellBarCodeControl:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    UIButton *scanButton = (UIButton *)[contentView viewWithTag:1];   //扫描电池条码
    UIButton *inputButton = (UIButton *)[contentView viewWithTag:2];   //输入电池条码
    UILabel *indexLabel = (UILabel *)[contentView viewWithTag:3]; //序号
    UILabel *barCodeLabel = (UILabel *)[contentView viewWithTag:4];   //电池条码
    
    scanButton.layer.cornerRadius = 6.;
    [scanButton removeTarget:self action:@selector(clickAtScanBarCode:) forControlEvents:UIControlEventTouchUpInside];
    [scanButton addTarget:self action:@selector(clickAtScanBarCode:) forControlEvents:UIControlEventTouchUpInside];
    inputButton.layer.cornerRadius = 6.;
    [inputButton removeTarget:self action:@selector(clickAtInputBarCode:) forControlEvents:UIControlEventTouchUpInside];
    [inputButton addTarget:self action:@selector(clickAtInputBarCode:) forControlEvents:UIControlEventTouchUpInside];
    
    indexLabel.backgroundColor = [UIColor whiteColor];
    indexLabel.layer.borderWidth = .5;
    indexLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    barCodeLabel.backgroundColor = [UIColor whiteColor];
    barCodeLabel.layer.borderWidth = .5;
    barCodeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

//电池条码
- (void)_buildCellBarCode:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    UIView *contentView = cell.contentView;
    UILabel *indexLabel = (UILabel *)[contentView viewWithTag:1]; //序号
    UILabel *barCodeLabel = (UILabel *)[contentView viewWithTag:2];   //电池条码
    
    indexLabel.backgroundColor = [UIColor whiteColor];
    indexLabel.layer.borderWidth = .5;
    indexLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    barCodeLabel.backgroundColor = [UIColor whiteColor];
    barCodeLabel.layer.borderWidth = .5;
    barCodeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

//确认按钮
- (void)_buildCellConfirm:(UITableViewCell *)cell {
    UIView *contentView = cell.contentView;
    UIButton *confirmButton = (UIButton *)[contentView viewWithTag:1];   //扫描电池条码
    
    confirmButton.layer.cornerRadius = 6.;
    [confirmButton removeTarget:self action:@selector(clickAtConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton addTarget:self action:@selector(clickAtConfirmButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark user interactions
//扫描快递单号
- (void)clickAtScanTrackNO:(id)sender {
    
}

//扫描电池条码
- (void)clickAtScanBarCode:(id)sender {
    
}

//输入电池条码
- (void)clickAtInputBarCode:(id)sender {
    
}

//确定补赔
- (void)clickAtConfirmButton:(id)sender {
    
}
@end
