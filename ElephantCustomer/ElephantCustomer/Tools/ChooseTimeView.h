//
//  ChooseTimeView.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseTimeView : UIView
@property (nonatomic ,assign) BOOL isShowTime;
@property (copy, nonatomic) void(^selectiveTime)(NSString *date);
- (void)initialControl ;
@end

