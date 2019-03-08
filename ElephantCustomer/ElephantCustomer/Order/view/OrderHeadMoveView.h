//
//  OrderHeadMoveView.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/27.
//  Copyright © 2019 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderHeadMoveView : UIView
@property (nonatomic, strong)UIView*greenLineView;
-(void)changeColorWithIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
