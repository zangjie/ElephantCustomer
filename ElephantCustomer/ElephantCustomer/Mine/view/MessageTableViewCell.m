//
//  MessageTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/4.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MessageTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation MessageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style
                 reuseIdentifier:reuseIdentifier]){
        [self initliazView];
    };
    return self;
}
-(void)initliazView{
    self.lableTime = [UILabel new];
    self.lableTime.font = mFont(12);
    self.lableTime.textColor = lightGrayTextColor;
    self.lableTime.numberOfLines =1;
    [self addSubview:self.lableTime];
    [self.lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(autoScaleW(10));
        make.top.equalTo(self).offset(autoScaleH(8));
        make.right.equalTo(self).offset(autoScaleW(-10));
    }];
    
    self.lableContent = [UILabel new];
    self.lableContent.font = mFont(12);
    self.lableContent.textColor = darkGrayTextColor;
    self.lableContent.numberOfLines = 2;
    [self addSubview:self.lableContent];
    [self.lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableTime);
        make.top.equalTo(self.lableTime.mas_bottom).offset(autoScaleH(10));
        make.right.equalTo(self.lableTime);
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
