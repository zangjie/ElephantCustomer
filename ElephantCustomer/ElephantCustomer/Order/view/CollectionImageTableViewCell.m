//
//  CollectionImageTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/6.
//  Copyright © 2019 zj. All rights reserved.
//

#import "CollectionImageTableViewCell.h"
#import <Masonry/Masonry.h>
#import "ImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface CollectionImageTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation CollectionImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style
                   reuseIdentifier:reuseIdentifier]){
        [self initliazView];
    }
    return self;
}
-(void)initliazView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = autoScaleW(10);
    layout.minimumInteritemSpacing = autoScaleW(10);
//    layout.estimatedItemSize = CGSizeMake(autoScaleH(90), autoScaleH(90));
    layout.sectionInset = UIEdgeInsetsMake(0, autoScaleW(10),0, autoScaleW(10));//top, left, bottom, right
    layout.itemSize = CGSizeMake(autoScaleH(90), autoScaleH(90));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionImgView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionImgView.backgroundColor = [UIColor whiteColor];
    self.collectionImgView.showsVerticalScrollIndicator = NO;
    self.collectionImgView.showsHorizontalScrollIndicator = NO;
    self.collectionImgView.delegate = self;
    self.collectionImgView.dataSource  = self;
    [self addSubview:self.collectionImgView];
    [self.collectionImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.collectionImgView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayImageList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    [cell.imageContent sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.arrayImageList[indexPath.item]]]];
    return cell;
};
-(void)setArrayImageList:(NSArray *)arrayImageList{
    _arrayImageList = arrayImageList;
    [self.collectionImgView reloadData];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.seletIndex){
        self.seletIndex(indexPath);
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
