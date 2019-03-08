//
//  HomeViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeViewController.h"
#import "NavHomeView.h"
#import "HomeTableHeadView.h"
#import "LampTableViewCell.h"
#import "SerivceTableViewCell.h"
#import "SixIndexTableViewCell.h"
#import "HomeCircleTableViewCell.h"
#import "LoginViewController.h"
#import "RootNavigationViewController.h"
#import "HomeMoreProjectViewController.h"
#import "HomeCirCleViewController.h"
#import "HomeCricleWebViewController.h"
#import "UserModel.h"
#import "HomeModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "PlaceOrderViewController.h"
//
#import <Masonry/Masonry.h>
#import "UILabel+String.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NavHomeView *navHomeView;
@property (nonatomic, strong)HomeTableHeadView *homeHeadView;
@property (nonatomic, strong)UITableView *homeTableView;
@property (nonatomic, strong)HomeInfo *homeInfo;

@end
@implementation HomeViewController

const CGFloat minNavigationHeaderViewAlpha = 0.1f;
const CGFloat maxNavigationHeaderViewAlpha = 0.9f;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = mainColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginloadHomeInfo) name:@"YYXY_loginNotification" object:nil];
    //自定义导航栏
    [self initialNavigationHeaderView];
    //首页主体tableView;
    [self initialHomeTable];
    [self getHomeInfo];
}
-(void)dealloc{
    
};
-(void)loginloadHomeInfo{
    [self getHomeInfo];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LampTableViewCell *cell  = [self.homeTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.lampString  = self.homeInfo.annc;
}
-(void )viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
-(void)getHomeInfo{
    [SVProgressHUD show];
    [[HomeModel sharedInstance] getHomeInfoSuccess:^(HomeInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",model);
        self.homeInfo = model;
        self.homeHeadView.orderlist = model.order;
//        self.homeInfo.annc =@"";
        [self.homeTableView reloadData];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}

-(void)initialNavigationHeaderView{
    self.navHomeView = [[NavHomeView alloc]initWithFrame:CGRectZero];
    self.navHomeView.backgroundColor = UICOLOR_WITH_RGB(255, 255, 255, 0);
    [self.view addSubview:self.navHomeView];
    [self.navHomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVICATION_HEADER_VIEW_HEIGHT);
    }];
}

-(void)initialHomeTable{
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    self.homeTableView.showsVerticalScrollIndicator = NO;
    self.homeTableView.showsHorizontalScrollIndicator = NO;
    self.homeTableView.delegate = self;
    self.homeTableView.dataSource = self;
    self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeHeadView = [[HomeTableHeadView alloc]initWithFrame:CGRectMake(0,0,mScreenWidth, autoScaleH(180))];
    //跳转更多项目
    WS(weakSelf);
    [self.homeHeadView setMoreProject:^{
        HomeMoreProjectViewController *moreProject = [[HomeMoreProjectViewController alloc]init];
        [weakSelf.navigationController pushViewController:moreProject animated:YES];
    }];
    [self.homeTableView setTableHeaderView:self.homeHeadView];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navHomeView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    [self.homeTableView registerClass:[LampTableViewCell class] forCellReuseIdentifier:@"LampTableViewCell"];
    [self.homeTableView registerClass:[SerivceTableViewCell class] forCellReuseIdentifier:@"SerivceTableViewCell"];
    [self.homeTableView registerClass:[SixIndexTableViewCell class] forCellReuseIdentifier:@"SixIndexTableViewCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){//跑马灯
        return 1;
    }else if(section==1){//服务需求
        return 2;
    }else {//工程师圈子
        return self.homeInfo.moments.count+1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row==0&&indexPath.section==0){//跑马灯
        if(!self.homeInfo.annc.length){
            return 0;
        }else{
            return autoScaleH(25);
        }
    }else if(indexPath.row==0){//每行第一个
        return autoScaleH(43);
    }else if(indexPath.section==1&&indexPath.row==1) {//发布
        return autoScaleH(280);
    }else{//圈子
        return autoScaleH(110);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0&&indexPath.section==0){//跑马灯
        LampTableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"LampTableViewCell" forIndexPath:indexPath];
        cell.lampString = self.homeInfo.annc;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==0) {//两个标题栏
        SerivceTableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"SerivceTableViewCell" forIndexPath:indexPath];
        if(indexPath.section == 1){
            cell.lableTitle.text = @"发起服务需求";
            cell.moreButton.hidden = YES;
        }else if(indexPath.section == 2){
            cell.lableTitle.text = @"看工程师圈子";
            cell.moreButton.hidden = NO;
            [cell setMoreButtonVC:^{
                [self pushCircleVC];
            }];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row==1&&indexPath.section==1){//发起服务需求
        SixIndexTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SixIndexTableViewCell" forIndexPath:indexPath];
        [cell setSelectIndex:^(int index) {
            NSLog(@"%d",index);
            NSArray *array = @[@"中压开关柜",@"低压开关柜",@"箱式变电站",@"中压断路器",@"综保及仪表",@"柱上开关"];
            PlaceOrderViewController *palceOrderVC = [[PlaceOrderViewController alloc]init];
            palceOrderVC.title = array[index];
            [self.navigationController pushViewController:palceOrderVC animated:YES];
        }];
        cell.model = self.homeInfo.devcat;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        HomeCircleTableViewCell*cell  = [tableView dequeueReusableCellWithIdentifier:@"HomeCircleTableViewCell"];
        if(!cell){
            cell = [[HomeCircleTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"HomeCircleTableViewCell"];
        }
        if (self.homeInfo.moments.count) {
            Moments *moment = self.homeInfo.moments[indexPath.row-1];
            [cell.lableContent setText:moment.content
                           lineSpacing:autoScaleH(4)];
            cell.lableNickName.text =moment.idname;
            [cell.imageContent sd_setImageWithURL:[NSURL URLWithString:moment.cover]
                                 placeholderImage:[UIImage imageNamed:@"place_holdImage_B"]];
            [cell.imageHeader sd_setImageWithURL:[NSURL URLWithString:moment.avatar]
                                placeholderImage:[UIImage imageNamed:@"place_holdImage_B"]];
            cell.lableGood.text = moment.likes;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
-(void)pushCircleVC{
    HomeCirCleViewController * homecircleVC = [[HomeCirCleViewController alloc]init];
    [self.navigationController pushViewController:homecircleVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2&&indexPath.row>0){
//        NSLog(@"%d",indexPath.row);
        Moments *moment = self.homeInfo.moments[indexPath.row-1];
        HomeCricleWebViewController *webVC = [[HomeCricleWebViewController alloc]init];
        webVC.urlID = moment.id;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView == self.homeTableView) {
        if (scrollView.contentOffset.y > 0) {
            //渐变成黑色
            CGFloat alpha = scrollView.contentOffset.y / NAVICATION_HEADER_VIEW_HEIGHT;
            self.navHomeView.backgroundColor = UICOLOR_WITH_RGB(255, 255, 255, alpha);
            self.navHomeView.navTitleLable.textColor = [UIColor blackColor];
            [self.navHomeView.navRigthButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            
        }else {
            //恢复
            self.navHomeView.backgroundColor = UICOLOR_WITH_RGB(255, 255, 255, 0);
            self.navHomeView.navTitleLable.textColor = [UIColor whiteColor];
            [self.navHomeView.navRigthButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        }
            [self setNeedsStatusBarAppearanceUpdate];
    }
 }
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.homeTableView.contentOffset.y > 0) {
        return UIStatusBarStyleDefault;
    }
    else {
        return UIStatusBarStyleLightContent;
    }
}



@end
