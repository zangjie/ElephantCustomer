//
//  User.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/26.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : JSONModel
@property (nonatomic, strong)NSString *uid;
@property (nonatomic, strong)NSString *token;
@end

NS_ASSUME_NONNULL_END
