//
//  OrderViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHeadMoveView.h"
#import "OrderListViewController.h"
#import <Masonry/Masonry.h>
@interface OrderViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)OrderHeadMoveView *orderHeaderView;
@property (nonatomic, strong)UIScrollView *orderScroller;
@property (nonatomic, strong)NSMutableArray *arrayIndex;//记录是否已经创建了下标,如果创建了就不在创建
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.arrayIndex = [NSMutableArray arrayWithCapacity:6];
    [self initlaizNav];
    [self initlaizHeadView];
    [self initlaizScrollerView];
    [self initLaizFiveViewWithIndex:0];
    [self.orderHeaderView changeColorWithIndex:0];

    
}

-(void)initLaizFiveViewWithIndex:(int)index{
    if(![self.arrayIndex containsObject:[NSString stringWithFormat:@"%d",index]]){
        [self.arrayIndex addObject:[NSString stringWithFormat:@"%d",index]];
        OrderListViewController *orderListFirst = [[OrderListViewController alloc]init];
        orderListFirst.type = (OrderType)index;
        [self addChildViewController:orderListFirst];
        orderListFirst.view.frame = CGRectMake( mScreenWidth*index, 0, mScreenWidth, self.orderScroller.frame.size.height);
        [self.orderScroller addSubview:orderListFirst.view];
    }
    
}
-(void)initlaizNav{
    self.title  = @"订单";
};
-(void)initlaizHeadView{
    self.orderHeaderView = [[OrderHeadMoveView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(50))];
    [self.view addSubview:self.orderHeaderView];
}
-(void)initlaizScrollerView{
    self.orderScroller = [UIScrollView new];
    self.orderScroller.showsVerticalScrollIndicator = NO;
    self.orderScroller.showsHorizontalScrollIndicator = NO;
    self.orderScroller.pagingEnabled= YES;
    self.orderScroller.delegate = self;
    [self.view addSubview:self.orderScroller];
    [self.orderScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderHeaderView.mas_bottom);
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    [self.orderScroller layoutIfNeeded];
    self.orderScroller.contentSize = CGSizeMake(mScreenWidth*5, self.orderScroller.contentSize.height);
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float ZWidth = (mScreenWidth-autoScaleH(20))*scrollView.contentOffset.x/scrollView.contentSize.width;
    [self.orderHeaderView.greenLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(autoScaleW(10)+ZWidth);
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int currentPage = scrollView.contentOffset.x/mScreenWidth;
    NSLog(@"%d",currentPage);
    [self initLaizFiveViewWithIndex:currentPage];
    [self.orderHeaderView changeColorWithIndex:currentPage];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
