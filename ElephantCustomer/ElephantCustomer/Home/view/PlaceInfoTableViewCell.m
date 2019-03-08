//
//  PlaceInfoTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/7.
//  Copyright © 2019 zj. All rights reserved.
//

#import "PlaceInfoTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation PlaceInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initliazView];
    }
    return self;
}
-(void)initliazView{
    self.lableTitle = [UILabel new];
    self.lableTitle.font = mFont(15);
    self.lableTitle.textColor = darkGrayTextColor;
//    self.lableTitle.text  = @"订单归属";
    [self addSubview:self.lableTitle];
    [self.lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(self).offset(autoScaleH(12));
        make.height.mas_offset(autoScaleW(15));
    }];
   
    self.lableContent = [UILabel new];
//    self.lableContent.text = @"服务范畴";
    self.lableContent.font = mFont(12);
    self.lableContent.textColor = lightGrayTextColor;
    [self addSubview:self.lableContent];
    [self.lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableTitle);
        make.top.equalTo(self.lableTitle.mas_bottom).offset(autoScaleH(10));
        make.height.mas_offset(autoScaleW(12));
    }];
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = backgroundGrayColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_offset(0.5f);
        make.top.equalTo(self.mas_bottom).offset(-autoScaleH(0.5));
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
