//
//  AddressTableViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/23.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "BrandTableViewController.h"

@interface BrandTableViewController ()
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *selectedIndexPathsArr;
@end

@implementation BrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndexPathsArr = @[].mutableCopy;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self showBrands];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)showBrands{
    self.dataDic = [self testData];
    [self.tableView reloadData];
}


-(NSDictionary*)testData{
    NSMutableDictionary *brandsDic = @{}.mutableCopy;
    brandsDic[@"A"] = @[@"艾玛",@"阿米尼"];
    brandsDic[@"B"] = @[@"宝鸟",@"比德文",@"邦德"];
    //    provinceDic[@"B"] =@[@{@"江苏省":citysDic},@{@"北京市":citysDic2}];
    return brandsDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *key = [[self.dataDic allKeys] objectAtIndex:indexPath.section];
//    NSArray *values = [self.dataDic objectForKey:key];
    __block NSIndexPath *path = nil;
    [self.selectedIndexPathsArr enumerateObjectsUsingBlock:^(NSIndexPath *selectedPath, NSUInteger idx, BOOL *stop) {
        if (selectedPath.section == indexPath.section && selectedPath.row == indexPath.row) {
            path = selectedPath;
            *stop = YES;
        }
    }];
    if (path) {
        [self.selectedIndexPathsArr removeObject:path];
    }else{
        [self.selectedIndexPathsArr addObject:indexPath];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark --

#pragma mark UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.dataDic allKeys];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.dataDic allKeys] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *key = [[self.dataDic allKeys] objectAtIndex:indexPath.section];
    NSArray *allValue = [self.dataDic objectForKey:key];
    cell.textLabel.text = [allValue objectAtIndex:indexPath.row];
    UIImageView *view = nil;
    if (!cell.accessoryView) {
        view = [[UIImageView alloc] initWithFrame:(CGRect){0,0,20,20}];
        cell.accessoryView = view;
    }else{
       view = (UIImageView*)cell.accessoryView;
    }
    __block NSIndexPath *path = nil;
    [self.selectedIndexPathsArr enumerateObjectsUsingBlock:^(NSIndexPath *selectedPath, NSUInteger idx, BOOL *stop) {
        if (selectedPath.section == indexPath.section && selectedPath.row == indexPath.row) {
            path = selectedPath;
            *stop = YES;
        }
    }];
    if (path) {
        [view setImage:[UIImage imageNamed:@"checkbox1_checked"]];
    }else{
        [view setImage:[UIImage imageNamed:@"checkbox1_unchecked"]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *key = [[self.dataDic allKeys] objectAtIndex:section];
    NSArray *values = [self.dataDic objectForKey:key];
    return [values count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    NSString *sectionString = [[self.dataDic allKeys] objectAtIndex:section];
    view.textLabel.text = sectionString;
    return view;
}

#pragma mark --
@end
