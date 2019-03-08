//
//  homeInfo.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>
NS_ASSUME_NONNULL_BEGIN
//公告
@protocol Order <NSObject>
@end
@interface Order : JSONModel
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *time;
@end
//九个按钮
@protocol Devcat <NSObject>
@end
@interface Devcat : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ico;
@end
//工程师圈子
@protocol Moments <NSObject>
@end
@interface Moments : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *idname;
@property (strong, nonatomic) NSString *likes;
@end
//首页所有数据
@interface HomeInfo : JSONModel
@property(nonatomic, strong)NSArray <Order> *order;
@property(nonatomic, strong)NSString *annc;
@property(nonatomic, strong)NSArray <Devcat> *devcat;
@property(nonatomic, strong)NSArray <Moments> *moments;
@end

NS_ASSUME_NONNULL_END
