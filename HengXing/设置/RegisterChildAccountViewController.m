//
//  ForgotPwdViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/21.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "RegisterChildAccountViewController.h"
#import "LoginFilter.h"
#import "BrandTableViewController.h"
#import "AddressTableViewController.h"
#import "RegisterFilter.h"
#define kCitySegue @"citySegue"
#define kProvinceSegue @"proviceSegue"
#define kRegisterSegue @"registerSegue"

@interface RegisterChildAccountViewController ()<UITextFieldDelegate>
#pragma mark -
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBackViewTopToSuperViewConstraint;
#pragma mark -- 验证用户身份模块
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBt;
- (IBAction)nextStepClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *registerPersonInfoView;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
///省份
@property (weak, nonatomic) IBOutlet UIButton *provinceBt;
@property (weak, nonatomic) IBOutlet UIButton *cityBt;
- (IBAction)provinceBtClicked:(UIButton *)sender;
- (IBAction)cityBtClicked:(UIButton *)sender;

#pragma mark -

#pragma mark -
#pragma mark -- 本地数据
@property (nonatomic,strong) NSString *provinceString;
@property (nonatomic,strong) NSString *cityString;
@property (nonatomic,strong) void (^selectedProvinceBlock)(NSString *province);
@property (nonatomic,strong) void (^selectedCityBlock)(NSString *city);
#pragma mark -
@end

@implementation RegisterChildAccountViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self.provinceBt setTitle:self.provinceString?:@"省份" forState:UIControlStateNormal];
    [self.cityBt setUserInteractionEnabled:self.provinceString];
    [self.cityBt setTitle:self.cityString?:@"城市" forState:UIControlStateNormal];
    [self.cityBt setTitleColor:self.provinceString?[UIColor blueColor]:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

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
                          withCity:(NSString*)city{
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
}

#pragma mark -
- (IBAction)nextStepClicked:(UIButton *)sender {
    BOOL verify = NO;
    ///验证用户信息
    verify = [self verifyPersonInfoWithAccount:self.accountTextField.text withUserName:self.nameTextField.text withPhoneNumber:self.phoneNumberTextField.text withPwd:self.pwdTextField.text withProvince:self.provinceString withCity:self.cityString];
    if (verify) {
        [self backgroundTapGesture:nil];
    }
}

#pragma mark -
- (IBAction)provinceBtClicked:(UIButton *)sender {
}

- (IBAction)cityBtClicked:(UIButton *)sender {
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
