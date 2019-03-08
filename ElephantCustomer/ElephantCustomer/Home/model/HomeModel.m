//
//  HomeModel.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeModel.h"
#import "YYXYNetworking.h"
@implementation HomeModel
static HomeModel *singleton = nil;
SINGLETON_IMPLEMENTATION(singleton)
-(void)getHomeInfoSuccess:(nonnull void(^)(HomeInfo *model))success
                  failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance]POST:@"/index/index" parameters:@{} progress:nil success:^(id  _Nullable responseObject) {
        HomeInfo *model = [YYXYNetworking analysisModelFromJSONModel:[HomeInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

- (void)getHomeProjectList:(nonnull NSString *)page
                   success:(nonnull void(^)(HomeProjectInfo *model))success
                   failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance]POST:@"/index/order" parameters:@{@"page":page} progress:nil success:^(id  _Nullable responseObject) {
        HomeProjectInfo *model = [YYXYNetworking analysisModelFromJSONModel:[HomeProjectInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

- (void)getHomeCircleList:(nonnull NSString *)page
                  success:(nonnull void(^)(MomentList *model))success
                  failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/moments/index" parameters:@{@"page":page} progress:nil success:^(id  _Nullable responseObject) {
        MomentList *model = [YYXYNetworking analysisModelFromJSONModel:[MomentList class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
    
    
}
@end
