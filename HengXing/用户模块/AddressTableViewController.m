//
//  AddressTableViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/23.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "AddressTableViewController.h"

@interface AddressTableViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic,assign) BOOL isSearchStatus;
@property (nonatomic,strong) NSString *searchText;
@property (nonatomic,assign) CGFloat tmpScrollContentOffsetY;
///搜索是用于临时存储数据
@property (nonatomic,strong) NSDictionary *tmpDataDic;
@property (nonatomic,strong) NSDictionary *dataDic;
@end

@implementation AddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
}

-(void)showProvince{
    _isProvinceSelected = YES;
    [self.navigationItem setTitle:@"选择省份"];
    NSDictionary *datas = [self testData];
    NSArray *keys = [datas allKeys];
    NSMutableDictionary *allProvince = @{}.mutableCopy;
    [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        NSArray *values = [datas objectForKey:key];
        NSMutableArray *allValues = @[].mutableCopy;
        [values enumerateObjectsUsingBlock:^(NSDictionary *proviceDic, NSUInteger idx, BOOL *stop) {
            [allValues addObjectsFromArray:[proviceDic allKeys]];
        }];
        allProvince[key] = allValues;
    }];
    self.dataDic = allProvince;
    [self.tableView reloadData];
}

-(void)showCitysForProvinceName:(NSString*)provinceName{
    _isProvinceSelected = NO;
    [self.navigationItem setTitle:@"选择城市"];
    NSDictionary *datas = [self testData];
    
    NSArray *allValues = [datas allValues];
    NSMutableArray *allProvincesArr = @[].mutableCopy;
    [allValues enumerateObjectsUsingBlock:^(NSArray *value, NSUInteger idx, BOOL *stop) {
        [allProvincesArr addObjectsFromArray:value];
    }];
    
    __block NSDictionary *citysDic = nil;
    [allProvincesArr enumerateObjectsUsingBlock:^(NSDictionary *province, NSUInteger idx, BOOL *stop) {
        NSString *key = [[province allKeys] firstObject];
        if (key && [key isEqualToString:provinceName]) {
            citysDic = province[key];
            *stop = YES;
        }
    }];
    self.dataDic = citysDic;
    [self.tableView reloadData];
}

-(NSDictionary*)testData{
    NSMutableDictionary *provinceDic = @{}.mutableCopy;
    NSMutableDictionary *citysDic = @{}.mutableCopy;
    citysDic[@"A"] = @[@"合肥市",@"黄山市"];
    citysDic[@"B"] = @[@"淮北市",@"六安市",@"居巢区青年路"];
    
    
    NSMutableDictionary *citysDic2 = @{}.mutableCopy;
    
    provinceDic[@"A"] =@[@{@"安徽省":citysDic},@{@"澳门特别行政区":citysDic2}];
//    provinceDic[@"B"] =@[@{@"江苏省":citysDic},@{@"北京市":citysDic2}];
    return provinceDic;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark -- UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
//    [QiYeManager searchQiYeObjWithSearchString:searchText withLastObjId:0 withNumberOfPage:20 finished:^(NSArray *huiYuanList) {
//        self.qiYeList = huiYuanList.mutableCopy;
//        [self.tableView reloadData];
//        self.tableView.contentOffset = (CGPoint){0,0};
//    }];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.tmpScrollContentOffsetY = self.tableView.contentOffset.y;
    [searchBar setShowsCancelButton:YES animated:YES];
    self.isSearchStatus = YES;
    self.tmpDataDic = self.dataDic;
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    self.isSearchStatus = NO;
    self.searchText = nil;
    self.dataDic = self.tmpDataDic;
    [self.tableView reloadData];
}
#pragma mark -

#pragma mark -
#pragma mark -- scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.searchBar.isFirstResponder && fabsf(self.tmpScrollContentOffsetY - scrollView.contentOffset.y) > 50) {
        [self.searchBar resignFirstResponder];
        [self.searchBar setShowsCancelButton:NO animated:YES];
        self.tmpScrollContentOffsetY = scrollView.contentOffset.y;
    }
}
#pragma mark -

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isProvinceSelected) {
        if (self.provinceSelectedBlock) {
            NSString *key = [[self.dataDic allKeys] objectAtIndex:indexPath.section];
            NSArray *values = [self.dataDic objectForKey:key];
            self.provinceSelectedBlock([values objectAtIndex:indexPath.row]);
        }
    }else{
        if (self.citySelectedBlock) {
            NSString *key = [[self.dataDic allKeys] objectAtIndex:indexPath.section];
            NSArray *values = [self.dataDic objectForKey:key];
            self.citySelectedBlock([values objectAtIndex:indexPath.row]);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
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
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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
