//
//  MineViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineViewController.h"
#import "NavHomeView.h"
#import <Masonry/Masonry.h>
#import "MineHeadView.h"
#import "UserModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MineBaseInfoViewController.h"
#import "MineOrderViewController.h"
#import "MineMessageViewController.h"
#import "MineSetViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,MineBaseInfoViewControllerDelegate>
@property (nonatomic, strong)NavHomeView *navHomeView;
@property (nonatomic, strong)UITableView *mineTableView;
@property (nonatomic, strong)MineHeadView *mineHeadView;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)NSArray *titleArray;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = backgroundGrayColor;
    [self initialNavigationHeaderView];
    [self initliaTable];
    self.titleArray = @[@"订单报表",@"我的积分",@"意见反馈",@"设置"];
   //登录以后重新刷新个人信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginloadHomeInfo) name:@"YYXY_loginNotification" object:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //TODO 1.这个界面还要做消息的红点展示和实时刷新 2.还有关联公司也要一起改变.3签到也要一起改变,只要
}
-(void)loginloadHomeInfo{
    MineInfo *model = [UserModel sharedInstance].mineInfo;
    [self.mineHeadView.imagHeadIcon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"place_holdImage_B"]];
    self.mineHeadView.lableNiceName.text = model.typetxt;
    self.mineHeadView.lablePhone.text = model.account;
    self.mineHeadView.buttonSign.selected = [model.signin isEqualToString:@"0"]?NO:YES;
    self.mineHeadView.lableRelation.text = model.relation;
}
-(void)initialNavigationHeaderView{
    self.navHomeView = [[NavHomeView alloc]initWithFrame:CGRectZero];
    self.navHomeView.backgroundColor = backgroundGrayColor;
    self.navHomeView.navTitleLable.text = @"";
    [self.navHomeView.navRigthButton setTitle:@"" forState:(UIControlStateNormal)];
    [self.navHomeView.navRigthButton setImage:[UIImage imageNamed:@"mine_message_nomal"] forState:(UIControlStateNormal)];
    [self.navHomeView.navRigthButton addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.navHomeView];
    [self.navHomeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.mas_equalTo(0);
        make.height.mas_equalTo(NAVICATION_HEADER_VIEW_HEIGHT);
    }];
}
-(void)messageAction:(UIButton *)sender{
    NSLog(@"跳转消息");
    MineMessageViewController *message = [[MineMessageViewController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}
-(void)initliaTable{
    self.mineTableView = [UITableView new];
    self.mineTableView.delegate = self;
    self.mineHeadView = [[MineHeadView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(170))];
    self.mineHeadView.backgroundColor = backgroundGrayColor;
    self.mineTableView.tableHeaderView = self.mineHeadView;
    self.mineTableView.tableFooterView = [UIView new];
    self.mineTableView.dataSource = self;
    [self.view addSubview:self.mineTableView];
    [self.mineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navHomeView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    //跳转基本资料
    WS(weakSelf)
    [self.mineHeadView setMineBaseInfoVC:^{
        MineBaseInfoViewController *mineBaseVC = [[MineBaseInfoViewController alloc]init];
        mineBaseVC.delegate = weakSelf;
        [weakSelf.navigationController pushViewController:mineBaseVC animated:YES];
    }];
}
-(void)changeHeadImageWithURL:(NSString *)imageUrl{
    [[NSUserDefaults standardUserDefaults] setObject:imageUrl forKey:@"avatar"];
    [[UserModel sharedInstance] startPersonInfo];
    [self loginloadHomeInfo];
}
//线顶头
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return autoScaleH(60);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = mFont(15);
    cell.textLabel.textColor = darkGrayTextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.height =self.mineHeadView.frame.size.height-(scrollView.contentOffset.y-self.height+self.height);
    [self.mineHeadView.backKView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(self.height);
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        MineOrderViewController *ordrVC = [[MineOrderViewController alloc]init];
        [self.navigationController pushViewController:ordrVC animated:YES];
    }else if(indexPath.row==3){
        MineSetViewController *setVC = [[MineSetViewController alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
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
