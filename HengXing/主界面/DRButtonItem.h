//
//  DRButtonItem.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/30.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DRButtonItemType){
    ///售后检测
    DRButtonItemType_check = 10,
    ///检测记录
    DRButtonItemType_checkRecoder,
    ///物流管理
    DRButtonItemType_logistic,
    ///保修查询
    DRButtonItemType_warrantyDate,
    ///统计信息
    DRButtonItemType_statistic,
    ///使用说明
    DRButtonItemType_helpInfo
};
@class DRButtonItem ;

@protocol DRButtonItemDelegate <NSObject>
-(void)buttonItem:(DRButtonItem*)item seletedItemType:(DRButtonItemType)type;
@end

///主页使用
@interface DRButtonItem : UIView
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UIButton *bt;
-(IBAction)itemClicked:(id)sender;

@property (nonatomic,weak) IBOutlet id<DRButtonItemDelegate> delegate;
@end

