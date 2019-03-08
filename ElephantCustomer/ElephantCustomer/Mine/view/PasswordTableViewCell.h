//
//  PasswordTableViewCell.h
//  ElephantCustomer
//
//  Created by Bge on 2019/3/8.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PasswordTableViewCell : UITableViewCell

@property (strong, nonatomic) NSAttributedString *placeHolderString;
@property (copy, nonatomic) void(^valueChanged)(NSString *text);

@end

NS_ASSUME_NONNULL_END
