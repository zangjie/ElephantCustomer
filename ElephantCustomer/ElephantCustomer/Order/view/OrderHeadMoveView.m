//
//  OrderHeadMoveView.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderHeadMoveView.h"
#import <Masonry/Masonry.h>
@implementation OrderHeadMoveView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        [self createUIFromHead];
    }
    return self;
}
-(void)createUIFromHead{
    NSArray *ArrayTitle= @[@"全部",@"待确认",@"待上门",@"待完工",@"待付款"];
    float BLwidth=(mScreenWidth-autoScaleW(20))/5.f;
    for (int i = 0; i<5; i++) {
        UIButton *buttonTitle = [UIButton new];
        buttonTitle.tag = 1000+i;
        buttonTitle.titleLabel.textAlignment = NSTextAlignmentCenter;
        [buttonTitle setTitle:ArrayTitle[i] forState:(UIControlStateNormal)];
        [buttonTitle setTitleColor:darkGrayTextColor forState:(UIControlStateNormal)];
        [buttonTitle setTitleColor:mainColor forState:(UIControlStateSelected)];
        buttonTitle.titleLabel.font = mFont(15);
        [self addSubview:buttonTitle];
        [buttonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(autoScaleW(10)+i*BLwidth);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_offset(BLwidth);
        }];
    }
    self.greenLineView = [UIView new];
    self.greenLineView.backgroundColor = mainColor;
    [self addSubview:self.greenLineView];
    [self.greenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.bottom.equalTo(self).offset(-0.5);
        make.height.mas_offset(autoScaleH(4));
        make.width.mas_offset(BLwidth);
    }];
    UIView *lineView = [UIView new];
    lineView.alpha = 0.5f;
    lineView.backgroundColor = lightGrayTextColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_offset(0.5);
    }];
    
}
-(void)changeColorWithIndex:(int)index{
    for (int i = 0; i<5; i++) {
        UIButton *button = [self viewWithTag:1000+i];
        button.selected=NO;
    }
    UIButton *button = [self viewWithTag:1000+index];
    button.selected = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
