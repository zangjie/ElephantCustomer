//
//  SerivceTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "SerivceTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation SerivceTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style
                  reuseIdentifier:reuseIdentifier]){
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    UIView *viewline = [UIView new];
    viewline.backgroundColor  = mainColor;
    [self addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(self).offset(autoScaleH(25));
        make.width.mas_equalTo(autoScaleW(5));
        make.height.mas_equalTo(autoScaleW(18));
    }];
    self.lableTitle  = [UILabel new];
    self.lableTitle.font = [UIFont boldSystemFontOfSize:autoScaleW(18)];
    [self addSubview:self.lableTitle];
    [self.lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewline).offset(autoScaleH(10));
        make.top.equalTo(viewline);
        make.bottom.equalTo(viewline);
    }];
    
    self.moreButton = [UIButton new];
    [self.moreButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    self.moreButton.titleLabel.font = mFont(15);
    [self.moreButton setTitle:@"全部" forState:(UIControlStateNormal)];
    [self.moreButton setImage:[UIImage imageNamed:@"one_home_jiantou"] forState:(UIControlStateNormal)];
    [self.moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, autoScaleW(50), 0, 0)];
    [self.moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0,0,autoScaleW(10))];
    [self.moreButton addTarget:self action:@selector(MoreAllAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.moreButton];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-autoScaleH(20));
        make.centerY.equalTo(viewline);
        make.height.mas_equalTo(autoScaleW(16));
        make.width.mas_equalTo(autoScaleW(60));
    }];
}

-(void)MoreAllAction:(UIButton *)sender{
    if(self.moreButtonVC){
        self.moreButtonVC();
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
