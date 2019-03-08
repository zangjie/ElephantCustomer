//
//  OrderReportPriceTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderReportPriceTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation OrderReportPriceTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initLaizUI];
    }
    return self;
}
-(void)initLaizUI{
    UILabel *lableY = [UILabel new];
    lableY.font = mFont(15);
    lableY.textColor = darkGrayTextColor;
    lableY.text  = @"已预付";
    [self addSubview:lableY];
    [lableY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(self).offset(autoScaleW(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.lablePirceY = [UILabel new];
    self.lablePirceY.font = mFont(15);
    self.lablePirceY.textColor = darkGrayTextColor;
    [self addSubview:self.lablePirceY];
    [self.lablePirceY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(autoScaleH(-10));
        make.top.equalTo(self).offset(autoScaleW(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    UILabel *lableT = [UILabel new];
    lableT.font = mFont(15);
    lableT.textColor = darkGrayTextColor;
    lableT.text  = @"订单总额";
    [self addSubview:lableT];
    [lableT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(lableY.mas_bottom).offset(autoScaleW(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.lablePirceTotal = [UILabel new];
    self.lablePirceTotal.font = mFont(15);
    self.lablePirceTotal.textColor = darkGrayTextColor;
    [self addSubview:self.lablePirceTotal];
    [self.lablePirceTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(autoScaleH(-10));
        make.top.equalTo(self.lablePirceY.mas_bottom).offset(autoScaleW(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    UIButton *buttonProtocol = [UIButton new];
    [buttonProtocol setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    buttonProtocol.titleLabel.font = mFont(12);
    buttonProtocol.titleLabel.textAlignment = NSTextAlignmentRight;
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"您已同意《用户服务及隐私协议》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:darkGrayTextColor
                          range:NSMakeRange(4, 11)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:lightGrayTextColor
                          range:NSMakeRange(0, 4)];
    [buttonProtocol setAttributedTitle:AttributedStr forState:(UIControlStateNormal)];
    [buttonProtocol addTarget:self action:@selector(protocolAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:buttonProtocol];
    [buttonProtocol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(autoScaleH(0));
        make.top.equalTo(self.lablePirceTotal.mas_bottom).offset(autoScaleW(18));
        make.height.mas_offset(autoScaleW(15));
        make.width.mas_offset(autoScaleW(200));
    }];
}
-(void)protocolAction:(UIButton *)sender{
    NSLog(@"协议");
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
