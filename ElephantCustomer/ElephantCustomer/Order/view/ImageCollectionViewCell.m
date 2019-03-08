//
//  ImageCollectionViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/6.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import <Masonry/Masonry.h>
@implementation ImageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self initliazView];
    }
    return self;
}
-(void)initliazView{
    self.imageContent = [UIImageView new];
    self.imageContent.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imageContent];
    [self.imageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
@end
