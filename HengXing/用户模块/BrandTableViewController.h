//
//  BrandTableViewController.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/25.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 品牌选择
 */
@interface BrandTableViewController : UITableViewController
@property (nonatomic,strong) void (^brandsSelectedBlock)(NSArray *brandsArray);
-(void)showBrandsWithSelectedBrands:(NSArray *)hasSelectedBrands;
@end
