//
//  MineHeadView.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineHeadView.h"
#import <Masonry/Masonry.h>
#import "UserModel.h"
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MineHeadView()

@end
@implementation MineHeadView
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialControl];
    }
    return self;
}
-(void)initialControl{
    MineInfo *model = [UserModel sharedInstance].mineInfo;
    //可变形的view
    self.backKView = [UIView new];
    self.backKView.clipsToBounds = YES;
    self.backKView.backgroundColor = backgroundGrayColor;
    [self addSubview:self.backKView];
    [self.backKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_offset(autoScaleH(170));
    }];
    
    
    self.imagHeadIcon = [UIImageView new];
    [self.imagHeadIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"place_holdImage_B"]];
    self.imagHeadIcon.contentMode = UIViewContentModeScaleAspectFit;
    self.imagHeadIcon.clipsToBounds = YES;
    self.imagHeadIcon.layer.cornerRadius = autoScaleW(60)/2.f;
    [self addSubview:self.imagHeadIcon];
    [self.imagHeadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(self).offset(autoScaleH(25));
        make.height.width.mas_offset(autoScaleW(60));
    }];
    
    self.lableNiceName = [UILabel new];
    self.lableNiceName.font = mFont(18);
    self.lableNiceName.textColor = darkGrayTextColor;
    self.lableNiceName.text = model.typetxt;
    [self addSubview:self.lableNiceName];
    [self.lableNiceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(autoScaleH(36));
        make.left.equalTo(self.imagHeadIcon.mas_right).offset(autoScaleH(23));
        make.height.mas_offset(autoScaleW(18));
    }];
    
    self.lablePhone = [UILabel new];
    self.lablePhone.font = mFont(12);
    self.lablePhone.textColor = lightGrayTextColor;
    self.lablePhone.text = model.account;
    [self addSubview:self.lablePhone];
    [self.lablePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableNiceName);
        make.top.equalTo(self.lableNiceName.mas_bottom).offset(autoScaleH(10));
        make.height.mas_offset(autoScaleW(12));
    }];
    
    UIButton *buttonBaseInfo = [UIButton new];
    [buttonBaseInfo addTarget:self action:@selector(buttonInfoBaseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:buttonBaseInfo];
    [buttonBaseInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.imagHeadIcon);
        make.right.equalTo(self.lablePhone);
    }];
    
    self.buttonSign = [UIButton new];
    self.buttonSign.titleLabel.font = mFont(15);
    self.buttonSign.backgroundColor = backgroundGrayColor;
    [self.buttonSign setTitle:@"已签到" forState:(UIControlStateSelected)];
    [self.buttonSign setTitleColor:lightGrayTextColor forState:(UIControlStateNormal)];
    [self.buttonSign setTitle:@"签到" forState:(UIControlStateNormal)];
    [self.buttonSign setTitleColor:mainColor forState:(UIControlStateNormal)];
    self.buttonSign.layer.borderWidth=0.5f;
    self.buttonSign.layer.borderColor = [model.signin isEqualToString:@"0"]?mainColor.CGColor:lightGrayTextColor.CGColor;
    self.buttonSign.selected = [model.signin isEqualToString:@"0"]?NO:YES;
    self.buttonSign.layer.cornerRadius = 5.f;
    [self addSubview:self.buttonSign];
    [self.buttonSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(autoScaleW(-10));
        make.top.equalTo(self).offset(autoScaleH(37));
        make.width.mas_offset(autoScaleW(80));
        make.height.mas_offset(autoScaleH(35));
    }];
    
    UIView *viewBG  = [UIView new];
    viewBG.backgroundColor = darkGrayTextColor;
    viewBG.layer.cornerRadius = 15.f;
    [self.backKView addSubview:viewBG];
    [viewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagHeadIcon);
        make.right.equalTo(self.buttonSign);
        make.bottom.equalTo(self.mas_bottom).offset(autoScaleH(15));
        make.height.mas_offset(autoScaleH(65));
    }];
//    mine_vip.imageset
//    mine_jiantou.imageset
    UIImageView *imageJ = [UIImageView new];
    imageJ.image = [UIImage imageNamed:@"mine_vip"];
    [viewBG addSubview:imageJ];
    [imageJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBG).offset(autoScaleW(10));
        make.centerY.equalTo(viewBG).offset(autoScaleH(-8));
        make.width.height.mas_offset(autoScaleW(15));
    }];
    self.lableRelation = [UILabel new];
    self.lableRelation.text = model.relation;
    self.lableRelation.textColor = [UIColor whiteColor];
    self.lableRelation.font = mFont(15);
    [viewBG addSubview:self.lableRelation];
    [self.lableRelation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageJ.mas_right).offset(autoScaleW(10));
        make.centerY.equalTo(imageJ);
        make.height.mas_offset(autoScaleW(15));
    }];

    UIButton *moreButton = [UIButton new];
    [moreButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    moreButton.titleLabel.font = mFont(15);
    [moreButton setTitle:@"查看" forState:(UIControlStateNormal)];
    [moreButton setImage:[UIImage imageNamed:@"mine_jiantou"] forState:(UIControlStateNormal)];
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, autoScaleW(50), 0, 0)];
    [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0,0,autoScaleW(10))];
    [self addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-autoScaleH(20));
        make.centerY.equalTo(self.lableRelation);
        make.height.mas_equalTo(autoScaleW(16));
        make.width.mas_equalTo(autoScaleW(60));
    }];
}

-(void)buttonInfoBaseAction:(UIButton *)sender{
    NSLog(@"%@",sender);
    if(self.mineBaseInfoVC){
        self.mineBaseInfoVC();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
