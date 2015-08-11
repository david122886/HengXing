//
//  LogisticsTableViewCell.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/8/11.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "LogisticsTableViewCell.h"

@implementation LogisticsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self _initView];
}

- (void)_initView {
    [self _makeViewRound:_leftCircleView];
    [self _makeViewRound:_rightCircleView];
    [self _makeViewRound:_haloView];
}

- (void)_makeViewRound:(UIView *)view {
    if ([view isKindOfClass:[UIView class]]) {
        view.layer.cornerRadius = view.frame.size.width / 2;
        //        view.layer.shouldRasterize = YES;
    }
}
@end
