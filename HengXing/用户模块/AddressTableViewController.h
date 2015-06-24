//
//  AddressTableViewController.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/23.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 选择身份和城市
 */
@interface AddressTableViewController : UITableViewController
@property (nonatomic,assign,readonly) BOOL isProvinceSelected;
@property (nonatomic,strong) void (^provinceSelectedBlock)(NSString *province);
@property (nonatomic,strong) void (^citySelectedBlock)(NSString *province);
-(void)showProvince;
-(void)showCitysForProvinceName:(NSString*)provinceName;
@end
