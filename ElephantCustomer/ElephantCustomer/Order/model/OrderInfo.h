//
//  OrderInfo.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OrderDetail <NSObject>
@end
@interface OrderDetail : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *ordno;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSString *whichday;
@property (strong, nonatomic) NSString *ordfee;
@property (strong, nonatomic) NSString *btn_pay;
@end
@interface OrderInfo : JSONModel
@property (nonatomic, strong)NSArray<OrderDetail> *list;
@end

NS_ASSUME_NONNULL_END
