//
//  AppDelegate.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserModel.h"
@interface AppDelegate ()
//当前屏幕与设计尺寸(iPhone7)宽度比例
@property(nonatomic, assign) CGFloat autoSizeScaleW;
//当前屏幕与设计尺寸(iPhone7)高度比例
@property(nonatomic, assign) CGFloat autoSizeScaleH;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initAutoScaleSize];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    RootTabBarViewController * ROOT = [[RootTabBarViewController alloc]init];
    self.window.rootViewController = ROOT;
    [self.window makeKeyAndVisible];
    //initial SVProgressHUD
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"alert_Fail"]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"alert_Success"]];
    [SVProgressHUD setMinimumDismissTimeInterval:2.0f];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[[UIColor whiteColor] colorWithAlphaComponent:.8f]]; //字体颜色
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:.8f]];   //背景颜色
    //初始化个人嘻嘻
    [[UserModel sharedInstance] startPersonInfo];
//    [[UINavigationBar appearance]setBackgroundImage:[UIImage imageNamed:@"regist_back"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"regist_back"]];
    
    return YES;
}

- (void)initAutoScaleSize{
    
    if (mScreenHeight==480) {
        //4s
        _autoSizeScaleW = mScreenWidth/375;
        _autoSizeScaleH = mScreenHeight/667;
    } else if(mScreenHeight == 568) {
        //5
        _autoSizeScaleW = mScreenWidth/375;
        _autoSizeScaleH = mScreenHeight/667;
    } else if(mScreenHeight == 667){
        //6
        _autoSizeScaleW = mScreenWidth/375;
        _autoSizeScaleH = mScreenHeight/667;
    } else if(mScreenHeight == 736){
        //6p
        _autoSizeScaleW = mScreenWidth/375;
        _autoSizeScaleH = mScreenHeight/667;
    } else {
        _autoSizeScaleW = 1;
        _autoSizeScaleH = 1;
    }
}
- (CGFloat)autoScaleW:(CGFloat)w {
    return w * self.autoSizeScaleW;
}
- (CGFloat)autoScaleH:(CGFloat)h {
    return h * self.autoSizeScaleH;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
