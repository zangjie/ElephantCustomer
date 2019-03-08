//
//  YYXYNetworking.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^progressHandle)(double progress);
typedef void(^successHandle)(id _Nullable responseObject);
typedef void(^failureHandle)(id _Nullable errorObject);
@interface YYXYNetworking : NSObject
+ (nonnull instancetype)sharedInstance;

- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)apiName
                            parameters:(nullable NSDictionary *)parameters
                              progress:(nullable progressHandle)progress
                               success:(nonnull successHandle)success
                               failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)apiName
                             parameters:(nullable NSDictionary *)parameters
                               progress:(nullable progressHandle)progress
                                success:(nonnull successHandle)success
                                failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)uploadEnclosure:(nonnull NSDictionary *)enclosureDictionary
                                           apiName:(nonnull NSString *)apiName
                                        parameters:(nullable NSDictionary *)parameters
                                          progress:(nullable progressHandle)progress
                                           success:(nonnull successHandle)success
                                           failure:(nullable failureHandle)failure;

+(id)analysisModelFromJSONModel:(Class)class ModelDic:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
