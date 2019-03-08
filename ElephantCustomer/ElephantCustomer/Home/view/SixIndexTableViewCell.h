//
//  SixIndexTableViewCell.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface SixIndexTableViewCell : UITableViewCell
@property(nonatomic, strong)NSArray<Devcat> *model;
@property(nonatomic, copy)void(^selectIndex)(int index);
@end

NS_ASSUME_NONNULL_END
