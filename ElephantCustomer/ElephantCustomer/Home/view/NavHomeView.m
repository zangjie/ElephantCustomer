//
//  NavHomeView.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "NavHomeView.h"
#import <Masonry/Masonry.h>
@interface NavHomeView()
//@property (nonatomic, strong)UILabel *navTitleLable;
//@property (nonatomic, strong)UIButton *navRigthButton;
@end
@implementation NavHomeView
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialControl];
    }
    return self;
}
- (void)initialControl {
    self.navTitleLable = [[UILabel alloc]initWithFrame:CGRectZero];
    self.navTitleLable.textAlignment  = NSTextAlignmentCenter;
    self.navTitleLable.textColor = [UIColor whiteColor];
    self.navTitleLable.font = mFont(18);
    self.navTitleLable.text = @"象与电服";
    [self addSubview:self.navTitleLable];
    [self.navTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(autoScaleW(-10));
        make.width.mas_equalTo(autoScaleW(120));
        make.height.mas_equalTo(autoScaleH(18));
    }];
    
    self.navRigthButton =[UIButton new];
    [self.navRigthButton setTitle:@"签到" forState:(UIControlStateNormal)];
    [self addSubview:self.navRigthButton];
    [self.navRigthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(autoScaleW(-10));
        make.centerY.equalTo(self.navTitleLable);
        make.width.mas_equalTo(40);
    }];
}


@end
