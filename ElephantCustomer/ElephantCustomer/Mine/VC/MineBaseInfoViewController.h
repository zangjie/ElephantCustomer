//
//  MineBaseInfoViewController.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MineBaseInfoViewControllerDelegate <NSObject>

-(void)changeHeadImageWithURL:(NSString *)imageUrl;

@end


@interface MineBaseInfoViewController : UIViewController
@property (nonatomic, assign)id<MineBaseInfoViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
