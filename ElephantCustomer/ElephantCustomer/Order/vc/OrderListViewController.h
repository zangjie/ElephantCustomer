//
//  OrderListViewController.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,OrderType) {
    OrderTypeAll = 0,//全部订单
    OrderTypeToBeConfirmed = 1,//待确认
    OrderTypeWaitingForTheDoor =2,//待上门
    OrderTypeToBeCompleted = 3,//待完工
    OrderTypePendingPayment = 4,//待付款
};
@interface OrderListViewController : UIViewController
@property (nonatomic, assign)OrderType type;
@property (nonatomic, copy)void(^selectIndex)(int index);
@end

NS_ASSUME_NONNULL_END
