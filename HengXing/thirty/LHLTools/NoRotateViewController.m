//
//  NoRotateViewController.m
//  Helper
//
//  Created by 付 永杰 on 13-7-16.
//  Copyright (c) 2013年 Wafer. All rights reserved.
//

#import "NoRotateViewController.h"

@interface NoRotateViewController ()

@end

@implementation NoRotateViewController

/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

  */


- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
//    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate {
    return NO; 
 }


@end
