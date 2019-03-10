//
//  FeedbackTableViewCell.m
//  ElephantCustomer
//
//  Created by Bge on 2019/3/9.
//  Copyright © 2019 zj. All rights reserved.
//

#import "FeedbackTableViewCell.h"
#import <Masonry/Masonry.h>

@implementation FeedbackTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self initialControl];
    }
    return self;
}

- (void)initialControl {
    self.titleLabel = [UILabel new];
    [self.titleLabel setTextColor:[UIColor darkTextColor]];
    [self.titleLabel setFont:mFont(14)];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.and.bottom.mas_equalTo(0);
        make.centerY.equalTo(self);
    }];
    
    self.detailTitleLabel = [UILabel new];
    [self.detailTitleLabel setTextColor:UICOLOR_WITH_HEX(0xa0a6b7)];
    [self.detailTitleLabel setFont:mFont(14)];
    [self.detailTitleLabel setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:self.detailTitleLabel];
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).mas_equalTo(10);
        make.top.and.bottom.mas_equalTo(0);
    }];
    
    self.selectButton = [UIButton new];
    [self.selectButton setImage:[UIImage imageNamed:@"ico_select_n"] forState:UIControlStateNormal];
    [self addSubview:self.selectButton];
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.and.right.mas_equalTo(0);
        make.width.equalTo(self.selectButton.mas_height);
        make.left.greaterThanOrEqualTo(self.detailTitleLabel.mas_right);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [self.selectButton setImage:[UIImage imageNamed:@"ico_select_s"] forState:UIControlStateNormal];
    } else {
        [self.selectButton setImage:[UIImage imageNamed:@"ico_select_n"] forState:UIControlStateNormal];
    }
}

@end
