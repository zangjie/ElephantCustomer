//
//  OrderContentTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderContentTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation OrderContentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initLaizUI];
    }
    return self;
}

-(void)initLaizUI{
    self.lableContent = [UILabel new];
    self.lableContent.numberOfLines=-1;
    self.lableContent.font = mFont(15);
    self.lableContent.textColor = darkGrayTextColor;
    [self addSubview:self.lableContent];
    [self.lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.right.equalTo(self).offset(autoScaleW(-10));
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(autoScaleH(-10));
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
