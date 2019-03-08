//
//  RootNavigationViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "RootNavigationViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
@interface RootNavigationViewController ()<UINavigationBarDelegate, UINavigationControllerDelegate>

@end

@implementation RootNavigationViewController

//-(NSString *)selectCurrentTabNotificationName {
//    NSAssert(NO, @"virtual method, override 'selectCurrentTabNotificationName' method in subclass, please!");
//    
//    return nil;
//}
//
//- (UIImage *)normalImage {
//    return [UIImage new];
//}
//
//- (UIImage *)selectImage {
//    return [UIImage new];
//}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.navigationBar setBarStyle:UIBarStyleBlack];
//    [self.navigationBar setBarTintColor:SYSTEM_STYLE_COLOR];
    [self.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationBar setTranslucent:NO];
    [self setDelegate:self];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
    self.modalPresentationStyle = UIModalPresentationNone;
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(selectCurrentTab:)
//                                                 name:self.selectCurrentTabNotificationName
//                                               object:nil];
    

    UINavigationBar * navigationBar = [UINavigationBar appearance];
    UIImage *image = [UIImage imageNamed:@"regist_back"] ;
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image ;
    navigationBar.backIndicatorTransitionMaskImage = image;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-2303, 0) forBarMetrics:UIBarMetricsDefault];

}

- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.selectCurrentTabNotificationName object:nil];
}
//
//- (void)selectCurrentTab:(NSNotification *)notification {
//    [self.tabBarController setSelectedViewController:self];
//
//    [self popToRootViewControllerAnimated:YES];
//}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:[HomeViewController class]]||[viewController isKindOfClass:[MineViewController class]]) {
        [self setNavigationBarHidden:YES animated:animated];
    } else {
        [self setNavigationBarHidden:NO animated:animated];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
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
