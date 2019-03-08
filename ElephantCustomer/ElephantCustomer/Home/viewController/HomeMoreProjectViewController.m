//
//  HomeMoreProjectViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "HomeMoreProjectViewController.h"
#import "HomeProjectTableViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HomeModel.h"
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
@interface HomeMoreProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *projectTableView;
@property (nonatomic, strong)HomeProjectInfo *model;
@property (nonatomic, strong)NSMutableArray *modelList;
@property (nonatomic, assign)int currentPage;
@end

@implementation HomeMoreProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"项目动态";
    self.currentPage =1;
    [self initliazTableView];
    [self getProjectList];
    
    
}
-(void)getProjectList{
    [SVProgressHUD show];
    
    NSLog(@"🎈%d",self.currentPage);
    [[HomeModel sharedInstance]getHomeProjectList:[NSString stringWithFormat:@"%d",self.currentPage] success:^(HomeProjectInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        if(self.currentPage>1){
            [self.modelList addObjectsFromArray:model.list];
        }else {
            self.modelList = [NSMutableArray array];
            [self.modelList addObjectsFromArray:model.list];
        }
        if(self.modelList.count>=50){
            [self.projectTableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self endRefresh];
        }
        [self.projectTableView reloadData];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
        [self endRefresh];
    }];
}
-(void)initliazTableView{
    self.projectTableView = [UITableView new];
    self.projectTableView.delegate = self;
    self.projectTableView.dataSource = self;
    self.projectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.projectTableView];
    [self.projectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //刷新
    self.projectTableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage=1;
        [self getProjectList];
    }];
    self.projectTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.currentPage++;
        [self getProjectList];
    }];
}
- (void)endRefresh {
    [self.projectTableView.mj_header endRefreshing];
    [self.projectTableView.mj_footer endRefreshing];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  autoScaleH(208);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeProjectTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"HomeProjectTableViewCell"];
    if(!cell){
        cell = [[HomeProjectTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"HomeProjectTableViewCell"];
    }
    
    cell.model = self.modelList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
