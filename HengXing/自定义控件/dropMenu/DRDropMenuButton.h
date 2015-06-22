//
//  DRDropMenuButton.h
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/18.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 下拉菜单
 */
@interface DRDropMenuButton : UIButton
-(void)addDropMenuTopView:(UIView*)topView
          insertSuperView:(UIView*)superView
            withMaxHeight:(NSInteger)maxHeight
withShowMenuItemStringArrayBlock:(NSArray* (^)())itemStringArrBlock
    withSelectedItemBlock:(void(^)(NSString *itemString))selectedBlock;

-(void)hiddleDropMenuListView;
@end
