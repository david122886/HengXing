//
//  LMContainerVC.h
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//
/*
 物流管理
 标签页管理VC
 管理4个嵌入TVC: 您发出的故障电池, 等待您签收的补偿电池,  签收客诉电池, 等待补偿电池
 */
#import "NoRotateViewController.h"

@interface LMContainerVC : NoRotateViewController
+ (void)show:(UINavigationController *)nvc;
@end
