//
//  CircleTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "CircleTableViewCell.h"
#import "UILabel+String.h"
#import <Masonry/Masonry.h>
@implementation CircleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return  self;
}
-(void)createUI{
    UIView *BGView = [UIView new];
    BGView.layer.cornerRadius =10.f;
//    BGView.backgroundColor = UICOLOR_WITH_RGB(236, 242, 252, 1);
    [self addSubview:BGView];
    [BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.imageContent = [UIImageView new];
//    self.imageContent.backgroundColor = [UIColor redColor];
    self.imageContent.contentMode = UIViewContentModeScaleAspectFit;
    [BGView addSubview:self.imageContent];
    [self.imageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BGView).offset(autoScaleW(10));
        make.right.equalTo(BGView).offset(-autoScaleW(10));
        make.width.height.mas_equalTo(autoScaleW(80));
    }];
    
    self.lableContent = [UILabel new];
    [self.lableContent setText:@"发哪款好那就是对扣几分哈萨克交交交电话费卡拉胶首付款就交交交电交交交电交交交电交交交电"
                   lineSpacing:autoScaleH(4)];
    self.lableContent.textColor = [UIColor darkGrayColor];
    self.lableContent.numberOfLines = 2;
    self.lableContent.font= mFont(15);
    [BGView addSubview:self.lableContent];
    [self.lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView).offset(autoScaleW(10));
        make.top.equalTo(BGView).offset(autoScaleH(13));
        make.right.equalTo(self.imageContent.mas_left).offset(-autoScaleH(13));
    }];
    
    self.imageHeader = [UIImageView new];
    self.imageHeader.contentMode = UIViewContentModeScaleAspectFit;
    self.imageHeader.layer.cornerRadius  = autoScaleW(18)/2.f;
    self.imageHeader.clipsToBounds = YES;
    [BGView addSubview:self.imageHeader];
    [self.imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BGView).offset(autoScaleW(10));
        make.bottom.equalTo(BGView).offset(autoScaleH(-10));
        make.width.height.mas_offset(autoScaleW(18));
    }];
    
    self.lableNickName = [UILabel new];
    self.lableNickName.text = @"陈*秀";
    self.lableNickName.font = mFont(12);
    self.lableNickName.textColor = darkGrayTextColor;
    [BGView addSubview:self.lableNickName];
    [self.lableNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imageHeader);
        make.left.equalTo(self.imageHeader.mas_right).offset(autoScaleH(10));
    }];
    
    self.lableGood = [UILabel new];
    self.lableGood.text = @"125点赞";
    self.lableGood.font = mFont(12);
    self.lableGood.textColor = lightGrayTextColor;
    [BGView addSubview:self.lableGood];
    [self.lableGood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageContent.mas_left).offset(autoScaleH(-13));
        make.top.bottom.equalTo(self.lableNickName);
    }];
    
    UIView *lineCellView = [UIView new];
    lineCellView.backgroundColor = backgroundGrayColor;
    [BGView addSubview:lineCellView];
    [lineCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(BGView);
        make.top.equalTo(self.lableGood.mas_bottom).offset(autoScaleH(13));
        make.height.mas_offset(0.5f);
    }];
    
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
