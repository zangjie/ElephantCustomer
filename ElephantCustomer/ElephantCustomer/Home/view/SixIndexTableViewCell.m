//
//  SixIndexTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "SixIndexTableViewCell.h"
#import <SDWebImage/UIButton+WebCache.h>

#import <Masonry/Masonry.h>
@implementation SixIndexTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self =[super initWithStyle:style
                  reuseIdentifier:reuseIdentifier]){
        [self creatUI];
    }
    return self;
}
-(void)creatUI{
    for (int i=0 ; i<6; i++) {
        UIButton *selectbutton  = [UIButton new];
        selectbutton.contentMode = UIViewContentModeScaleAspectFit;
        [selectbutton addTarget:self action:@selector(selectButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        selectbutton.tag = 1000+i;
//        selectbutton.backgroundColor = mainColor;
        [self addSubview:selectbutton];
        [selectbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i<3){
                make.left.equalTo(self).offset(autoScaleW(10)+i*(mScreenWidth-autoScaleW(22))/3.f+1);
                make.top.mas_equalTo(autoScaleH(20));
            }else {
                make.left.equalTo(self).offset(autoScaleW(10)+(i-3)*(mScreenWidth-autoScaleW(22))/3.f+1);
                make.top.mas_equalTo(autoScaleH(20+131));
            }
            make.width.mas_equalTo((mScreenWidth-autoScaleW(22))/3.f);
            make.height.mas_equalTo(autoScaleH(130));

        }];
    }
}
-(void)selectButtonAction:(UIButton*)sender{
    int index = (int)(sender.tag-1000);
    if(self.selectIndex){
        self.selectIndex(index);
    }
}
-(void)setModel:(NSArray<Devcat> *)model{
    for (int i = 0; i<6; i++) {
        UIButton *selecbutton = [self viewWithTag:i+1000];
        Devcat *info = model[i];
        [selecbutton sd_setImageWithURL:[NSURL URLWithString:info.ico] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"place_holdImage_B"]];
    }
    
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
