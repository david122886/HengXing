//
//  DRDropMenuButton.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/18.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "DRDropMenuButton.h"
#define  kMenuItemHeight 40
@interface DRDropMenuButton()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) void (^selectedItemBlock)(NSString *itemString);
@property (nonatomic,strong) NSArray* (^itemStringArrBlock)();
@property (nonatomic,assign) NSInteger maxHeight;
@property (nonatomic,strong) UIView *supersView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) NSArray *dropMenuConstraints;
@property (nonatomic,strong) NSArray *itemArray;
@end
@implementation DRDropMenuButton

-(void)addDropMenuTopView:(UIView*)topView
          insertSuperView:(UIView*)superView
            withMaxHeight:(NSInteger)maxHeight
withShowMenuItemStringArrayBlock:(NSArray* (^)())itemStringArrBlock
    withSelectedItemBlock:(void(^)(NSString *itemString))selectedBlock{
    if (!superView || !topView) {
        return;
    }
    
    self.selected = NO;
    
    self.selectedItemBlock = selectedBlock;
    self.itemStringArrBlock = itemStringArrBlock;
    self.maxHeight = maxHeight;
    self.supersView = superView;
    self.topView = topView;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.layer.cornerRadius = 5;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    
    self.dropMenuConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView][_tableView(==height)]" options:0 metrics:@{@"height":@(0)} views:NSDictionaryOfVariableBindings(_tableView,topView)];
    [superView addConstraints:self.dropMenuConstraints];
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView][_tableView]" options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight metrics:0 views:NSDictionaryOfVariableBindings(_tableView,topView)]];
    
    [self setBackgroundImage:[UIImage imageNamed:@"checkbox1_checked"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"checkbox1_unchecked"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttonClicked{
    
    if (!self.selected) {
        [self showDropMenuListView];
    }else{
        [self hiddleDropMenuListView];
    }
}

-(void)showDropMenuListView{
    self.selected = !self.selected;
    NSArray *items = self.itemStringArrBlock();
    if (!items || items.count <= 0) {
        return;
    }
    [self.supersView removeConstraints:self.dropMenuConstraints];
    self.itemArray = items;
    NSInteger datasHeight = kMenuItemHeight*(items.count + 1) + 2;
    NSInteger height = self.maxHeight < datasHeight ? self.maxHeight:datasHeight;
    self.dropMenuConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topView][_tableView(==height)]" options:0 metrics:@{@"height":@(height)} views:NSDictionaryOfVariableBindings(_tableView,_topView)];
    [self.supersView addConstraints:self.dropMenuConstraints];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.supersView needsUpdateConstraints];
        [self.supersView layoutIfNeeded];
    }];
    [self.tableView reloadData];
}

-(void)hiddleDropMenuListView{
    self.selected = !self.selected;
    [self.supersView removeConstraints:self.dropMenuConstraints];
    
    self.dropMenuConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topView][_tableView(==height)]" options:0 metrics:@{@"height":@(0)} views:NSDictionaryOfVariableBindings(_tableView,_topView)];
    [self.supersView addConstraints:self.dropMenuConstraints];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.supersView needsUpdateConstraints];
        [self.supersView layoutIfNeeded];
    }];
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedItemBlock) {
        self.selectedItemBlock(self.itemArray[indexPath.row]);
    }
    [self hiddleDropMenuListView];
}
#pragma mark --

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.itemArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMenuItemHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
    view.contentView.backgroundColor = [UIColor greenColor];
    return view;
}
#pragma mark --
@end
