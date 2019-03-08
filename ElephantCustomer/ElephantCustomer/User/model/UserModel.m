//
//  UserModel.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import "UserModel.h"
#import "YYXYNetworking.h"
@implementation UserModel
static UserModel *singleton = nil;
SINGLETON_IMPLEMENTATION(singleton)
- (void)getCodeWithPhone:(nonnull NSString *)phone
                   event:(nullable NSString *)event
                 success:(nonnull void(^)(void))success
                 failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance] POST:@"/user/smscode" parameters:@{@"mobile":phone,@"event":event} progress:nil success:^(id  _Nullable responseObject) {
//       User *model =  [YYXYNetworking analysisModelFromJSONModel:[User class] ModelDic:responseObject];
        success();
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

- (void)registWithPhone:(nonnull NSString *)phone
                captcha:(nullable NSString *)captcha
               password:(nullable NSString *)password
                success:(nonnull void(^)(void))success
                failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance]POST:@"/user/register" parameters:@{@"mobile":phone,@"captcha":captcha,@"password":password} progress:nil success:^(id  _Nullable responseObject) {
        success();
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

- (void)loginWithPhone:(nonnull NSString *)phone
              password:(nullable NSString *)password
               success:(nonnull void(^)(void))success
               failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance]POST:@"/user/login" parameters:@{@"mobile":phone,@"password":password} progress:nil success:^(id  _Nullable responseObject) {
        User *user = [YYXYNetworking analysisModelFromJSONModel:[User class] ModelDic:responseObject];
        [[NSUserDefaults standardUserDefaults] setObject:user.uid forKey:@"uid"];
        [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:@"token"];
        self.token = user.token;
        [self getPersonInfosuccess:^(MineInfo * _Nonnull model) {
            success();
        } failure:^(id errorObject) {
        }];
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}
-(void)getPersonInfosuccess:(nonnull void(^)(MineInfo *model))success
                    failure:(nullable Failure)failure{
    [[YYXYNetworking sharedInstance]POST:@"/user/index" parameters:@{} progress:nil success:^(id  _Nullable responseObject) {
        MineInfo *model  = [YYXYNetworking analysisModelFromJSONModel:[MineInfo class] ModelDic:responseObject];
        [[NSUserDefaults standardUserDefaults] setObject:model.type forKey:@"type"];
        [[NSUserDefaults standardUserDefaults] setObject:model.avatar forKey:@"avatar"];
        [[NSUserDefaults standardUserDefaults] setObject:model.typetxt forKey:@"typetxt"];
        [[NSUserDefaults standardUserDefaults] setObject:model.account forKey:@"account"];
        [[NSUserDefaults standardUserDefaults] setObject:model.signin forKey:@"signin"];
        [[NSUserDefaults standardUserDefaults] setObject:model.relation forKey:@"relation"];
        [self startPersonInfo];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)clearPersonInfo{
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"typetxt"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"account"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"signin"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"relation"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"email"];
}

-(void)startPersonInfo{
    self.token =  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    self.mineInfo = [[MineInfo alloc]init];
    self.mineInfo.notice = @"0";
    self.mineInfo.uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    self.mineInfo.type = [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
    self.mineInfo.avatar = [[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"];
    self.mineInfo.typetxt = [[NSUserDefaults standardUserDefaults] objectForKey:@"typetxt"];
    self.mineInfo.account = [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    self.mineInfo.signin = [[NSUserDefaults standardUserDefaults] objectForKey:@"signin"];
    self.mineInfo.relation = [[NSUserDefaults standardUserDefaults] objectForKey:@"relation"];
}


-(void)getBaseInfoSuccess:(nonnull void(^)(BaseInfo *model))success
                  failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance]POST:@"/user/info" parameters:@{} progress:^(double progress) {
    } success:^(id  _Nullable responseObject) {
        BaseInfo *model = [YYXYNetworking analysisModelFromJSONModel:[BaseInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}


-(void)uploadBaseInfoAvatar:(NSData *)data
                    Success:(nonnull void(^)(BaseInfo *model))success
                    failure:(nullable Failure)failure{
   
    [[YYXYNetworking sharedInstance] uploadEnclosure:@{@"avatar":data} apiName:@"/user/saveinfo" parameters:@{} progress:^(double progress) {
        NSLog(@"气球🎈%f",progress);
    } success:^(id  _Nullable responseObject) {
        BaseInfo *model = [YYXYNetworking analysisModelFromJSONModel:[BaseInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        
    }];
}

-(void)uploadBaseInfoGender:(NSString *)gender
                    Success:(nonnull void(^)(BaseInfo *model))success
                    failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/user/saveinfo" parameters:@{@"gender":gender} progress:nil success:^(id  _Nullable responseObject) {
        BaseInfo *model = [YYXYNetworking analysisModelFromJSONModel:[BaseInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)uploadBaseInfoBirthday:(NSString *)birthday
                      Success:(nonnull void(^)(BaseInfo *model))success
                      failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/user/saveinfo" parameters:@{@"birthday":birthday} progress:nil success:^(id  _Nullable responseObject) {
        BaseInfo *model = [YYXYNetworking analysisModelFromJSONModel:[BaseInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)uploadAddressInfoProvince:(NSString *)province
                            city:(NSString *)city
                        district:(NSString *)district
                         Success:(nonnull void(^)(BaseInfo *model))success
                         failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/user/saveinfo" parameters:@{@"province":province,@"city":city,@"district":district} progress:nil success:^(id  _Nullable responseObject) {
        BaseInfo *model = [YYXYNetworking analysisModelFromJSONModel:[BaseInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)uploadBaseInfoJobpost:(NSString *)jobpost
                     Success:(nonnull void(^)(BaseInfo *model))success
                     failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/user/saveinfo" parameters:@{@"jobpost":jobpost} progress:nil success:^(id  _Nullable responseObject) {
        BaseInfo *model = [YYXYNetworking analysisModelFromJSONModel:[BaseInfo class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}
-(void)getAllJobsSuccess:(nonnull void(^)(id model))success
                 failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/common/jobpost" parameters:@{} progress:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)getOrderListEmail:(NSString *)email
               startTime:(NSString *)st
                 endTime:(NSString *)et
                    type:(NSString *)type
                 Success:(nonnull void(^)(void))success
                 failure:(nullable Failure)failure{
    NSDictionary *dic  = @{@"type":type,@"email":email,@"st":st,@"et":et};
    [[YYXYNetworking sharedInstance]POST:@"/order/export" parameters:dic progress:nil success:^(id  _Nullable responseObject) {
        success();
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)getAllMessage:(NSString *)page
             Success:(nonnull void(^)(MessageList *model))success
             failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/user/notice" parameters:@{@"page":page} progress:nil success:^(id  _Nullable responseObject) {
        MessageList *model = [YYXYNetworking analysisModelFromJSONModel:[MessageList class] ModelDic:responseObject];
        success(model);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

-(void)getAllAreaListSuccess:(nonnull void(^)(id model))success
                     failure:(nullable Failure)failure{
    
    [[YYXYNetworking sharedInstance] POST:@"/common/pcd" parameters:@{} progress:nil success:^(id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(id  _Nullable errorObject) {
        failure(errorObject);
    }];
}

@end
