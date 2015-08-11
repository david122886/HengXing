//
//  LMContainerVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "LMContainerVC.h"

@interface LMContainerVC () {
    BOOL _isSalesMan;  //是业务员.  否则为维修主管. 二者显示的页面不同
    BOOL _leftTabSelected; //选中第一页
    UIViewController *_leftViewController;
    UIViewController *_rightViewController;
}
@property (weak, nonatomic) IBOutlet UIButton *leftTabButton;
@property (weak, nonatomic) IBOutlet UIButton *rightTabButton;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation LMContainerVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    LMContainerVC *tvc = [story instantiateViewControllerWithIdentifier:@"LMContainerVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isSalesMan = NO;
    [self _initView];
    _leftTabSelected = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)_initView {
    self.title = @"物流管理";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    [_leftTabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_leftTabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_leftTabButton setBackgroundImage:[UIImage imageNamed:@"LMTab_btn_highlight.png"] forState:UIControlStateSelected];
    [_leftTabButton setBackgroundImage:[UIImage imageNamed:@"LMTab_btn_normal.png"] forState:UIControlStateNormal];
    [_leftTabButton addTarget:self action:@selector(clickAtLeftButton:) forControlEvents:UIControlEventTouchUpInside];
    _leftTabButton.selected = YES;
    
    [_rightTabButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_rightTabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_rightTabButton setBackgroundImage:[UIImage imageNamed:@"LMTab_btn_highlight.png"] forState:UIControlStateSelected];
    [_rightTabButton setBackgroundImage:[UIImage imageNamed:@"LMTab_btn_normal.png"] forState:UIControlStateNormal];
    [_rightTabButton addTarget:self action:@selector(clickAtRightButton:) forControlEvents:UIControlEventTouchUpInside];
    _rightTabButton.selected = NO;
    
    _containerView.layer.borderWidth = 1.;
    _containerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIStoryboard *story = self.storyboard;
    if (_isSalesMan) { //业务员界面
        [_leftTabButton setTitle:@"您发出的故障电池" forState:UIControlStateNormal];
        [_rightTabButton setTitle:@"等待您签收的补赔电池" forState:UIControlStateNormal];
        _leftViewController = [story instantiateViewControllerWithIdentifier:@"LMListSendBySalesmanTVC"]; //您发出的故障电池
        _rightViewController = [story instantiateViewControllerWithIdentifier:@"LMListWaitSalesmanSignTVC"]; //等待您签收的补偿电池
    } else {   //维修主管界面
        [_leftTabButton setTitle:@"签收客诉电池" forState:UIControlStateNormal];
        [_rightTabButton setTitle:@"等待补赔电池" forState:UIControlStateNormal];
        _leftViewController = [story instantiateViewControllerWithIdentifier:@"LMListSignedByManagerTVC"]; //签收客诉电池
        _rightViewController = [story instantiateViewControllerWithIdentifier:@"LMListWaitManagerCompensateTVC"]; //等待补偿电池
    }
    [_leftViewController willMoveToParentViewController:self];
    [self addChildViewController:_leftViewController];
    [_leftViewController didMoveToParentViewController:self];
    [_containerView addSubview:_leftViewController.view];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:nil views:@{@"subView":_leftViewController.view}]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:@{@"subView":_leftViewController.view}]];
    _leftViewController.view.hidden = NO;
    
    NSLog(@"containerFrame:%@", NSStringFromCGRect(_containerView.frame));
    
    [_rightViewController willMoveToParentViewController:self];
    [self addChildViewController:_rightViewController];
    [_rightViewController didMoveToParentViewController:self];
    [_containerView addSubview:_rightViewController.view];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:nil views:@{@"subView":_rightViewController.view}]];
    [_containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:nil views:@{@"subView":_rightViewController.view}]];
    _rightViewController.view.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark user Interactions
- (void)clickAtLeftButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _leftTabSelected = sender.selected;
    _rightTabButton.selected = !sender.selected;
    
    _leftViewController.view.hidden = !_leftTabSelected;
    _rightViewController.view.hidden = _leftTabSelected;
}

- (void)clickAtRightButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _leftTabSelected = !sender.selected;
    _leftTabButton.selected = !sender.selected;
    
    _leftViewController.view.hidden = !_leftTabSelected;
    _rightViewController.view.hidden = _leftTabSelected;
}
@end
