//
//  OrderModel.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderModel.h"

#import "YYXYNetWorking.h"
@implementation OrderModel
static OrderModel *singleton = nil;
SINGLETON_IMPLEMENTATION(singleton)


- (void)getOrderListWithKW:(nonnull NSString *)KW
                      type:(nullable NSString *)type
                      page:(nullable NSString *)page
                   success:(nonnull void(^)(OrderInfo *model))success
                   failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance] POST:@"/order/index" parameters:@{@"KW":KW,@"type":type,@"page":page} progress:nil success:^(id  _Nullable responseObject) {
        OrderInfo *model = [YYXYNetworking analysisModelFromJSONModel:[OrderInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}


- (void)getOrderInfoListWithID:(nonnull NSString *)ID
                       success:(nonnull void(^)(OrderDetailList *model))success
                       failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/order/detail" parameters:@{@"id":ID} progress:nil success:^(id  _Nullable responseObject) {
        OrderDetailList *model = [YYXYNetworking analysisModelFromJSONModel:[OrderDetailList class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
    
    
    
}
@end
