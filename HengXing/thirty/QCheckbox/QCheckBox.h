//
//  EICheckBox.h
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCheckBoxDelegate;

@interface QCheckBox : UIButton
@property(nonatomic, assign)id<QCheckBoxDelegate> delegate;
@property(nonatomic, assign)BOOL checked;
@property(nonatomic, retain)id userInfo;

-(void)setupDelegate:(id)delegate;
@end

@protocol QCheckBoxDelegate <NSObject>

@optional

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked;

@end
