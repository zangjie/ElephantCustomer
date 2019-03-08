//
//  OrderModel.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderInfo.h"
#import "OrderDetailList.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject
SINGLETON_INTERFACE
//kw    string    否    关键词,仅在搜索时传此参数
//type    int    否    状态选项卡[0=全部,1=待确认,2=待上门,3=待完工,4=待付款],默认全部
//page    int    否    分页，默认第1页，每页10条

//订单列表
- (void)getOrderListWithKW:(nonnull NSString *)KW
                      type:(nullable NSString *)type
                      page:(nullable NSString *)typpagee
                 success:(nonnull void(^)(OrderInfo *model))success
                 failure:(nullable Failure)failure;

//订单详情
- (void)getOrderInfoListWithID:(nonnull NSString *)ID
                   success:(nonnull void(^)(OrderDetailList *model))success
                   failure:(nullable Failure)failure;


@end

NS_ASSUME_NONNULL_END
