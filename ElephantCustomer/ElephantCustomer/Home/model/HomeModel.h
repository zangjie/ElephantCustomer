//
//  HomeModel.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeInfo.h"
#import "HomeProjectInfo.h"
#import "MomentList.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : NSObject
SINGLETON_INTERFACE
//首页所有信息
-(void)getHomeInfoSuccess:(nonnull void(^)(HomeInfo *model))success
                    failure:(nullable Failure)failure;

//工程列表
- (void)getHomeProjectList:(nonnull NSString *)page
                 success:(nonnull void(^)(HomeProjectInfo *model))success
                 failure:(nullable Failure)failure;

//圈子列表
- (void)getHomeCircleList:(nonnull NSString *)page
                   success:(nonnull void(^)(MomentList *model))success
                   failure:(nullable Failure)failure;


@end

NS_ASSUME_NONNULL_END
