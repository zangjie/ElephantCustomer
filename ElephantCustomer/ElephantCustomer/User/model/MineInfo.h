//
//  MineInfo.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineInfo : JSONModel
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *notice;
@property (nonatomic, strong)NSString *avatar;
@property (nonatomic, strong)NSString *typetxt;
@property (nonatomic, strong)NSString *account;
@property (nonatomic, strong)NSString *signin;
@property (nonatomic, strong)NSString *relation;
@end

NS_ASSUME_NONNULL_END
