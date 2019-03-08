//
//  LoginViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "CancleRegistViewController.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserModel.h"
@interface LoginViewController ()
@property (nonatomic, strong)UIView *LoginGBView;
@property (nonatomic, strong)NSString *phoneNumber;
@property (nonatomic, strong)NSString *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor =[UIColor whiteColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
     [self CreateLoginView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)CreateLoginView{
    
    self.LoginGBView = [UIView new];
    self.LoginGBView.backgroundColor  = [UIColor whiteColor];
    self.LoginGBView.userInteractionEnabled = YES;
    [self.view addSubview:self.LoginGBView];
    [self.LoginGBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeBackAction)];
    [self.LoginGBView addGestureRecognizer:tap];
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = mFont(18);
    [button setTitle:@"注册" forState:(UIControlStateNormal)];
    [button setTitleColor:darkGrayTextColor forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(regisAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    UILabel *lableLogin = [UILabel new];
    lableLogin.font = mFont(24);
    lableLogin.text = @"登录";
    lableLogin.textColor = darkGrayTextColor;
    [self.LoginGBView addSubview:lableLogin];
    [lableLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginGBView).offset(autoScaleW(35));
        make.top.equalTo(self.LoginGBView).offset(autoScaleH(30));
        make.height.mas_offset(autoScaleW(24));
    }];
    
    UITextField *textIphone = [UITextField new];
    textIphone.textColor = darkGrayTextColor;
    [textIphone addTarget:self action:@selector(textIphoneAction:) forControlEvents:(UIControlEventEditingChanged)];
    textIphone.placeholder = @"手机或企业账号";
    [self.LoginGBView addSubview:textIphone];
    [textIphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginGBView).offset(autoScaleW(35));
        make.right.equalTo(self.LoginGBView).offset(autoScaleW(-35));
        make.height.mas_offset(autoScaleH(50));
        make.top.equalTo(lableLogin).offset(autoScaleH(57+25));
    }];
    UIView *iphoneLine = [UIView new];
    iphoneLine.backgroundColor = lightGrayTextColor;
    [self.LoginGBView addSubview:iphoneLine];
    [iphoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textIphone);
        make.height.mas_offset(0.5f);
        make.top.equalTo(textIphone.mas_bottom);
    }];
    
    UITextField *password = [UITextField new];
    password.secureTextEntry = YES;
    password.textColor = darkGrayTextColor;
    [password addTarget:self action:@selector(passwordAction:) forControlEvents:(UIControlEventEditingChanged)];
    password.placeholder = @"密码";
    [self.LoginGBView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iphoneLine).offset(autoScaleH(25));
        make.left.right.equalTo(textIphone);
        make.height.equalTo(textIphone);
    }];
    UIView *passwordLine= [UIView new];
    passwordLine.backgroundColor = lightGrayTextColor;
    [self.LoginGBView addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(password);
        make.height.mas_offset(0.5f);
        make.top.equalTo(password.mas_bottom);
    }];
    
    UIButton *loginbutton = [UIButton new];
    loginbutton.layer.cornerRadius= 10.f;
    loginbutton.backgroundColor = mainColor;
    [loginbutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginbutton setTitle:@"登录" forState:(UIControlStateNormal)];
    [loginbutton addTarget:self action:@selector(loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.LoginGBView addSubview:loginbutton];
    [loginbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.LoginGBView).offset(autoScaleW(35));
        make.right.equalTo(self.LoginGBView).offset(autoScaleW(-35));
        make.top.equalTo(passwordLine.mas_bottom).offset(autoScaleH(75));
        make.height.mas_offset(autoScaleH(50));
    }];
    
    UIButton *forgetPassword = [UIButton new];
    [forgetPassword setTitleColor:darkGrayTextColor forState:(UIControlStateNormal)];
    [forgetPassword setTitle:@"找回密码" forState:(UIControlStateNormal)];
    [self.LoginGBView addSubview:forgetPassword];
    [forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginbutton.mas_bottom).offset(autoScaleH(25));
        make.centerX.equalTo(loginbutton);
        make.width.mas_offset(autoScaleW(100));
        make.height.mas_offset(autoScaleH(50));
    }];
    
}

-(void)keyboardWillAppear:(NSNotification *)notification{
    [self.LoginGBView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-autoScaleH(25));
    }];
}
-(void)keyboardWillHide:(NSNotification *)notification{
    [self.LoginGBView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
}
-(void)takeBackAction{
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(void)loginAction:(UIButton *)sender{
    [self takeBackAction];
    [SVProgressHUD show];
    [[UserModel sharedInstance] loginWithPhone:self.phoneNumber password:self.password success:^{
        [SVProgressHUD dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YYXY_loginNotification" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
    
    
    
}
//获取手机号
-(void)textIphoneAction:(UITextField*)field{
    self.phoneNumber = field.text;
}

//获取密码
-(void)passwordAction:(UITextField *)field{
    self.password = field.text;
}
-(void)regisAction{
    NSLog(@"注册");
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}


@end
