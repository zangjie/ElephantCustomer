//
//  RootTabBarViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "UserModel.h"
//三个主VC
#import "HomeViewController.h"
#import "HomeNavViewController.h"
#import "MineViewController.h"
#import "MineNavViewController.h"
#import "OrderViewController.h"
#import "OrderNavViewController.h"
#import "LoginViewController.h"
@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //跳出登录页面
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginViewController) name:@"GCSkipShowLoginNotification" object:nil];
    [self.tabBar setTranslucent:NO];
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    HomeNavViewController *homeNav = [[HomeNavViewController alloc]initWithRootViewController:homeVC];
    //订单
    OrderViewController *orderVC = [[OrderViewController alloc]init];
    OrderNavViewController *orderNav = [[OrderNavViewController alloc]initWithRootViewController:orderVC];
    //我的
    MineViewController *mineVC = [[MineViewController alloc]init];
    MineNavViewController *mineNav  = [[MineNavViewController alloc]initWithRootViewController:mineVC];
    self.viewControllers = @[homeNav,orderNav,mineNav];
    //设置标题
    NSArray *imageNomal = @[@"one_home_nomal",@"one_Order_nomal",@"one_mine_nomal"];
    NSArray *imageSelect = @[@"one_home_select",@"one_Order_select",@"one_mine_select"];
    NSArray *titleString = @[@"首页",@"订单",@"我的"];
    for (int i=0; i<self.viewControllers.count; i++) {
        [self configInfo:imageNomal[i] selectImageName:imageSelect[i] Title:titleString[i] item:self.tabBar.items[i]];
    }
    [self setupTabBarColor];
    //去掉tab上的黑线
    [self.tabBar setBackgroundImage:[[UIImage alloc]init]];
    [self.tabBar setShadowImage:[[UIImage alloc]init]];
}

-(void)presentLoginViewController{
    [[UserModel sharedInstance] clearPersonInfo];
    [self presentLoginView];
}

-(void)presentLoginView{
    LoginViewController *login = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}
//判断程序的屏幕比例


-(void)configInfo:(NSString *)nomalImageName
  selectImageName:(NSString *)selectImageName
            Title:(NSString *)titleString
            item:(UITabBarItem *)item{
    UIImage *image = [[UIImage imageNamed:nomalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.image = image;
    item.selectedImage = selectedImage;
    item.title = titleString;
    
}
- (void)setupTabBarColor {
    
    // 未选中状态的标题颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                        NSForegroundColorAttributeName:[UIColor lightGrayColor]}
                                             forState:UIControlStateNormal];
    // 选中状态的标题颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                        NSForegroundColorAttributeName:[UIColor darkGrayColor]}
                                             forState:UIControlStateSelected];
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
