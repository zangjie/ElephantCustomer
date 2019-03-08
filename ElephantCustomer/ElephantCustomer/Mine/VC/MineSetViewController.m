//
//  MineSetViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/4.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineSetViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import "MineAboutViewController.h"
#import "UserModel.h"
@interface MineSetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *setTableView;
@property (nonatomic, strong)NSArray *arrayTitle;
@end

@implementation MineSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.arrayTitle = @[@"消息推送",@"清楚缓存",@"修改密码",@"关于我们"];
    [self initliazTableView];
}
-(void)initliazTableView{
    self.setTableView = [UITableView new];
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.setTableView.tableFooterView = [self  getFootView];
    [self.view addSubview:self.setTableView];
    [self.setTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(UIView *)getFootView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,10, mScreenWidth, autoScaleH(274/2.f))];
    //    view.backgroundColor = [UIColor redColor];
    UIButton *buttonDC  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonDC.backgroundColor  = mainColor;
    buttonDC.frame = CGRectMake(autoScaleW(35), autoScaleH(50), autoScaleW(305), autoScaleH(50));
    [buttonDC setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [buttonDC setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    buttonDC.titleLabel.font = mFont(15);
    buttonDC.layer.cornerRadius =10.f;
    [buttonDC addTarget:self action:@selector(buttonLoginOutAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:buttonDC];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, 0.5f)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    return view;
}
-(void)buttonLoginOutAction:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要退出登录吗?" message:nil preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancleAction];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UserModel sharedInstance] clearPersonInfo];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"GCSkipShowLoginNotification" object:nil];
    }];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.arrayTitle[indexPath.row];
    cell.textLabel.font = mFont(15);
    cell.textLabel.textColor = darkGrayTextColor;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row==1){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fMB",[self readCacheSize]];
        cell.detailTextLabel.font = mFont(15);
        cell.detailTextLabel.textColor = lightGrayTextColor;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定清楚缓存吗?" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self clearFile];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if(indexPath.row==3){
        MineAboutViewController *aboutVC = [[MineAboutViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}

#pragma mark=======缓存
-( float )readCacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return folderSize/( 1024.0 * 1024.0);
}
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

-(void)clearFile{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    //读取缓存大小
    [self.setTableView reloadData];
}
#pragma mark=======判断通知
//+ (BOOL)isUserNotificationEnable { // 判断用户是否允许接收通知
//    BOOL isEnable = NO;
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
//        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
//        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
//    } else { // iOS版本 <8.0 处理逻辑
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
//    }
//    return isEnable;
//}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
//+ (void)goToAppSystemSetting {
//    UIApplication *application = [UIApplication sharedApplication];
//    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if ([application canOpenURL:url]) {
//        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
//            [application openURL:url options:@{} completionHandler:nil];
//        } else {
//            [application openURL:url];
//        }
//    }
//}
@end
