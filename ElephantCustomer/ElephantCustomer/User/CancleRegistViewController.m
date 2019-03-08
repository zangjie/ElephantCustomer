//
//  CancleRegistViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import "CancleRegistViewController.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserModel.h"
@interface CancleRegistViewController ()
@property(nonatomic, strong)UIView *cancleBGView;
@property(nonatomic, strong)NSString *codeString;
@property(nonatomic, strong)NSString *password;
@end

@implementation CancleRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUICancle];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    UIButton *backButton = [UIButton new];
    [backButton setImage:[UIImage imageNamed:@"regist_back"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *rightBack = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = rightBack;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}
-(void)createUICancle{
    self.cancleBGView = [UIView new];
    self.cancleBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cancleBGView];
    [self.cancleBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(takeBackAction)];
    [self.cancleBGView addGestureRecognizer:tap];
    
    UILabel *cancleLable = [UILabel new];
    cancleLable.text = @"完成注册";
    cancleLable.font = mFont(24);
    cancleLable.textColor = darkGrayTextColor;
    [self.cancleBGView addSubview:cancleLable];
    [cancleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancleBGView).offset(autoScaleW(35));
        make.top.equalTo(self.cancleBGView).offset(autoScaleH(35));
        make.height.mas_offset(autoScaleW(24));
    }];
    
    UILabel *lablePhone = [UILabel new];
    lablePhone.textColor = lightGrayTextColor;
    lablePhone.text = [NSString stringWithFormat:@"验证码已经发送至%@",self.phoneNumber];
    lablePhone.font = mFont(12);
    [self.cancleBGView addSubview:lablePhone];
    [lablePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cancleLable);
        make.top.equalTo(cancleLable.mas_bottom).offset(autoScaleH(25));
        make.height.mas_offset(autoScaleW(12));
    }];
    
    UITextField *filedCode = [UITextField new];
    [filedCode addTarget:self action:@selector(codeGetAction:) forControlEvents:(UIControlEventEditingChanged)];
    filedCode.keyboardType = UIKeyboardTypeNumberPad;
    filedCode.placeholder = @"验证码";
    filedCode.textColor = darkGrayTextColor;
    [self.cancleBGView addSubview:filedCode];
    [filedCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancleBGView).offset(autoScaleW(35));
        make.right.equalTo(self.cancleBGView).offset(autoScaleW(-35));
        make.height.mas_offset(autoScaleH(50));
        make.top.equalTo(lablePhone).offset(autoScaleH(25));
    }];
    UIView *iphoneLine = [UIView new];
    iphoneLine.backgroundColor = lightGrayTextColor;
    [self.cancleBGView addSubview:iphoneLine];
    [iphoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(filedCode);
        make.height.mas_offset(0.5f);
        make.top.equalTo(filedCode.mas_bottom);
    }];
    
    UITextField *password = [UITextField new];
    [password addTarget:self action:@selector(passwordGetAction:) forControlEvents:(UIControlEventEditingChanged)];
    password.placeholder = @"密码";
    [self.cancleBGView addSubview:password];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iphoneLine).offset(autoScaleH(25));
        make.left.right.equalTo(filedCode);
        make.height.equalTo(filedCode);
    }];
    UIView *passwordLine= [UIView new];
    passwordLine.backgroundColor = lightGrayTextColor;
    [self.cancleBGView addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(password);
        make.height.mas_offset(0.5f);
        make.top.equalTo(password.mas_bottom);
    }];
    
    UIButton *regisButton = [UIButton new];
    regisButton.titleLabel.font = mFont(15);
    regisButton.layer.cornerRadius= 5.f;
    regisButton.backgroundColor = mainColor;
    [regisButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [regisButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [regisButton addTarget:self action:@selector(rgistButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.cancleBGView addSubview:regisButton];
    [regisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancleBGView).offset(autoScaleW(35));
        make.right.equalTo(self.cancleBGView).offset(autoScaleW(-35));
        make.top.equalTo(passwordLine.mas_bottom).offset(autoScaleH(75));
        make.height.mas_offset(autoScaleH(50));
    }];
    
    UIButton *forgetPassword = [UIButton new];
    [forgetPassword setTitleColor:darkGrayTextColor forState:(UIControlStateNormal)];
    [forgetPassword setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [forgetPassword addTarget:self  action:@selector(codeSendAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.cancleBGView addSubview:forgetPassword];
    [forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(regisButton.mas_bottom).offset(autoScaleH(25));
        make.centerX.equalTo(regisButton);
        make.width.mas_offset(autoScaleW(100));
        make.height.mas_offset(autoScaleH(50));
    }];
    //k计时器
    [self sendCodeTime:forgetPassword];
}
-(void)passwordGetAction:(UITextField*)field{
    self.password = field.text;
}
-(void)codeGetAction:(UITextField *)field{
       self.codeString = field.text;
}
- (BOOL)inputShouldLetterOrNum:(NSString *)inputString {
    if (inputString.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:inputString];
}
//键盘弹出网上平移
-(void)keyboardWillAppear:(NSNotification *)notification{
//    CGRect keyBoardRect=[notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyBoardHeight = keyBoardRect.size.height;
    [self.cancleBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-autoScaleH(25));
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [self.cancleBGView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
}
-(void)codeSendAction:(UIButton *)sender{
    [[UserModel sharedInstance] getCodeWithPhone:self.phoneNumber event:@"df_register" success:^() {
        [self sendCodeTime:sender];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
-(void)sendCodeTime:(UIButton *)button{
    __block int timeout=9; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=1){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                button.enabled = YES;
                [button setTitle:@"获取验证码" forState:(UIControlStateNormal)];
                button.titleLabel.font = mFont(15);
                [button setTitleColor:darkGrayTextColor forState:(UIControlStateNormal)];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                button.enabled = NO;
                [button setTitle:[NSString stringWithFormat:@"%d秒后重新获取",timeout] forState:(UIControlStateNormal)];
                button.titleLabel.font = mFont(12);
                [button setTitleColor:lightGrayTextColor forState:(UIControlStateNormal)];
                timeout--;
            });
        }
    });
    dispatch_resume(_timer);
}

-(void)takeBackAction{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

-(void)rgistButton{
    NSLog(@"注册");
    
    if (![self inputShouldLetterOrNum:self.password] && self.password.length > 0) {
        [SVProgressHUD showErrorWithStatus:@"只能是数字或者字母!"];
        
        return;
    }
    if(self.password.length<6){
        [SVProgressHUD showErrorWithStatus:@"长度必须大于6位"];
        return;
    }
    if(self.password.length>20){
        [SVProgressHUD showErrorWithStatus:@"长度必须小于20位"];
        return;
    }
    [SVProgressHUD show];
    [[UserModel sharedInstance] registWithPhone:self.phoneNumber captcha:self.codeString password:self.password success:^{
        [SVProgressHUD dismiss];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
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
