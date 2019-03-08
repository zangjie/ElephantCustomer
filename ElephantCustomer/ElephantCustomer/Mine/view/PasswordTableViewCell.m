
//
//  PasswordTableViewCell.m
//  ElephantCustomer
//
//  Created by Bge on 2019/3/8.
//  Copyright © 2019 zj. All rights reserved.
//

#import "PasswordTableViewCell.h"
#import <Masonry/Masonry.h>

@interface PasswordTableViewCell () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *passwordTextField;

@end

@implementation PasswordTableViewCell

- (void)setPlaceHolderString:(NSAttributedString *)placeHolderString {
    _placeHolderString = placeHolderString;
    
    [self.passwordTextField setAttributedPlaceholder:placeHolderString];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        self.passwordTextField = [UITextField new];
        [self.passwordTextField setDelegate:self];
        [self.passwordTextField setBorderStyle:UITextBorderStyleNone];
        [self.passwordTextField setSecureTextEntry:YES];
        [self.passwordTextField setAttributedPlaceholder:self.placeHolderString];
        [self.passwordTextField addTarget:self action:@selector(textFieldDidChangeText:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:self.passwordTextField];
        [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(autoScaleW(35));
            make.top.and.bottom.mas_equalTo(0);
            make.centerX.equalTo(self);
        }];
        
        UIView *lineView = [UIView new];
        [lineView setBackgroundColor:lightGrayTextColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(self.passwordTextField);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)textFieldDidChangeText:(id)sender {
    if (self.valueChanged) {
        self.valueChanged(self.passwordTextField.text);
    }
}

@end
