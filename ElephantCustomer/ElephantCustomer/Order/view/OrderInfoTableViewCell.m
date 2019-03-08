//
//  OrderInfoTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderInfoTableViewCell.h"
#import <Masonry/Masonry.h>
@interface OrderInfoTableViewCell()
@property (nonatomic, strong) UILabel *lableTitle;
@property (nonatomic, strong) UILabel *lablePhoneNumber;
@property (nonatomic, strong) UILabel *payType;
@property (nonatomic, strong) UILabel *projectName;
@property (nonatomic, strong) UILabel *projectAdress;
@property (nonatomic, strong) UILabel *projectTime;
@property (nonatomic, strong) UILabel *projectTotalPrice;


@end
@implementation OrderInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initlaizCellUI];
    }
    return self;
};
-(void)initlaizCellUI{
    
    UIView *viewBG  = [UIView new];
    viewBG.layer.cornerRadius = 5.f;
    viewBG.clipsToBounds = YES;
    [self addSubview:viewBG];
    [viewBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(autoScaleH(10));
        make.left.equalTo(self).offset(autoScaleH(10));
        make.right.equalTo(self).offset(autoScaleH(-10));
        make.bottom.equalTo(self);
    }];
    UIView *titleBGVIew = [UIView new];
    titleBGVIew.backgroundColor = darkGrayTextColor;
    [viewBG addSubview:titleBGVIew];
    [titleBGVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBG);
        make.left.equalTo(viewBG);
        make.right.equalTo(viewBG);
        make.height.mas_offset(autoScaleH(35));
    }];
    [titleBGVIew layoutIfNeeded];
    UIView *viewBottom = [UIView new];
    viewBottom.backgroundColor = backgroundGrayColor;
    [viewBG addSubview:viewBottom];
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBGVIew.mas_bottom);
        make.left.equalTo(viewBG);
        make.right.equalTo(viewBG);
        make.bottom.equalTo(viewBG);
    }];
    
    self.lableTitle = [UILabel new];
    self.lableTitle.font = mFont(12);
    self.lableTitle.textColor = [UIColor whiteColor];
    [titleBGVIew addSubview:self.lableTitle];
    [self.lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleBGVIew);
        make.left.equalTo(titleBGVIew).offset(autoScaleW(10));
        make.height.mas_offset(autoScaleH(13));
    }];
    
    self.lablePhoneNumber = [UILabel new];
    self.lablePhoneNumber.font = mFont(15);
    self.lablePhoneNumber.textColor = darkGrayTextColor;
    [viewBottom addSubview:self.lablePhoneNumber];
    [self.lablePhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBottom).offset(autoScaleW(10));
        make.top.equalTo(viewBottom).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.payType = [UILabel new];
    self.payType.font = mFont(15);
    self.payType.textColor = mainColor;
    [viewBottom addSubview:self.payType];
    [self.payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewBottom).offset(autoScaleH(-10));
        make.centerY.equalTo(self.lablePhoneNumber);
        make.height.equalTo(self.lablePhoneNumber);
    }];
    self.projectName = [UILabel new];
    self.projectName.textColor = darkGrayTextColor;
    self.projectName.font = mFont(15);
    [viewBottom addSubview:self.projectName];
    [self.projectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lablePhoneNumber);
        make.top.equalTo(self.lablePhoneNumber.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor whiteColor];
    [viewBottom addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewBottom);
        make.top.equalTo(self.projectName.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(1);
    }];
    
    self.projectAdress = [UILabel new];
    self.projectAdress.font = mFont(12);
    self.projectAdress.textColor = lightGrayTextColor;
    [viewBottom addSubview:self.projectAdress];
    [self.projectAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.projectName);
        make.top.equalTo(lineView.mas_bottom).offset(autoScaleH(13));
        make.height.mas_offset(autoScaleH(12));
    }];
    
    self.projectTime = [UILabel new];
    self.projectTime.font = mFont(12);
    self.projectTime.textColor = lightGrayTextColor;
    [viewBottom addSubview:self.projectTime];
    [self.projectTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.projectAdress);
        make.top.equalTo(self.projectAdress.mas_bottom).offset(autoScaleH(13));
        make.height.mas_offset(autoScaleH(12));
    }];
    
    UIView *viewLine = [UIView new];
    viewLine.backgroundColor = [UIColor whiteColor];
    [viewBottom addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewBottom);
        make.height.mas_offset(1);
        make.top.equalTo(self.projectTime.mas_bottom).offset(autoScaleH(13));
    }];
    
    self.projectTotalPrice = [UILabel new];
    self.projectTotalPrice.font = mFont(15);
    self.projectTotalPrice.textColor = darkGrayTextColor;
    [viewBottom addSubview:self.projectTotalPrice];
    [self.projectTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.projectTime);
        make.top.equalTo(viewLine.mas_bottom).offset(autoScaleH(17.5f));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.PayButton =[ UIButton new];
    [self.PayButton setTitle:@"付款" forState:(UIControlStateNormal)];
    self.PayButton.titleLabel.font = mFont(15);
    [self.PayButton setTitleColor:mainColor forState:(UIControlStateNormal)];
    self.PayButton.layer.borderColor = mainColor.CGColor;
    self.PayButton.layer.borderWidth =1.f;
    self.PayButton.layer.cornerRadius = 5.f;
    [viewBottom addSubview:self.PayButton];
    [self.PayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewBottom).offset(autoScaleW(-10));
        make.top.equalTo(viewLine).offset(autoScaleH(7.5));
        make.bottom.equalTo(viewBottom).offset(autoScaleH(-7.5));
        make.width.mas_offset(autoScaleW(80));
    }];
    
//
//
//    self.projectAdress = [UILabel new];
//    self.projectAdress.font = mFont(12);
//    self.projectAdress.textColor = lightGrayTextColor;
//    self.projectAdress.text = @"服务地点  江苏省常州市武进区无路1号";
//    [viewBottom addSubview:self.projectAdress];
//    [self.projectAdress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.projectName);
//        make.top.equalTo(lineView).offset(autoScaleH(13));
//        make.height.mas_offset(autoScaleH(12));
//    }];
//
}

-(void)setModel:(OrderDetail *)model{
    self.lableTitle.text = model.owner;
    self.lablePhoneNumber.text = model.ordno;
    self.payType.text = model.status;
    self.projectName.text = model.title;
    self.projectAdress.text = [NSString stringWithFormat:@"服务地点  %@",model.place];
    self.projectTime.text = [NSString stringWithFormat:@"预约上门  %@",model.whichday];
    self.projectTotalPrice.text = [NSString stringWithFormat:@"订单总额  %@",model.ordfee];
    self.PayButton.hidden = [model.btn_pay isEqualToString:@"0"]?YES:NO;
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
