//
//  HomeProjectTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeProjectTableViewCell.h"
#import <Masonry/Masonry.h>
@interface HomeProjectTableViewCell()
@property (nonatomic, strong) UILabel *lableState;
@property (nonatomic, strong) UILabel *lableTime;
@property (nonatomic, strong) UILabel *lableProjectName;
@property (nonatomic, strong) UILabel *lableProjectGood;
@property (nonatomic, strong) UILabel *lableProjectAdress;
@property (nonatomic, strong) UILabel *lableProjectWhiceDay;
@end
@implementation HomeProjectTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self createUI];
    }
    return  self;
}

-(void)createUI{
    UIView *viewBG = [UIView new];
    viewBG.backgroundColor = backgroundGrayColor;
    viewBG.layer.cornerRadius =5.f;
    [self addSubview:viewBG];
    [viewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(autoScaleH(10));
        make.right.equalTo(self).offset(autoScaleH(-10));
        make.bottom.equalTo(self);
    }];
    self.lableState = [UILabel new];
    self.lableState.font = mFont(15);
    self.lableState.textColor = darkGrayTextColor;
    [viewBG addSubview:self.lableState];
    [self.lableState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBG).offset(autoScaleW(10));
        make.top.equalTo(viewBG).offset(autoScaleH(17.5));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.lableTime = [UILabel new];
    self.lableTime.font = mFont(15);
    self.lableTime.textColor = mainColor;
    [viewBG addSubview:self.lableTime];
    [self.lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lableState);
        make.right.equalTo(viewBG).offset(autoScaleW(-10));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor whiteColor];
    [viewBG addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewBG);
        make.height.mas_offset(1);
        make.top.equalTo(self.lableTime.mas_bottom).offset(autoScaleH(17.5));
    }];
    
    self.lableProjectName = [UILabel new];
    self.lableProjectName.font = mFont(15);
    self.lableProjectName.textColor = darkGrayTextColor;
    [viewBG addSubview:self.lableProjectName];
    [self.lableProjectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableState);
        make.top.equalTo(lineView.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.lableProjectGood = [UILabel new];
    self.lableProjectGood.font = mFont(15);
    self.lableProjectGood.textColor = lightGrayTextColor;
    [viewBG addSubview:self.lableProjectGood];
    [self.lableProjectGood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableProjectName);
        make.top.equalTo(self.lableProjectName.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    UIView *viewLine = [UIView new];
    viewLine.backgroundColor = [UIColor whiteColor];
    [viewBG addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewBG);
        make.top.equalTo(self.lableProjectGood.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(1);
    }];
    
    self.lableProjectAdress = [UILabel new];
    self.lableProjectAdress.font = mFont(12);
    self.lableProjectAdress.textColor = lightGrayTextColor;
    [viewBG addSubview:self.lableProjectAdress];
    [self.lableProjectAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableProjectGood);
        make.top.equalTo(viewLine.mas_bottom).offset(autoScaleH(13));
        make.height.mas_offset(12);
    }];
    
    self.lableProjectWhiceDay = [UILabel new];
    self.lableProjectWhiceDay.textColor = lightGrayTextColor;
    self.lableProjectWhiceDay.font = mFont(12);
    [viewBG addSubview:self.lableProjectWhiceDay];
    [self.lableProjectWhiceDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableProjectAdress);
        make.top.equalTo(self.lableProjectAdress.mas_bottom).offset(autoScaleH(13));
        make.height.mas_offset(autoScaleW(12));
    }];
    
}
-(void)setModel:(ProjectInfo *)model{
    self.lableState.text = model.status;
    self.lableTime.text = model.time;
    self.lableProjectName.text = model.title;
    self.lableProjectGood.text = model.devtype;
    self.lableProjectAdress.text = [NSString stringWithFormat:@"地点  %@",model.place];
    self.lableProjectWhiceDay.text = [NSString stringWithFormat:@"预约  %@",model.whichday];
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
