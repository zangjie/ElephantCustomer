//
//  ModifyPasswordViewController.m
//  ElephantCustomer
//
//  Created by Bge on 2019/3/8.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "PasswordTableViewCell.h"

@interface ModifyPasswordViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *modifyPasswordTableView;
@property (strong, nonatomic) NSString *originPassword;
@property (strong, nonatomic) NSString *nowPassword;
@property (strong, nonatomic) NSString *confirmPassword;
    
@end

@implementation ModifyPasswordViewController

- (NSArray<NSString *> *)placeholderStringArray {
    return @[@"原密码", @"新密码（6-20位数字、字母）", @"确认新密码"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    
    [self initialTableView];
    self.modifyPasswordTableView.tableFooterView = [self tableViewFooterView];
}
    
- (void)initialTableView {
    self.modifyPasswordTableView = [UITableView new];
    [self.modifyPasswordTableView setBackgroundColor:[UIColor whiteColor]];
    [self.modifyPasswordTableView setDelegate:self];
    [self.modifyPasswordTableView setDataSource:self];
    [self.modifyPasswordTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.modifyPasswordTableView];
    [self.modifyPasswordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (UIView *)tableViewFooterView {
    UIView *footerView = [UIView new];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    [footerView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    
    UIButton *commitButton = [UIButton new];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setBackgroundColor:mainColor];
    [commitButton.layer setCornerRadius:10.0f];
    [commitButton.titleLabel setFont:mFont(15)];
    [commitButton addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(autoScaleH(50));
        make.width.mas_equalTo(autoScaleW(305));
        make.height.mas_equalTo(autoScaleW(50));
        make.centerX.equalTo(footerView);
    }];
    
    return footerView;
}

- (void)commit:(id)sender {
    if (![self checkInput]) {
        return;
    }
    
    //TODO
    NSLog(@"%@, %@, %@", self.originPassword, self.nowPassword, self.confirmPassword);
}

- (BOOL)checkInput {
    if (self.originPassword.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"原密码不能为空"];
        return NO;
    }
    
    if (self.nowPassword.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空"];
        return NO;
    }
    
    if (self.nowPassword.length > 20 || self.nowPassword.length < 6) {
        [SVProgressHUD showErrorWithStatus:@"请输入6-20位数字、字母"];
        return NO;
    }
    
    if (self.confirmPassword.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"确认新密码不能为空"];
        return NO;
    }
    
    if (![self.nowPassword isEqualToString:self.confirmPassword]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一致，请重新输入"];
        return NO;
    }
    
    return YES;
}

#pragma mark - UITableView delegate & data source method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseIdentifier = NSStringFromClass([PasswordTableViewCell class]);
    PasswordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[PasswordTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    [cell setPlaceHolderString:[[NSAttributedString alloc] initWithString:[self placeholderStringArray][indexPath.row] attributes:@{NSFontAttributeName: mFont(15), NSForegroundColorAttributeName: UICOLOR_WITH_HEX(0xa2a8b7)}]];
    [cell setValueChanged:^(NSString * _Nonnull text) {
        if (indexPath.row == 0) {
            self.originPassword = text;
        } else if (indexPath.row == 1) {
            self.nowPassword = text;
        } else {
            self.confirmPassword = text;
        }
    }];
    
    return cell;
}

@end
