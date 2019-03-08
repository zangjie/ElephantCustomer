//
//  OrderProjectReportTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderProjectReportTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation OrderProjectReportTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initLaizUI];
    }
    return self;
}
-(void)initLaizUI{
    UIImageView *icoImage = [UIImageView new];
    icoImage.image = [UIImage imageNamed:@"order_report"];
    icoImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:icoImage];
    [icoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.centerY.equalTo(self);
        make.width.height.mas_offset(autoScaleW(15));
    }];
    UILabel *lableT = [UILabel new];
    lableT.font = mFont(15);
    lableT.textColor = darkGrayTextColor;
    lableT.text = @"项目服务报告";
    [self addSubview:lableT];
    [lableT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icoImage.mas_right).offset(autoScaleW(10));
        make.top.bottom.equalTo(self);
    }];
    
    UIImageView *imageJ = [UIImageView new];
    imageJ.image = [UIImage imageNamed:@"order_jian"];
    imageJ.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageJ];
    [imageJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(autoScaleH(-10));
        make.top.bottom.equalTo(icoImage);
        make.width.mas_offset(autoScaleW(30));
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = lightGrayTextColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_offset(0.5);
        make.bottom.equalTo(self);
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
