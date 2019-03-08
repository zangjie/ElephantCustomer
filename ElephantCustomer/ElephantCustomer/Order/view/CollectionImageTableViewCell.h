//
//  CollectionImageTableViewCell.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/6.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionImageTableViewCell : UITableViewCell
@property(nonatomic, strong)NSArray *arrayImageList;
@property (nonatomic, strong)UICollectionView *collectionImgView;
@property (nonatomic, copy) void(^seletIndex)(NSIndexPath *index);
@end

NS_ASSUME_NONNULL_END
