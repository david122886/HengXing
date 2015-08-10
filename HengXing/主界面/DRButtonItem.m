//
//  DRButtonItem.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/30.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "DRButtonItem.h"

@implementation DRButtonItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(IBAction)itemClicked:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonItem:seletedItemType:)]) {
        [self.delegate buttonItem:self seletedItemType:self.tag];
    }
}
@end
