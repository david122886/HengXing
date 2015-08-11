//
//  LogisticsTableViewCell.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/8/11.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelNumberThisMonth; //本月更换故障电池数
@property (weak, nonatomic) IBOutlet UILabel *labelNumberThreeMonth; //近三个月更换的故障电池数
@property (weak, nonatomic) IBOutlet UIView *leftCircleView;
@property (weak, nonatomic) IBOutlet UIView *rightCircleView;
@property (weak, nonatomic) IBOutlet UIView *haloView;
@end
