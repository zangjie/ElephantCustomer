//
//  HomeImageCollectionViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/7.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeImageCollectionViewCell.h"
#import <Masonry/Masonry.h>
@implementation HomeImageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initliazView];
    }
    return self;
}
-(void)initliazView{
    self.imageContent = [UIImageView new];
    self.imageContent.contentMode = UIViewContentModeScaleAspectFill;
    self.imageContent.clipsToBounds = YES;
    [self addSubview:self.imageContent];
    [self.imageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.buttonX = [UIButton new];
    [self.buttonX setTitle:@"X" forState:(UIControlStateNormal)];
    self.buttonX.backgroundColor = UICOLOR_WITH_RGB(1, 1, 1, 0.2);
    [self addSubview:self.buttonX];
    [self.buttonX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.width.height.mas_offset(20);
    }];
    

}

@end
