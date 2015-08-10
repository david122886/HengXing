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
- (IBAction)rightTopBarItemClicked:(UIBarButtonItem *)sender {
    if (self.brandsSelectedBlock) {
        NSMutableArray *selectedDatas = @[].mutableCopy;
        [self.selectedIndexPathsArr enumerateObjectsUsingBlock:^(NSIndexPath *path, NSUInteger idx, BOOL *stop) {
            NSString *key = [self.dataDic allKeys][path.section];
            NSArray *values = self.dataDic[key];
            [selectedDatas addObject:values[path.row]];
        }];
        self.brandsSelectedBlock(selectedDatas);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    if(!self.selectedIndexPathsArr) self.selectedIndexPathsArr = @[].mutableCopy;
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
}

-(void)showBrandsWithSelectedBrands:(NSArray *)hasSelectedBrands{
    self.dataDic = [self testData];
    if(!self.selectedIndexPathsArr) self.selectedIndexPathsArr = @[].mutableCopy;
    if (hasSelectedBrands && hasSelectedBrands.count > 0) {
        NSArray *keys = [self.dataDic allKeys];
        NSMutableArray *seletedPath = @[].mutableCopy;
        [hasSelectedBrands enumerateObjectsUsingBlock:^(NSString *value, NSUInteger idx, BOOL *stop) {
            [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger section, BOOL *stop) {
                NSArray *values = [self.dataDic objectForKey:key];
                if ([values containsObject:value]) {
                    [seletedPath addObject:[NSIndexPath indexPathForRow:[values indexOfObject:value] inSection:section]];
                    *stop = YES;
                }
            }];
        }];
        [self.selectedIndexPathsArr addObjectsFromArray:seletedPath];
    }
    
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
    [self.navigationItem.rightBarButtonItem setEnabled:self.selectedIndexPathsArr.count >0];
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
