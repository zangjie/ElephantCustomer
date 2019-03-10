//
//  Feedback.h
//  ElephantCustomer
//
//  Created by Bge on 2019/3/9.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Feedback <NSObject>

@end

@interface Feedback : JSONModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;

@end

NS_ASSUME_NONNULL_END
