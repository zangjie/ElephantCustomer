//
//  MessageList.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/4.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MessageList.h"

@implementation Message
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation MessageList
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
