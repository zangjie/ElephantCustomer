//
//  MineAboutViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/4.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineAboutViewController.h"
#import <Masonry/Masonry.h>
@interface MineAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *aboutTableView;
@property (nonatomic, strong)NSArray *arrayTitle;
@property (nonatomic, strong)NSArray *arrayDetail;
@end

@implementation MineAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.arrayTitle = @[@"官网网站",@"官方电话",@"新浪微博",@"微信公众号",@"去AppStore评价",@"用户服务及隐私协议"];
    self.arrayDetail = @[@"new.epscn.net",@"0519-88990567",@"象与科技",@"象与科技"];
    [self initliazTableView];
}

-(void)initliazTableView{
    self.aboutTableView = [UITableView new];
    self.aboutTableView.delegate = self;
    self.aboutTableView.dataSource = self;
    self.aboutTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.aboutTableView];
    [self.aboutTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1){
        return autoScaleH(10);
    }else {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==1){
        return autoScaleH(37);
    }else {
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(10))];
    bgView.backgroundColor = backgroundGrayColor;
    return bgView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(37))];
    
    UILabel *lableVersion = [[UILabel alloc]initWithFrame:CGRectMake(0, autoScaleH(25), mScreenWidth, autoScaleW(12))];
    lableVersion.textColor = lightGrayTextColor;
    lableVersion.textAlignment = NSTextAlignmentCenter;
    lableVersion.font = mFont(12);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    lableVersion.text = [NSString stringWithFormat:@"象与电服 %@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [bgView addSubview:lableVersion];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, 0.5f)];
    line.backgroundColor = [UIColor lightGrayColor];
    [bgView addSubview:line];
    return bgView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 4;
    }else{
        return 2;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    if(indexPath.section==0){
        cell.textLabel.text = self.arrayTitle[indexPath.row];
        cell.detailTextLabel.text =  self.arrayDetail[indexPath.row];
        cell.detailTextLabel.font = mFont(15);
        cell.detailTextLabel.textColor = lightGrayTextColor;
    }else {
        cell.textLabel.text = self.arrayTitle[indexPath.row+4];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = mFont(15);
    cell.textLabel.textColor = darkGrayTextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.row==1){
        cell.detailTextLabel.font = mFont(15);
        cell.detailTextLabel.textColor = lightGrayTextColor;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        if (indexPath.row==0) {//打开官网
            [self openSafire:@"http://new.epscn.net"];
        }else if(indexPath.row==1){
            [self callPhone:@"0519-88990567"];
        }else if(indexPath.row==2){
            [self openWB];
        }else if(indexPath.row==3){
            [self copyWXnumber];
        }
    }else if(indexPath.section==1){
        
    }
}
//打开浏览器
-(void)openSafire:(NSString *)url{
    NSString *openURL = url;
    NSURL *URL = [NSURL URLWithString:openURL];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        [[UIApplication sharedApplication]openURL:URL];
    }
}
-(void)callPhone:(NSString *)phoneNumber{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
    NSString *openURL = str;
    NSURL *URL = [NSURL URLWithString:openURL];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        [[UIApplication sharedApplication]openURL:URL];
    }
}
-(void)openWB{
    
    NSString *openURL = @"sinaweibo://userinfo?uid=6579153844";
    // 如果已经安装了这个应用,就跳转
    
    NSURL *URL = [NSURL URLWithString:openURL];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:^(BOOL success) {
        }];
    } else {
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            [[UIApplication sharedApplication] openURL:URL];
        }
    }
}
//复制到黏贴板
-(void)copyWXnumber{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"cz_yyxy2017";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"已经复制了公众号'象与科技',去微信搜一搜吧" message:nil preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self openSafire:@"weixin://"];

    }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
