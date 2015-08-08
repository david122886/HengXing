//
//  UICommon.m
//  HengXing
//
//  Created by lihongliang on 15/8/4.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "UICommon.h"

@implementation UICommon
+ (void)numberNarrowFontForLabel:(UILabel *)label {
    label.font = [UIFont fontWithName:@"Avenir Next Condensed" size:label.font.pointSize];
}

///处理一个label的string, 如有电话号码, 将号码变色, 并支持点击方法
+ (void)handleLabel:(UILabel *)officeLabel withVC:(UIViewController *)vc withString:(NSString *)officeString withTelephoneNO:(NSString *)officeTelephone withSelector:(SEL)selector {
    if (officeTelephone.length < 1) {
        officeLabel.text = officeString;
        officeLabel.userInteractionEnabled = NO;
    } else {
        NSString *combinedString = [NSString stringWithFormat:@"%@(%@)", officeString, officeTelephone];
        NSRange telephoneRange = [combinedString rangeOfString:officeTelephone options:NSBackwardsSearch];
        NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:combinedString];
        [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:telephoneRange];
        officeLabel.attributedText = attriString;
        
        officeLabel.userInteractionEnabled = YES;
        UIGestureRecognizer *gesture = [officeLabel.gestureRecognizers firstObject];
        if (gesture) {
            [officeLabel removeGestureRecognizer:gesture];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:vc action:selector];
        [officeLabel addGestureRecognizer:tap];
        
    }
}
@end
