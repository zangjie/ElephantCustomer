//
//  SerivceTableViewCell.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SerivceTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *lableTitle;
@property (nonatomic, strong)UIButton *moreButton;
@property (nonatomic, strong)void(^moreButtonVC)(void);
@end

NS_ASSUME_NONNULL_END
