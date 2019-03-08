//
//  HomeTableHeadView.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeTableHeadView.h"
#import <Masonry/Masonry.h>
@interface HomeTableHeadView()<UIScrollViewDelegate>
@property (nonatomic, strong)UIView *BGView;
@property (nonatomic, strong)UIScrollView*noticeScroller;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation HomeTableHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = mainColor;
        [self createView];
    }
    return self;
}
-(void)createView{
    self.BGView  = [UIView new];
    self.BGView.userInteractionEnabled = YES;
    self.BGView.backgroundColor = [UIColor whiteColor];
    self.BGView.layer.cornerRadius = 10.f;
    [self addSubview:self.BGView];
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(autoScaleH(10));
        make.right.equalTo(self).offset(autoScaleH(-10));
        make.height.mas_equalTo(autoScaleH(160));
    }];
    
    UILabel *projectActive = [UILabel new];
    projectActive.font = [UIFont boldSystemFontOfSize:autoScaleW(18)];
    projectActive.text = @"项目动态";
    projectActive.textColor = UICOLOR_WITH_RGB(52, 51, 63, 1);
    [self.BGView addSubview:projectActive];
    [projectActive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView).offset(autoScaleW(10));
        make.top.equalTo(self.BGView).offset(autoScaleH(20));
        make.height.mas_equalTo(autoScaleW(19));
    }];
    
    UIButton *moreButton  = [UIButton new];
    [moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [moreButton setTitle:@"更多" forState:(UIControlStateNormal)];
    moreButton.titleLabel.font = mFont(15);
    [moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, autoScaleW(60), 0, 0)];
    [moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, autoScaleW(20))];
    [moreButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    [moreButton setImage:[UIImage imageNamed:@"one_home_jiantou"] forState:(UIControlStateNormal)];
    [self addSubview:moreButton];
    [self.BGView addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(autoScaleH(-10));
        make.centerY.equalTo(projectActive);
        make.height.mas_equalTo(autoScaleH(35));
        make.width.mas_equalTo(autoScaleW(80));
    }];
    UIView *viewLine = [UIView new];
    viewLine.backgroundColor = [UIColor lightGrayColor];
    viewLine.alpha= 0.2f;
    [self.BGView addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BGView);
        make.height.mas_equalTo(0.5f);
        make.top.equalTo(projectActive.mas_bottom).offset(autoScaleH(15));
    }];
    
    self.noticeScroller = [[UIScrollView alloc]initWithFrame:CGRectZero];
    self.noticeScroller.delegate = self;
    [self.BGView addSubview:self.noticeScroller];
    [self.noticeScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.BGView);
        make.top.equalTo(viewLine).offset(autoScaleH(5));
        make.bottom.equalTo(self.BGView).offset(autoScaleH(-5));
    }];
    [self.noticeScroller layoutIfNeeded];
    self.currentNumber=0;
}
-(void)setOrderlist:(NSArray<Order> *)orderlist{
    _orderlist = orderlist;
    [self setInfoScroller:orderlist];
    NSTimer *timer = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(scrollerRemove) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}
-(void)scrollerRemove{
    
//    NSLog(@"%d",self.currentNumber);
    CGFloat height =self.noticeScroller.frame.size.height/3.f;
    [self.noticeScroller setContentOffset:CGPointMake(0, self.currentNumber*height) animated:YES];
    self.currentNumber++;
}
-(void)setInfoScroller:(NSArray<Order> *)array{
    CGFloat height =self.noticeScroller.frame.size.height/3.f;
    [self.noticeScroller setContentSize:CGSizeMake(self.noticeScroller.frame.size.width, height*array.count)];
    for (int i=0; i<array.count+3; i++) {
       //状态
        UILabel *lableStatus= [UILabel new];
        lableStatus.font = mFont(12);
        lableStatus.textColor = lightGrayTextColor;
        [self.noticeScroller addSubview:lableStatus];
        [lableStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.noticeScroller).offset(autoScaleH(10));
            make.height.mas_equalTo(height);
            make.top.mas_equalTo(i*height);
        }];
        if(i<array.count){
            Order *model = array[i];
            lableStatus.text = model.status;
        }else {
            Order *model = array[i-array.count];
            lableStatus.text = model.status;
        }
        //订单内容
        UILabel *lableContent= [UILabel new];
        lableContent.font = mFont(12);
        lableContent.textColor = darkGrayTextColor;
        [self.noticeScroller addSubview:lableContent];
        [lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lableStatus.mas_right).offset(autoScaleW(10));
            make.height.mas_equalTo(height);
            make.top.mas_equalTo(i*height);
//            make.right.equalTo(self.noticeScroller).offset(autoScaleW(50));
        }];
        if(i<array.count){
            Order *model = array[i];
            lableContent.text = model.title;
        }else {
            Order *model = array[i-array.count];
            lableContent.text = model.title;
        }
        //时间
        UILabel *lableTime= [UILabel new];
        lableTime.textAlignment = NSTextAlignmentRight;
        lableTime.font = mFont(12);
        lableTime.textColor = mainColor;
        [self.noticeScroller addSubview:lableTime];
        [lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(lableContent.mas_right).offset(autoScaleW(10));
            make.height.mas_equalTo(height);
            make.top.mas_equalTo(i*height);
            make.right.equalTo(self.BGView).offset(autoScaleW(-10));
        }];
        if(i<array.count){
            Order *model = array[i];
            lableTime.text = model.time;
        }else {
            Order *model = array[i-array.count];
            lableTime.text = model.time;
        }
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if(self.currentNumber>=self.orderlist.count+1){
        self.currentNumber=1;
        [self.noticeScroller setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

-(void)moreButtonAction{
    NSLog(@"更多");
    if(self.moreProject){
        self.moreProject();
    }
}


@end
