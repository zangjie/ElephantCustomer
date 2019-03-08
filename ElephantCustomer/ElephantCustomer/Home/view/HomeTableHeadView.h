//
//  HomeTableHeadView.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableHeadView : UIView
@property (nonatomic, strong)NSArray<Order> *orderlist;
@property (nonatomic, assign) int currentNumber;
@property (nonatomic, copy)void(^moreProject)(void);
@end

NS_ASSUME_NONNULL_END
