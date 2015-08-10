//
//  ForgotPwdViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/21.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginFilter.h"
#import "BrandTableViewController.h"
#import "AddressTableViewController.h"
#import "RegisterFilter.h"
#define kCitySegue @"citySegue"
#define kProvinceSegue @"proviceSegue"
#define kRegisterSegue @"registerSegue"

@interface RegisterViewController ()<UITextFieldDelegate>
#pragma mark -
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBackViewTopToSuperViewConstraint;
#pragma mark -- 验证用户身份模块
@property (weak, nonatomic) IBOutlet UILabel *tipStepLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBt;
- (IBAction)nextStepClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *registerPersonInfoView;

@property (nonatomic,assign) NSInteger registerPersonInfoStep;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
///品牌
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
///省份
@property (weak, nonatomic) IBOutlet UIButton *provinceBt;
@property (weak, nonatomic) IBOutlet UIButton *cityBt;
- (IBAction)provinceBtClicked:(UIButton *)sender;
- (IBAction)cityBtClicked:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *agreementBt;
- (IBAction)agreementBtClicked:(UIButton *)sender;
- (IBAction)agreementLinkBtClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *agreementLinkBt;
#pragma mark -

#pragma mark -
#pragma mark -- 激活验证码界面
@property (weak, nonatomic) IBOutlet UIView *securityCodeView;
@property (weak, nonatomic) IBOutlet UITextField *securityCodeTextField;

@property (weak, nonatomic) IBOutlet UITextField *rePwdNewTextField;

#pragma mark -


#pragma mark -
#pragma mark -- 注册成功界面

@property (weak, nonatomic) IBOutlet UIView *registerResultView;
#pragma mark -

#pragma mark -
#pragma mark -- 本地数据
@property (nonatomic,strong) NSString *provinceString;
@property (nonatomic,strong) NSString *cityString;
@property (nonatomic,strong) NSArray *brandsArray;
@property (nonatomic,strong) void (^selectedProvinceBlock)(NSString *province);
@property (nonatomic,strong) void (^selectedCityBlock)(NSString *city);
@property (nonatomic,strong) void (^selectedBrandBlock)(NSArray *brandsArray);
#pragma mark -
@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.provinceBt setTitle:self.provinceString?:@"省份" forState:UIControlStateNormal];
    [self.cityBt setUserInteractionEnabled:self.provinceString];
    [self.cityBt setTitle:self.cityString?:@"城市" forState:UIControlStateNormal];
    [self.cityBt setTitleColor:self.provinceString?[UIColor blueColor]:[UIColor lightGrayColor] forState:UIControlStateNormal];
    __block NSString *brandString = nil;
    [self.brandsArray enumerateObjectsUsingBlock:^(NSString *brand, NSUInteger idx, BOOL *stop) {
        brandString = brandString?[NSString stringWithFormat:@"%@,%@",brandString,brand]:brand;
    }];
    self.brandTextField.text = brandString;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerPersonInfoStep = 0;
    [self.agreementBt setImage:[UIImage imageNamed:@"checkbox1_checked"] forState:UIControlStateSelected];
    [self.agreementBt setImage:[UIImage imageNamed:@"checkbox1_unchecked"] forState:UIControlStateNormal];
    NSAttributedString *agreementLinkString = [[NSAttributedString alloc] initWithString:@"恒星电源用户协议" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick)}];
    self.agreementLinkBt.titleLabel.attributedText = agreementLinkString;
    
    [self brandAndAddressSelectedBlock];
    // Do any additional setup after loading the view.
}

