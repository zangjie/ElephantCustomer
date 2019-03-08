//
//  MineHeadView.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeadView : UIView
@property (nonatomic, strong)UIView *backKView;
@property (nonatomic, strong)UIImageView *imagHeadIcon;
@property (nonatomic, strong)UILabel *lableNiceName;
@property (nonatomic, strong)UILabel *lablePhone;
@property (nonatomic, strong)UIButton *buttonSign;
@property (nonatomic, strong)UILabel *lableRelation;
@property (nonatomic, copy)void(^mineBaseInfoVC)(void);
@end

NS_ASSUME_NONNULL_END
