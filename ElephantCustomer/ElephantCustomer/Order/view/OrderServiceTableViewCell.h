//
//  OrderServiceTableViewCell.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderServiceTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *lableTitle;
@property (nonatomic, strong)UILabel *lableContent;
@property (nonatomic, assign)BOOL lableEdges;//NO为第二分区.yes为最后一个分区
@end

NS_ASSUME_NONNULL_END
