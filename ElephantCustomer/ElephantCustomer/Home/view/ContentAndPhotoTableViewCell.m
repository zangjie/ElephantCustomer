//
//  ContentAndPhotoTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/7.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ContentAndPhotoTableViewCell.h"
#import <Masonry/Masonry.h>
#import "HomeImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ContentAndPhotoTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation ContentAndPhotoTableViewCell
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
    [self.collectionImgView registerClass:[HomeImageCollectionViewCell class] forCellWithReuseIdentifier:@"HomeImageCollectionViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayImageList.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeImageCollectionViewCell" forIndexPath:indexPath];
    if(indexPath.item<self.arrayImageList.count){
//        [cell.imageContent sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.arrayImageList[indexPath.item]]]];
        cell.imageContent.image = self.arrayImageList[indexPath.row];
        cell.buttonX.hidden = NO;
        cell.buttonX.tag = indexPath.item+1000;
        [cell.buttonX addTarget:self action:@selector(deleAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }else {
        cell.buttonX.hidden=YES;
        cell.imageContent.image = [UIImage imageNamed:@"placePhoto"];
    }
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

-(void)deleAction:(UIButton *)sender{
    if(self.deleAction){
        self.deleAction(sender.tag-1000);
    }
}


@end
