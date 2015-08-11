//
//  MainViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/29.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "MainViewController.h"
#import "DRButtonItem.h"
#import "WPWarrantyPeriodQueryVC.h"
#import "TRTestRecordListTVC.h"
#import "SIStatisticalInformationTVC.h"
#import "LMContainerVC.h"


@interface MainViewController ()<DRButtonItemDelegate,UIScrollViewDelegate>
- (IBAction)topRightItemClicked:(UIBarButtonItem *)sender;
///检测
@property (weak, nonatomic) IBOutlet DRButtonItem *checkItem;
///检测记录
@property (weak, nonatomic) IBOutlet DRButtonItem *checkRecoderItem;
///物流
@property (weak, nonatomic) IBOutlet DRButtonItem *logisticItem;
///保修期查询
@property (weak, nonatomic) IBOutlet DRButtonItem *warrantyDateSearchItem;
///统计信息
@property (weak, nonatomic) IBOutlet DRButtonItem *statisticsInfoItem;
///帮助
@property (weak, nonatomic) IBOutlet DRButtonItem *helpInfoItem;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)topRightItemClicked:(UIBarButtonItem *)sender {
    
}


#pragma mark -
#pragma mark -- DRButtonItemDelegate
-(void)buttonItem:(DRButtonItem *)item seletedItemType:(DRButtonItemType)type{
    switch (type) {
        case DRButtonItemType_check:
        {
            
        }
            break;
        case DRButtonItemType_checkRecoder:
        {
            [TRTestRecordListTVC show:self.navigationController];
        }
            break;
        case DRButtonItemType_helpInfo:
        {
            
        }
            break;
        case DRButtonItemType_logistic:
        {
            [LMContainerVC show:self.navigationController];
        }
            break;
        case DRButtonItemType_statistic:
        {
            [SIStatisticalInformationTVC show:self.navigationController];
        }
            break;
        case DRButtonItemType_warrantyDate:
        {
            [WPWarrantyPeriodQueryVC show:self.navigationController];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark -


#pragma mark -
#pragma mark -- UIScrollViewDelegate


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x >= CGRectGetWidth(scrollView.frame)-20) {
        self.pageControl.currentPage = 1;
    }else{
        self.pageControl.currentPage = 0;
    }
}
#pragma mark -
@end
