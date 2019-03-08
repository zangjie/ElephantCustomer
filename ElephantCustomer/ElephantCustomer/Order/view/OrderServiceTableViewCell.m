//
//  OrderServiceTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderServiceTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation OrderServiceTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initLaizUI];
    }
    return self;
}

-(void)initLaizUI{
    self.lableTitle = [UILabel new];
    self.lableTitle.font = self.lableEdges?mFont(12):mFont(15);
    self.lableTitle.textColor = lightGrayTextColor;
    [self addSubview:self.lableTitle];
    [self.lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleH(10));
        make.centerY.equalTo(self);
        make.height.mas_offset(self.lableEdges?autoScaleW(12):autoScaleH(15));
    }];
    self.lableContent = [UILabel new];
    self.lableContent.font = self.lableEdges?mFont(12):mFont(15);
    self.lableContent.textColor = darkGrayTextColor;
    self.lableContent.numberOfLines=2;
    [self addSubview:self.lableContent];
    [self.lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableTitle.mas_right).offset(autoScaleW(13));
        make.bottom.top.equalTo(self);
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
