//
//  CircleTableViewCell.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *lableContent;
@property (nonatomic, strong)UIImageView *imageHeader;
@property (nonatomic, strong)UIImageView *imageContent;
@property (nonatomic, strong)UILabel *lableNickName;
@property (nonatomic, strong)UILabel *lableGood;
@end

NS_ASSUME_NONNULL_END
