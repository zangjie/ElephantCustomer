//
//  Moments.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MomentList.h"

@implementation Moment
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
@implementation MomentList
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
