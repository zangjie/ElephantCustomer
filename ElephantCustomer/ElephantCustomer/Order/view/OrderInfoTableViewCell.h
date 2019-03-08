//
//  OrderInfoTableViewCell.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderInfoTableViewCell : UITableViewCell
@property (nonatomic, strong) UIButton *PayButton;
@property (nonatomic, strong) OrderDetail *model;
@end

NS_ASSUME_NONNULL_END
