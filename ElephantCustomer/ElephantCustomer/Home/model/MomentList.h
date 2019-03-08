//
//  Moments.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol Moment <NSObject>
@end
@interface Moment : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *idname;
@property (strong, nonatomic) NSString *likes;
@end
@interface MomentList : JSONModel
@property(nonatomic, strong)NSArray <Moment> *list;
@end

NS_ASSUME_NONNULL_END
