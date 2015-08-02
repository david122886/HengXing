//
//  TRTestRecordDetailTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "TRTestRecordDetailTVC.h"

@interface TRTestRecordDetailTVC ()
///电池条码
@property (weak, nonatomic) IBOutlet UILabel *batteryBarCode;
///产品规格
@property (weak, nonatomic) IBOutlet UILabel *batteryType;
///故障名称
@property (weak, nonatomic) IBOutlet UILabel *troubleName;
///检修时间
@property (weak, nonatomic) IBOutlet UILabel *testDate;
///采购方
@property (weak, nonatomic) IBOutlet UILabel *buyerName;
///保修状态
@property (weak, nonatomic) IBOutlet UILabel *repairState;
///返厂状态
@property (weak, nonatomic) IBOutlet UILabel *returnFactoryState;
///更换电池
@property (weak, nonatomic) IBOutlet UILabel *batteryToChange;
///检测仪ID
@property (weak, nonatomic) IBOutlet UILabel *detectorID;
///检修员
@property (weak, nonatomic) IBOutlet UILabel *inspectorName;
///检修城市
@property (weak, nonatomic) IBOutlet UILabel *testCity;
///检测员手机号
@property (weak, nonatomic) IBOutlet UILabel *inspectorPhoneNO;
///检测数据内容
@property (weak, nonatomic) IBOutlet UITextView *testContent;

@end

@implementation TRTestRecordDetailTVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    TRTestRecordDetailTVC *tvc = [story instantiateViewControllerWithIdentifier:@"TRTestRecordDetailTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _initView];
}

- (void)_initView {
    self.title = @"检测记录详情";
    _testContent.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark UITableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row == 0 || row == 10 || row == 14) { //headerCell
        return 30;
    }
    if (row == 15) {
        CGFloat height = [self _calcTestContentHeight];
        return height;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)_calcTestContentHeight {
    NSString *testContent = @".电芯1电压:3.908V\n.电芯2电压:3.908V\n.电芯3电压:3.908V\n.电芯4电压:3.908V\n.电芯5电压:3.908V\n.电芯6电压:3.908V\n.电芯7电压:3.908V\n.电芯8电压:3.908V\n.电芯9电压:3.908V\n.电芯10电压:3.908V\n.电芯11电压:3.908V\n.电芯12电压:3.908V\n.SOC值:98%";
    _testContent.text = testContent;
    
    CGFloat leftPadding = 30;
    CGFloat rightPadding = 8;
    CGFloat topPadding = 32;
    CGFloat bottomPadding = 8;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - leftPadding - rightPadding;
    CGSize stringSize = [testContent boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : _testContent.font} context:nil].size;
    return stringSize.height + topPadding + bottomPadding + 10;
}
@end
