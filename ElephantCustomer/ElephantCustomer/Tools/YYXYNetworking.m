//
//  YYXYNetworking.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import "YYXYNetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>
#import "UserModel.h"
@implementation YYXYNetworking
static YYXYNetworking *singleton = nil;
+ (YYXYNetworking *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}

+ (YYXYNetworking *)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [super allocWithZone:zone];
       
    });
    return singleton;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return singleton;
}
- (AFHTTPSessionManager *)_gcNetworkingSessionWithResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer {
    AFHTTPSessionManager *result = [AFHTTPSessionManager manager];
    result.responseSerializer = responseSerializer;
    NSArray *acceptContentTypeArray = @[@"text/html",@"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json"];
    [result.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:acceptContentTypeArray]];
    [result.requestSerializer setValue:[UserModel sharedInstance].token forHTTPHeaderField:@"token"];
    //time out interval
    NSTimeInterval timeoutInterval = 10.f;
    [result.requestSerializer setTimeoutInterval:timeoutInterval];
    return result;
}

//
//- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)apiName
//                            parameters:(nullable NSDictionary *)parameters
//                              progress:(nullable progressHandle)progress
//                               success:(nonnull successHandle)success
//                               failure:(nullable failureHandle)failure {
//    NSString *hostUrl = hostUrl;
//    NSString *urlPath = [hostUrl stringByAppendingString:apiName];
//
//    NSLog(@"-------apiName: %@, request:%@?%@", apiName, urlPath, parameters);
//
//    AFHTTPSessionManager *sessionManager = [self _gcNetworkingSessionWithResponseSerializer:
//                                            [AFHTTPResponseSerializer serializer]];
//
//    return [sessionManager GET:urlPath parameters:parameters progress:^(NSProgress *_Nonnull downloadProgress) {
//        if (progress) {
//            progress(downloadProgress.fractionCompleted);
//        }
//    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
////        NSDictionary *responseDictionary = [self responseDictionaryWithData:responseObject decryptBlock:decryptBlock];
////        [self requestSuccessWithApiName:apiName responseObject:responseDictionary success:success failure:failure];
//    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
////        [self requestFailureWithApiName:apiName error:error failure:failure];
//    }];
//}
//

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)apiName
                             parameters:(nullable NSDictionary *)parameters
                               progress:(nullable progressHandle)progress
                                success:(nonnull successHandle)success
                                failure:(nullable failureHandle)failure {
    NSString *hostUrl =  HostUrl;
    NSString *urlPath = [hostUrl stringByAppendingString:apiName];
    NSLog(@"-------apiName: %@, request:%@?%@", apiName, urlPath, parameters);

    AFHTTPSessionManager *sessionManager = [self _gcNetworkingSessionWithResponseSerializer:
                                            [AFHTTPResponseSerializer serializer]];

    return [sessionManager POST:urlPath parameters:parameters
                       progress:^(NSProgress *_Nonnull downloadProgress) {
                           if (progress) {
                               progress(downloadProgress.fractionCompleted);
                           }
                       } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
                           NSDictionary *responseDictionary = [self responseDictionaryWithData:responseObject];
                           if([responseDictionary[@"code"] integerValue] ==0){//成功
                               [self analysisModelFromData:responseDictionary success:success];
                           }else if([responseDictionary[@"code"] integerValue] ==-1){//失败
                               failure(responseDictionary[@"msg"]);
                           }else if([responseDictionary[@"code"] integerValue] ==-2){//未登录
                               failure(@"请先登录");
                               [UserModel sharedInstance].token = @"";
                               [[NSNotificationCenter defaultCenter] postNotificationName:@"GCSkipShowLoginNotification" object:nil];
                           }else {
                               failure(@"未知错误码");
                           }

                           NSLog(@"%@",responseDictionary);
                       } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
//                           [self analysisModelFromData:error failure:failure];
                       }];
}

-(void)analysisModelFromData:(NSDictionary *)data success:(successHandle)success{
    id dataModel = data[@"data"];
    NSLog(@"%@",[dataModel class]);
    if([dataModel isKindOfClass:[NSArray class]]){
        NSLog(@"返回数组类型");
        NSDictionary *dic = [NSDictionary dictionaryWithObject:dataModel forKey:@"list"];
        success(dic);
    }else if([dataModel isKindOfClass:[NSDictionary class]]){
        NSLog(@"返回字典类型");
        success(dataModel);
    }else {
        NSLog(@"不存在该类别");
    }
}

+(id)analysisModelFromJSONModel:(Class)class ModelDic:(NSDictionary*)dic{
    id model = [[class alloc]initWithDictionary:dic error:nil];
    return model;
}
- (nullable NSURLSessionDataTask *)uploadEnclosure:(nonnull NSDictionary *)enclosureDictionary
                                           apiName:(nonnull NSString *)apiName
                                        parameters:(nullable NSDictionary *)parameters
                                          progress:(nullable progressHandle)progress
                                           success:(nonnull successHandle)success
                                           failure:(nullable failureHandle)failure{
    NSString *hostUrl =  HostUrl;
    NSString *urlPath = [hostUrl stringByAppendingString:apiName];
    NSLog(@"-------apiName: %@, request:%@?%@", apiName, urlPath, parameters);

    AFHTTPSessionManager *sessionManager = [self _gcNetworkingSessionWithResponseSerializer:
                                            [AFHTTPResponseSerializer serializer]];

    return [sessionManager POST:urlPath
                     parameters:parameters
      constructingBodyWithBlock:^(id < AFMultipartFormData > _Nonnull formData) {
          for (NSString *key in enclosureDictionary.allKeys) {
              NSData *enclosureData = [NSData dataWithData:[enclosureDictionary valueForKey:key]];
              [formData appendPartWithFileData:enclosureData name:key fileName:[key stringByAppendingString:@".jpg"] mimeType:@"image/jpeg"];
          }
      } progress:^(NSProgress *_Nonnull downloadProgress) {
          if (progress) {
              progress(downloadProgress.fractionCompleted);
          }
      } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
          NSDictionary *responseDictionary = [self responseDictionaryWithData:responseObject];
          if([responseDictionary[@"code"] integerValue] ==0){//成功
              [self analysisModelFromData:responseDictionary success:success];
          }else if([responseDictionary[@"code"] integerValue] ==-1){//失败
              failure(responseDictionary[@"msg"]);
          }else if([responseDictionary[@"code"] integerValue] ==-2){//未登录
              failure(@"请先登录");
              [UserModel sharedInstance].token = @"";
              [[NSNotificationCenter defaultCenter] postNotificationName:@"GCSkipShowLoginNotification" object:nil];
          }else {
              failure(@"未知错误码");
          }
          
          NSLog(@"%@",responseDictionary);
      } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
          //                           [self analysisModelFromData:error failure:failure];
      }];
}


- (NSDictionary *)responseDictionaryWithData:(NSData *)data  {
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return responseDictionary;
}

@end
