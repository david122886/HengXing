//
//  ForgotPwdViewController.m
//  HengXing
//
//  Created by xxsy-ima001 on 15/6/21.
//  Copyright (c) 2015年 ___xiaoxiangwenxue___. All rights reserved.
//

#import "ForgotPwdViewController.h"
#import "LoginFilter.h"
@interface ForgotPwdViewController ()<UITextFieldDelegate>
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
@property (weak, nonatomic) IBOutlet UIView *verifyPersonInfoView;

@property (nonatomic,assign) NSInteger forgotPwdStep;
#pragma mark -

#pragma mark -
#pragma mark -- 新密码界面
@property (weak, nonatomic) IBOutlet UIView *setupNewPwdView;
@property (weak, nonatomic) IBOutlet UITextField *pwdNewTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePwdNewTextField;

#pragma mark -


#pragma mark -
#pragma mark -- 修改新密码成功界面

@property (weak, nonatomic) IBOutlet UIView *pwdResultView;
#pragma mark -
@end

@implementation ForgotPwdViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.forgotPwdStep = 0;
        // Do any additional setup after loading the view.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITextFieldDelegate
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



-(BOOL)verifyPersonInfoWithAccount:(NSString*)account withUserName:(NSString*)userName withPhoneNumber:(NSString*)phoneNumber{
    __block BOOL verifySuccess = NO;
    [LoginFilter verifyAccount:account withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    if (!verifySuccess) {
        return NO;
    }
    
    [LoginFilter verifyUserName:userName withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    if (!verifySuccess) {
        return NO;
    }
    
    [LoginFilter verifyPhoneNumber:phoneNumber withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];
    
    return verifySuccess;
}


-(BOOL)verifyNewPwdWithPwd:(NSString*)pwd withRePwd:(NSString*)rePwd{
    __block BOOL verifySuccess = NO;
    [LoginFilter verifyPwd:pwd withFinshed:^(BOOL success, NSString *errorMsg) {
        verifySuccess = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }];

    if (!verifySuccess) {
        return NO;
    }
    
    if (!rePwd || [rePwd isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确认密码不为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    if (![pwd isEqualToString:rePwd]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"确认密码和密码不相同" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
    if (self.phoneNumberTextField) {
        return self.phoneNumberTextField;
    }
    if (self.pwdNewTextField.isFirstResponder) {
        return self.pwdNewTextField;
    }
    if (self.rePwdNewTextField.isFirstResponder) {
        return self.rePwdNewTextField;
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
    [self.phoneNumberTextField resignFirstResponder];
    [self.pwdNewTextField resignFirstResponder];
    [self.rePwdNewTextField resignFirstResponder];
}

#pragma mark -
- (IBAction)nextStepClicked:(UIButton *)sender {
    BOOL verify = NO;
    if (self.forgotPwdStep == 2) {
        ///验证步骤完成
        
        return;
    }
    if (self.forgotPwdStep == 0) {
        ///验证用户信息
        verify = [self verifyPersonInfoWithAccount:self.accountTextField.text withUserName:self.nameTextField.text withPhoneNumber:self.phoneNumberTextField.text];
    }else
        if (self.forgotPwdStep == 1) {
            ///输入新密码
            verify = [self verifyNewPwdWithPwd:self.pwdNewTextField.text withRePwd:self.rePwdNewTextField.text];
        }
    
    if (verify) {
        [self backgroundTapGesture:nil];
        self.forgotPwdStep = self.forgotPwdStep +1;
    }
}


#pragma mark -
#pragma mark -- property
-(void)setForgotPwdStep:(NSInteger)forgotPwdStep{
    _forgotPwdStep = forgotPwdStep;
    
    NSMutableAttributedString *nextTipTitleString = [[NSMutableAttributedString alloc] initWithString:@"1. 输入验证信息 > 2. 输入密码 > 3. 修改密码成功" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    switch (forgotPwdStep) {
        case 0:
        {
           [self.nextStepBt setTitle:@"下一步" forState:UIControlStateNormal];
           [nextTipTitleString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:(NSRange){3,6}];
           [self.verifyPersonInfoView setHidden:NO];
           [self.setupNewPwdView setHidden:YES];
           [self.pwdResultView setHidden:YES];
        }
            break;
        case 1:
     {
        [self.nextStepBt setTitle:@"提交新密码" forState:UIControlStateNormal];
        [nextTipTitleString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:(NSRange){15,4}];
        [self.verifyPersonInfoView setHidden:YES];
        [self.setupNewPwdView setHidden:NO];
        [self.pwdResultView setHidden:YES];
     }
            break;
        case 2:
     {
        [self.nextStepBt setTitle:@"确定" forState:UIControlStateNormal];
        [nextTipTitleString addAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:(NSRange){25,6}];
        [self.verifyPersonInfoView setHidden:YES];
        [self.setupNewPwdView setHidden:YES];
        [self.pwdResultView setHidden:NO];
     }
            break;
        default:
            break;
    }
    self.tipStepLabel.attributedText = nextTipTitleString;
}
#pragma mark -
@end
