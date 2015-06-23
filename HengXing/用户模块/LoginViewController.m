//
//  LoginViewController.m
//  ShangQingHui
//
//  Created by xxsy-ima001 on 15/5/16.
//  Copyright (c) 2015年 davidliu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginFilter.h"
#import "ServiceManager.h"
#import "MBProgressHUD.h"
#import "DRDropMenuButton.h"

#define kUserNameHistoryFileName @"kUserNameHistoryFile"
@interface LoginViewController()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBackViewTopToSuperViewConstraint;
@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTopSuperViewConstraint;
@property (weak, nonatomic) IBOutlet DRDropMenuButton *dropMenuButton;
@property (weak, nonatomic) IBOutlet UIButton *registerBt;
- (IBAction)registerBtClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *forgotPwdBt;
- (IBAction)fortgotPwdBtClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *autoLoginInBt;
- (IBAction)autoLoginInBtClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *savePwdBt;
- (IBAction)savePwdBtClicked:(UIButton *)sender;

@end

@implementation LoginViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginBt setBackgroundColor:[UIColor colorWithRed:243/255.0 green:120/255.0 blue:71/255.0 alpha:1]];
    UserObj *user = [UserObj unarchive];
    self.userNameField.text = user.userName;
    self.pwdField.text = user.pwd;
    
    __weak typeof(self) weakSelf = self;
    [self.dropMenuButton addDropMenuTopView:self.userNameField insertSuperView:self.view withMaxHeight:200 withShowMenuItemStringArrayBlock:^NSArray *{
        return [weakSelf historyNames];
    } withSelectedItemBlock:^(NSString *itemString) {
        weakSelf.userNameField.text = itemString;
    }];
    
    
    self.registerBt.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"注册" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSBackgroundColorAttributeName:[UIColor clearColor],NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick)}];
    self.forgotPwdBt.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"忘记密码" attributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSBackgroundColorAttributeName:[UIColor clearColor],NSUnderlineStyleAttributeName:@(NSUnderlineStyleThick)}];
    
    [self.forgotPwdBt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [self.registerBt setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)saveUserNameWithName:(NSString*)name{
    NSString *tmp = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!tmp || [tmp isEqualToString:@""]) {
        return;
    }
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSMutableArray *userNames = [NSMutableArray arrayWithContentsOfFile:[path stringByAppendingPathComponent:kUserNameHistoryFileName]];
    if (!userNames) {
        userNames = @[].mutableCopy;
    }
    [userNames addObject:tmp];
    [userNames writeToFile:[path stringByAppendingPathComponent:kUserNameHistoryFileName] atomically:YES];
}

-(NSArray*)historyNames{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return [NSMutableArray arrayWithContentsOfFile:[path stringByAppendingPathComponent:kUserNameHistoryFileName]];
}

#pragma mark -
#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField *field = (UITextField*)[self.view viewWithTag:textField.tag+1];
    [textField resignFirstResponder];
    if (field) {
        [field becomeFirstResponder];
    }else{
//        [textField resignFirstResponder];
        [self beginLoginWithUserName:self.userNameField.text andPwd:self.pwdField.text];
        return YES;
    }
    return NO;
}
#pragma mark -

#pragma mark -- 本地实现方法

-(void)beginLoginWithUserName:(NSString*)userName andPwd:(NSString*)pwd{
    NSLog(@"userName:%@,pwd:%@",userName,pwd);
    [self saveUserNameWithName:userName];
    __block BOOL filter = NO;
    [LoginFilter verifyUserName:userName withFinshed:^(BOOL success, NSString *errorMsg) {
        filter = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
    if (!filter) {
        return;
    }
    [LoginFilter verifyPwd:pwd withFinshed:^(BOOL success, NSString *errorMsg) {
        filter = success;
        if (!success) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:errorMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
    
    if (filter) {
        MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        progress.labelText = @"正在登录...";
        [ServiceManager loginInWithUserName:userName andPwd:pwd withFinishedBlock:^(BOOL success,UserObj *user,NSString *errorMsg) {
            if (success) {
                [UserObj archiveWithUserName:userName withPwd:pwd];
                [progress hide:YES];
                [self loginSuccess];
                
            }else{
                progress.labelText = errorMsg;
                [progress hide:YES afterDelay:1];
                [self loginFailure];
            }
        }];
    }
}

///登录成功
-(void)loginSuccess{
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"] animated:YES];
}
//登陆失败
-(void)loginFailure{
//    [self.pwdField becomeFirstResponder];
    
}
#pragma mark -- 监听键盘弹出事件
-(void)keyboardWillShowNotification:(NSNotification*)notification{
    NSDictionary* userInfo = [notification userInfo];
    UIView *view = self.userNameField.isFirstResponder?self.userNameField:self.pwdField;
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
    [self.userNameField resignFirstResponder];
    [self.pwdField resignFirstResponder];
    [self.dropMenuButton hiddleDropMenuListView];
}

- (IBAction)loginButtonClicked:(id)sender {
    [self beginLoginWithUserName:self.userNameField.text andPwd:self.pwdField.text];
}

- (IBAction)registerBtClicked:(UIButton *)sender {
}
- (IBAction)fortgotPwdBtClicked:(UIButton *)sender {
}
- (IBAction)autoLoginInBtClicked:(UIButton *)sender {
}
- (IBAction)savePwdBtClicked:(UIButton *)sender {
}
@end