-(void)brandAndAddressSelectedBlock{
    __weak typeof(self) weakSelf = self;
    self.selectedProvinceBlock = ^(NSString *province){
        weakSelf.provinceString = province;
    };
    self.selectedCityBlock = ^(NSString *city){
        weakSelf.cityString = city;
    };
    self.selectedBrandBlock = ^(NSArray *brands){
        weakSelf.brandsArray = [NSArray arrayWithArray:brands];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.brandTextField) {
        ///选择品牌
        BrandTableViewController *brandVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BrandTableViewController"];
        brandVC.brandsSelectedBlock = self.selectedBrandBlock;
        [brandVC showBrandsWithSelectedBrands:self.brandsArray];
        
        [self backgroundTapGesture:nil];
        [self.navigationController pushViewController:brandVC animated:YES];
        return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    UITextField *field = (UITextField*)[self.view viewWithTag:textField.tag+1];
    [textField resignFirstResponder];
    if (field) {
        [field becomeFirstResponder];
    }else{
        return YES;
    }
    return NO;
}
#pragma mark -


#pragma mark -- 本地实现方法



-(BOOL)verifyPersonInfoWithAccount:(NSString*)account
                      withUserName:(NSString*)userName
                   withPhoneNumber:(NSString*)phoneNumber
                           withPwd:(NSString*)pwd
                      withProvince:(NSString*)province
                          withCity:(NSString*)city
                        withBrands:(NSArray*)brands
                   withIsAgreeMent:(BOOL)agreement{
    __block BOOL verifySuccess = NO;
    [RegisterFilter verifyAccount:account withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    if (!verifySuccess) {
        return NO;
    }
    
    [RegisterFilter verifyUserName:userName withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    if (!verifySuccess) {
        return NO;
    }
    
    
    [RegisterFilter verifyPwd:pwd withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    if (!verifySuccess) {
        return NO;
    }
    
    [RegisterFilter verifyPhoneNumber:phoneNumber withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    if (!verifySuccess) {
        return NO;
    }
    
    if (!self.provinceString) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择省份" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
//    if (!self.cityString) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择城市" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//        return NO;
//    }
    
    
    if (self.brandsArray.count <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请选择您的代理品牌" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    if (!self.agreementBt.isSelected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"请阅读并接受《恒星电源用户协议》" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    return verifySuccess;
}


-(BOOL)verifySecurityCode:(NSString*)securityCode{
    if (!securityCode || [[securityCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"验证码不为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    return YES;
}

#pragma mark -- 监听键盘弹出事件

-(UIView*)getFirstResponderView{
    if (self.accountTextField.isFirstResponder) {
        return self.accountTextField;
    }
    if (self.nameTextField.isFirstResponder) {
        return self.nameTextField;
    }
    if (self.pwdTextField.isFirstResponder) {
        return self.pwdTextField;
    }
    if (self.phoneNumberTextField) {
        return self.phoneNumberTextField;
    }
    if (self.brandTextField.isFirstResponder) {
        return self.brandTextField;
    }
    return nil;
}

-(void)keyboardWillShowNotification:(NSNotification*)notification{
    NSDictionary* userInfo = [notification userInfo];
    UIView *view = [self getFirstResponderView];
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    CGRect newFrame = [self.view convertRect:view.frame toView:nil];
    CGRect keyboardFrame = [self.view convertRect:keyboardEndFrame toView:nil];
    CGFloat height = CGRectGetMinY(keyboardFrame) - CGRectGetMaxY(newFrame);
    if (height < 50) {
        self.loginBackViewTopToSuperViewConstraint.constant = height-50;
        // Animate up or down
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        [UIView setAnimationCurve:animationCurve];
        
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
        
        [UIView commitAnimations];
    }
    
}

-(void)keyboardWillHideNotification:(NSNotification*)notification{
    NSDictionary* userInfo = [notification userInfo];
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    self.loginBackViewTopToSuperViewConstraint.constant = 0;
    // Animate up or down
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}


- (IBAction)backgroundTapGesture:(UITapGestureRecognizer *)sender {
    [self.accountTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
    [self.brandTextField resignFirstResponder];
}

#pragma mark -
- (IBAction)nextStepClicked:(UIButton *)sender {
    BOOL verify = NO;
    if (self.registerPersonInfoStep == 2) {
        ///注册步骤完成
        
        return;
    }
    if (self.registerPersonInfoStep == 0) {
        ///验证用户信息
        verify = [self verifyPersonInfoWithAccount:self.accountTextField.text withUserName:self.nameTextField.text withPhoneNumber:self.phoneNumberTextField.text withPwd:self.pwdTextField.text withProvince:self.provinceString withCity:self.cityString withBrands:self.brandsArray withIsAgreeMent:self.agreementBt.isSelected];
        
        self.securityCodeTextField.text = @"12096";///测试数据
    }else
        if (self.registerPersonInfoStep == 1) {
            ///激活
            verify = [self verifySecurityCode:self.securityCodeTextField.text];
        }
    
    if (verify) {
        [self backgroundTapGesture:nil];
        self.registerPersonInfoStep = self.registerPersonInfoStep +1;
    }
}


#pragma mark -
#pragma mark -- property
-(void)setRegisterPersonInfoStep:(NSInteger)registerPersonInfoStep{
    _registerPersonInfoStep = registerPersonInfoStep;
    
    NSMutableAttributedString *nextTipTitleString = [[NSMutableAttributedString alloc] initWithString:@"1. 输入注册信息 > 2. 输入激活码 > 3. 注册成功" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    switch (registerPersonInfoStep) {
        case 0:
     {
        [self.nextStepBt setTitle:@"注册" forState:UIControlStateNormal];
        [nextTipTitleString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:(NSRange){3,6}];
        [self.securityCodeView setHidden:YES];
        [self.registerResultView setHidden:YES];
        [self.registerPersonInfoView setHidden:NO];
        [self.agreementBt setHidden:NO];
        [self.agreementLinkBt setHidden:NO];
     }
            break;
        case 1:
     {
        [self.nextStepBt setTitle:@"激活" forState:UIControlStateNormal];
        [nextTipTitleString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:(NSRange){15,5}];
        [self.securityCodeView setHidden:NO];
        [self.registerResultView setHidden:YES];
        [self.registerPersonInfoView setHidden:YES];
        [self.agreementBt setHidden:YES];
        [self.agreementLinkBt setHidden:YES];
     }
            break;
        case 2:
     {
        [self.nextStepBt setTitle:@"确定" forState:UIControlStateNormal];
        [nextTipTitleString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:(NSRange){26,4}];
        [self.securityCodeView setHidden:YES];
        [self.registerResultView setHidden:NO];
        [self.registerPersonInfoView setHidden:YES];
        [self.agreementBt setHidden:YES];
        [self.agreementLinkBt setHidden:YES];
     }
            break;
        default:
            break;
    }
    self.tipStepLabel.attributedText = nextTipTitleString;
}

#pragma mark -
- (IBAction)provinceBtClicked:(UIButton *)sender {
}

- (IBAction)cityBtClicked:(UIButton *)sender {
}
- (IBAction)agreementBtClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)agreementLinkBtClicked:(UIButton *)sender {
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    __weak typeof(self) weakSelf = self;
    [self backgroundTapGesture:nil];
    AddressTableViewController *addressVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:kProvinceSegue]) {
        addressVC.provinceSelectedBlock = weakSelf.selectedProvinceBlock;
        [addressVC showProvince];
    }
    if ([segue.identifier isEqualToString:kCitySegue]) {
        addressVC.citySelectedBlock = weakSelf.selectedCityBlock;
        [addressVC showCitysForProvinceName:weakSelf.provinceString];
    }
}
@end
