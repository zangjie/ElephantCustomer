//
//  HomeCirCleViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeCirCleViewController.h"
#import <Masonry/Masonry.h>
#import "CircleTableViewCell.h"
#import "HomeModel.h"
#import "MomentList.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UILabel+String.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeCricleWebViewController.h"
#import <MJRefresh/MJRefresh.h>
@interface HomeCirCleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *circleTableView;
@property (nonatomic, assign)int currentPage;
@property (nonatomic, strong)NSMutableArray *dataList;
@end

@implementation HomeCirCleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"工程师圈子";
    self.currentPage = 1;
    [self initLizaTableView];
    [self getAllCircleList];
    
}
-(void)getAllCircleList{
    [SVProgressHUD show];
    [[HomeModel sharedInstance]getHomeCircleList:[NSString stringWithFormat:@"%d",self.currentPage] success:^(MomentList * _Nonnull model) {
        [SVProgressHUD dismiss];
        if (self.currentPage==1) {
            self.dataList = [NSMutableArray array];
            [self.dataList addObjectsFromArray:model.list];
        }else {
            [self.dataList addObjectsFromArray:model.list];
        }
        if(self.dataList.count%10!=0){
            [self.circleTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self endRefresh];
        }
        [self.circleTableView reloadData];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat:@"%@",errorObject]];
        [self endRefresh];
    }];
}
-(void)initLizaTableView{
    self.circleTableView = [UITableView new];
    self.circleTableView.delegate  = self;
    self.circleTableView.dataSource = self;
    self.circleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.circleTableView];
    [self.circleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //刷新
    self.circleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 1;
        [self getAllCircleList];
    }];
    self.circleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getAllCircleList];
    }];
}

- (void)endRefresh {
    [self.circleTableView.mj_header endRefreshing];
    [self.circleTableView.mj_footer endRefreshing];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CircleTableViewCell"];
    if(!cell){
        cell = [[CircleTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"CircleTableViewCell"];
    }
    if (self.dataList.count) {
        Moment *moment = self.dataList[indexPath.row];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      return autoScaleH(110);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Moment *moment = self.dataList[indexPath.row];
    HomeCricleWebViewController *webVC = [[HomeCricleWebViewController alloc]init];
    webVC.urlID =moment.id;
    [self.navigationController pushViewController:webVC animated:YES];
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
