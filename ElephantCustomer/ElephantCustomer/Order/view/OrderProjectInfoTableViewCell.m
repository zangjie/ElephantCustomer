//
//  OrderProjectInfoTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderProjectInfoTableViewCell.h"
#import <Masonry/Masonry.h>
@interface OrderProjectInfoTableViewCell()
@property (nonatomic, strong)UILabel *lableProjectName;
@property (nonatomic, strong)UILabel *lableProjectClose;
@property (nonatomic, strong)UILabel *lableProjectContent;
@end
@implementation OrderProjectInfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initLaizUI];
    }
    return self;
}

-(void)initLaizUI{
    UIImageView *imageT = [UIImageView new];
    imageT.image = [UIImage imageNamed:@"order_project"];
    imageT.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageT];
    [imageT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(self).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(20));
        make.width.mas_offset(autoScaleW(40));
    }];
    self.lableProjectName = [UILabel new];
    self.lableProjectName.font = mFont(15);
    self.lableProjectName.textColor = darkGrayTextColor;
    [self addSubview:self.lableProjectName];
    [self.lableProjectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageT.mas_right).offset(autoScaleW(5));
        make.top.bottom.equalTo(imageT);
    }];
    
    
    self.lableProjectClose = [UILabel new];
    self.lableProjectClose.font = mFont(15);
    self.lableProjectClose.textColor = darkGrayTextColor;
    [self addSubview:self.lableProjectClose];
    [self.lableProjectClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageT);
        make.top.equalTo(imageT.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(15));
    }];
    
    self.lableProjectContent = [UILabel new];
    self.lableProjectContent.font = mFont(15);
    self.lableProjectContent.textColor = lightGrayTextColor;
    [self addSubview:self.lableProjectContent];
    [self.lableProjectContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableProjectClose);
        make.top.equalTo(self.lableProjectClose.mas_bottom).offset(autoScaleH(18));
        make.height.mas_offset(autoScaleW(15));
    }];
}
-(void)setModel:(OrderDetailList *)model{
    
    self.lableProjectName.text = model.title;
    self.lableProjectClose.text = model.devtype;
    self.lableProjectContent.text = model.servtags;
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
