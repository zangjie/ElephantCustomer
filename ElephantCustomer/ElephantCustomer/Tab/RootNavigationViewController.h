//
//  RootNavigationViewController.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootNavigationViewController : UINavigationController
@property (strong, nonatomic, readonly) NSString *selectCurrentTabNotificationName;
@property (strong, nonatomic, readonly) UIImage *normalImage;
@property (strong, nonatomic, readonly) UIImage *selectImage;
@end

NS_ASSUME_NONNULL_END
