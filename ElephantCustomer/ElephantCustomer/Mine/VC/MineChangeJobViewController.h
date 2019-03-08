//
//  MineChangeJobViewController.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineChangeJobViewController : UIViewController
@property (nonatomic, copy)void(^changeJob)(NSString *jobName);
@end

NS_ASSUME_NONNULL_END
