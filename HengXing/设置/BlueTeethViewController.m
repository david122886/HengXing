//
//  BlueTeethViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/7/12.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "BlueTeethViewController.h"

@interface BlueTeethViewController ()
@property (nonatomic,strong) UIButton *deleteBt;
@property (weak, nonatomic) IBOutlet UIButton *startSearchBlueTeethBt;
- (IBAction)startSearchBlueTeethBtClicked:(UIButton *)sender;

@end

@implementation BlueTeethViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)deleteHasConnectedBlueTeethDevice:(UIButton*)bt{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark --

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        self.deleteBt = (UIButton*)[cell viewWithTag:16];
        [self.deleteBt addTarget:self action:@selector(deleteHasConnectedBlueTeethDevice:) forControlEvents:UIControlEventTouchUpInside];
        [(UILabel*)[cell viewWithTag:15] setText:@"你好"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        [(UILabel*)[cell viewWithTag:15] setText:@"你好"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableCellWithIdentifier:@"sectionHeader"];
//    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionHeader"];
    if (section == 0) {
        [(UILabel*)[view viewWithTag:15] setText:@"已选择的锂电检测仪"];
    }
    if (section == 1) {
        [(UILabel*)[view viewWithTag:15] setText:@"已配对的设备"];
    }
    if (section == 2) {
        [(UILabel*)[view viewWithTag:15] setText:@"可用设备"];
    }
    return view;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
//    
//    return view;
//}
#pragma mark --


- (IBAction)startSearchBlueTeethBtClicked:(UIButton *)sender {
}
@end
