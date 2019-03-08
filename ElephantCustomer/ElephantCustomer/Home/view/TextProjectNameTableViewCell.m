//
//  TextProjectNameTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/8.
//  Copyright © 2019 zj. All rights reserved.
//

#import "TextProjectNameTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation TextProjectNameTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initliazView];
    }
    return self;
}
-(void)initliazView{
    self.textName = [UITextField new];
    self.textName.placeholder = @"项目名称";
    self.textName.font = mFont(15);
    self.textName.textColor = darkGrayTextColor;
    [self addSubview:self.textName];
    [self.textName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).mas_offset(autoScaleW(10));
        make.right.equalTo(self).mas_offset(autoScaleW(-10));
        make.top.bottom.equalTo(self);
    }] ;
    
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
