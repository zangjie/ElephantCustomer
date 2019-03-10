//
//  FeedbackTableViewCell.h
//  ElephantCustomer
//
//  Created by Bge on 2019/3/9.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedbackTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailTitleLabel;
@property (strong, nonatomic) UIButton *selectButton;

@end

NS_ASSUME_NONNULL_END
