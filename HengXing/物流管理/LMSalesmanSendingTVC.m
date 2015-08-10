//
//  LMSalesmanSendingVC.m
//  HengXing
//
//  Created by 李宏亮 on 15/7/8.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "LMSalesmanSendingTVC.h"

@interface LMSalesmanSendingTVC ()
@property (weak, nonatomic) IBOutlet UILabel *officeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *mailNOLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UITextField *quantityField;
@property (weak, nonatomic) IBOutlet UITextField *logisticsCompanyLabel;
@property (weak, nonatomic) IBOutlet UITextField *trackNOLabel;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)clickAtScan:(UIButton *)sender;
- (IBAction)clickAtConfirm:(UIButton *)sender;

@end

@implementation LMSalesmanSendingTVC
+ (void)show:(UINavigationController *)nvc {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"LogisticsManage" bundle:nil];
    LMSalesmanSendingTVC *tvc = [story instantiateViewControllerWithIdentifier:@"LMSalesmanSendingTVC"];
    [nvc pushViewController:tvc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
}

- (void)_initView {
    self.title = @"返厂电池发货";
    _scanButton.layer.cornerRadius = 6.;
    _confirmButton.layer.cornerRadius = 6.;
    _officeNameLabel.attributedText = [LMSalesmanSendingTVC attriStringWithTitle:@"名称:"
                                                                         content:@"苏州客服中心"
                                                               contentAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    _addressLabel.attributedText = [LMSalesmanSendingTVC attriStringWithTitle:@"地址:"
                                                                         content:@"苏州市高新区金沙路181号"
                                                               contentAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    _telephoneLabel.attributedText = [LMSalesmanSendingTVC attriStringWithTitle:@"电话:"
                                                                         content:@"0512-80801221"
                                                               contentAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    _mailNOLabel.attributedText = [LMSalesmanSendingTVC attriStringWithTitle:@"邮编:"
                                                                         content:@"215800"
                                                               contentAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
    _contactLabel.attributedText = [LMSalesmanSendingTVC attriStringWithTitle:@"联系人:"
                                                                         content:@"苏州星恒"
                                                               contentAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//字符串处理
+ (NSMutableAttributedString *)attriStringWithTitle:(NSString *)title content:(NSString *)content contentAttributes:(NSDictionary *)attributes {
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", title, content]];
    if (content.length > 0) {
        NSRange contentRange = NSMakeRange(attriString.length - content.length, content.length);
        [attriString setAttributes:attributes range:contentRange];
    }
    return attriString;
}

#pragma mark user Interactions
//扫描单号
- (IBAction)clickAtScan:(UIButton *)sender {
    
}

//确认返厂
- (IBAction)clickAtConfirm:(UIButton *)sender {
    
}
@end
