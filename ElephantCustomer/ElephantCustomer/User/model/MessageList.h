//
//  MessageList.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/4.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Message <NSObject>
@end
@interface Message : JSONModel
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *noti;
@end

@interface MessageList : JSONModel
@property (strong, nonatomic)NSArray <Message>* list;

@end

