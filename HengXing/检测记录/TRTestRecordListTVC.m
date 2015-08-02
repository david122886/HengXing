//
//  TRTestRecordListTVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "TRTestRecordListTVC.h"
#import "TRTestRecordDetailTVC.h"

@interface TRTestRecordListTVC ()

@end

@implementation TRTestRecordListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"检测记录";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.6 green:.6 blue:.9 alpha:1.];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont systemFontOfSize:18]};
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell"];
    UILabel *timeLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *barcodeLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:3];
    UILabel *errorCodeLabel = (UILabel *)[cell.contentView viewWithTag:4];
    UILabel *warrantyPeriodLabel = (UILabel *)[cell.contentView viewWithTag:5];
    
    timeLabel.text = @"06月01日\n苏州市";
    warrantyPeriodLabel.text = @"保修期内\n(15个月内)";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [TRTestRecordDetailTVC show:self.navigationController];
}
@end
