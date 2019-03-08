//
//  RegistViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import "RegistViewController.h"
#import <Masonry/Masonry.h>
#import "UserModel.h"
#import "CancleRegistViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface RegistViewController ()
@property (nonatomic, strong)UIView *registView;
@property (nonatomic, strong)NSString *phoneNumber;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUIRegist];
    self.view.backgroundColor = [UIColor whiteColor];
    
}
-(void)createUIRegist{
    UIButton *backButton = [UIButton new];
    [backButton setImage:[UIImage imageNamed:@"regist_back"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightBack = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = rightBack;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    self.registView = [UIView new];
    self.registView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.registView];
    [self.registView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeBackAction)];
    [self.registView addGestureRecognizer:tap];
    
    UILabel *lableTitle = [UILabel new];
    lableTitle.font = mFont(24);
    lableTitle.textColor = darkGrayTextColor;
    lableTitle.text = @"注册象与电服";
    [self.registView addSubview:lableTitle];
    [lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registView).offset(autoScaleW(35));
        make.top.equalTo(self.registView).offset(autoScaleH(35));
        make.height.mas_offset(autoScaleW(25));
    }];
    
    UITextField *textIphone = [UITextField new];
    textIphone.keyboardType = UIKeyboardTypeNumberPad;
//    textIphone.delegate = self;
    [textIphone addTarget:self action:@selector(getCode:) forControlEvents:(UIControlEventEditingChanged)];
    //    textIphone.backgroundColor = [UIColor redColor];
    textIphone.placeholder = @"手机号";
    [self.registView addSubview:textIphone];
    [textIphone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registView).offset(autoScaleW(35));
        make.right.equalTo(self.registView).offset(autoScaleW(-35));
        make.height.mas_offset(autoScaleH(50));
        make.top.equalTo(lableTitle).offset(autoScaleH(57+25));
    }];
    UIView *iphoneLine = [UIView new];
    iphoneLine.backgroundColor = lightGrayTextColor;
    [self.registView addSubview:iphoneLine];
    [iphoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(textIphone);
        make.height.mas_offset(0.5f);
        make.top.equalTo(textIphone.mas_bottom);
    }];
  
    UIButton *buttonProtcol = [UIButton new];
    buttonProtcol.titleLabel.font = mFont(12);
    [buttonProtcol addTarget:self action:@selector(protoclAction) forControlEvents:(UIControlEventTouchUpInside)];
    [buttonProtcol setTitleColor:lightGrayTextColor forState:(UIControlStateNormal)];
    [buttonProtcol addTarget:self action:@selector(webAction) forControlEvents:(UIControlEventTouchUpInside)];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"注册即表示你同意《用户服务及隐私协议》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:darkGrayTextColor
                          range:NSMakeRange(8, 11)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:lightGrayTextColor
                          range:NSMakeRange(0, 8)];
    [buttonProtcol setAttributedTitle:AttributedStr forState:(UIControlStateNormal)];
    [self.registView addSubview:buttonProtcol];
    [buttonProtcol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(textIphone);
        make.top.equalTo(iphoneLine).offset(autoScaleH(38));
        make.height.mas_offset(autoScaleH(12));
    }];
    
    UIButton *loginbutton = [UIButton new];
    loginbutton.titleLabel.font = mFont(15);
    loginbutton.layer.cornerRadius= 5.f;
    loginbutton.backgroundColor = mainColor;
    [loginbutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [loginbutton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [loginbutton addTarget:self action:@selector(loginButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.registView addSubview:loginbutton];
    [loginbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.registView).offset(autoScaleW(35));
        make.right.equalTo(self.registView).offset(autoScaleW(-35));
        make.top.equalTo(buttonProtcol.mas_bottom).offset(autoScaleH(25));
        make.height.mas_offset(autoScaleH(50));
    }];
}
-(void)protoclAction{
    NSLog(@"跳转协议");
}

-(void)takeBackAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)loginButton:(UIButton *)sender{
//    CancleRegistViewController *cancleVC  = [[CancleRegistViewController alloc]init];
//    cancleVC.phoneNumber = self.phoneNumber;
//    [self.navigationController pushViewController:cancleVC  animated:YES];
//    
    [self takeBackAction];
    if(self.phoneNumber.length!=11){
        [SVProgressHUD showErrorWithStatus:@"手机号码格式不对"];
        return;
    };
    [SVProgressHUD show];
    [[UserModel sharedInstance] getCodeWithPhone:self.phoneNumber event:@"df_register" success:^() {
        [SVProgressHUD dismiss];
        CancleRegistViewController *cancleVC  = [[CancleRegistViewController alloc]init];
        cancleVC.phoneNumber = self.phoneNumber;
        [self.navigationController pushViewController:cancleVC  animated:YES];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
-(void)getCode:(UITextField*)textFiled{
    self.phoneNumber = textFiled.text;
}
-(void)webAction{
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
