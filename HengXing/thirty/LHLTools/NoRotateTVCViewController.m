//
//  NoRotateTVCViewController.m
//  Helper
//
//  Created by 付 永杰 on 13-8-18.
//  Copyright (c) 2013年 Wafer. All rights reserved.
//

#import "NoRotateTVCViewController.h"

@implementation NoRotateTVCViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationPortrait;
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate
{
    return NO;
    
}
@end
