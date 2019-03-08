//
//  UserModel.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "MineInfo.h"
#import "BaseInfo.h"
#import "MessageList.h"
NS_ASSUME_NONNULL_BEGIN
@interface UserModel : NSObject
@property (nonatomic, strong)NSString *token;
@property (nonatomic, strong)MineInfo *mineInfo;
SINGLETON_INTERFACE
//获取验证码
- (void)getCodeWithPhone:(nonnull NSString *)phone
                   event:(nullable NSString *)event
                 success:(nonnull void(^)(void))success
                 failure:(nullable Failure)failure;

//注册
//mobile    string    是    手机号
//captcha    string    是    验证码
//password string    是 密码
- (void)registWithPhone:(nonnull NSString *)phone
                   captcha:(nullable NSString *)captcha
                 password:(nullable NSString *)password
                 success:(nonnull void(^)(void))success
                 failure:(nullable Failure)failure;

//登录
- (void)loginWithPhone:(nonnull NSString *)phone
               password:(nullable NSString *)password
                success:(nonnull void(^)(void))success
                failure:(nullable Failure)failure;


//获取我的首页信息
-(void)getPersonInfosuccess:(nonnull void(^)(MineInfo *model))success
                    failure:(nullable Failure)failure;

//清除个人信息
-(void)clearPersonInfo;

//初始化本地信息
-(void)startPersonInfo;
#pragma mark------我的
-(void)getBaseInfoSuccess:(nonnull void(^)(BaseInfo *model))success
                  failure:(nullable Failure)failure;

//修改头像
-(void)uploadBaseInfoAvatar:(NSData *)data
                    Success:(nonnull void(^)(BaseInfo *model))success
                    failure:(nullable Failure)failure;
//修改性别
-(void)uploadBaseInfoGender:(NSString *)gender
                    Success:(nonnull void(^)(BaseInfo *model))success
                    failure:(nullable Failure)failure;

//修改生日
-(void)uploadBaseInfoBirthday:(NSString *)birthday
                    Success:(nonnull void(^)(BaseInfo *model))success
                    failure:(nullable Failure)failure;
//修改职业
-(void)uploadBaseInfoJobpost:(NSString *)jobpost
                      Success:(nonnull void(^)(BaseInfo *model))success
                      failure:(nullable Failure)failure;
//获取所有职业
-(void)getAllJobsSuccess:(nonnull void(^)(id model))success
                 failure:(nullable Failure)failure;
//修改省市区
-(void)uploadAddressInfoProvince:(NSString *)province
                       city:(NSString *)city
                   district:(NSString *)district
                         Success:(nonnull void(^)(BaseInfo *model))success
                         failure:(nullable Failure)failure;



//导出数据
-(void)getOrderListEmail:(NSString *)email
               startTime:(NSString *)st
                 endTime:(NSString *)et
                    type:(NSString *)type
                 Success:(nonnull void(^)(void))success
                 failure:(nullable Failure)failure;
//获取信息
-(void)getAllMessage:(NSString *)page
             Success:(nonnull void(^)(MessageList *model))success
             failure:(nullable Failure)failure;
//获取所有地址
-(void)getAllAreaListSuccess:(nonnull void(^)(id model))success
                     failure:(nullable Failure)failure;

@end

NS_ASSUME_NONNULL_END
