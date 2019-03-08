//
//  OrderListViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderListViewController.h"
#import <Masonry/Masonry.h>
#import "OrderInfoTableViewCell.h"
#import "OrderModel.h"
#import "OrderDetailViewController.h"
@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView*orderListTableView;
@property (nonatomic, strong) OrderInfo *dataModel;
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.type==OrderTypeAll){
        self.view.backgroundColor = [UIColor redColor];
    }else if(self.type==OrderTypeToBeConfirmed){
        self.view.backgroundColor = [UIColor blackColor];
    }else if(self.type == OrderTypeWaitingForTheDoor){
        self.view.backgroundColor = [UIColor blueColor];
    }else if(self.type == OrderTypeToBeCompleted){
        self.view.backgroundColor  = [UIColor yellowColor];
    }else if(self.type == OrderTypePendingPayment){
        self.view.backgroundColor = [UIColor orangeColor];
    }
    [self initLaizTableView];
    [self getOrderListData];
}

-(void)getOrderListData{
    [[OrderModel sharedInstance] getOrderListWithKW:@"" type:[NSString stringWithFormat:@"%d",(int)self.type] page:@"0" success:^(OrderInfo * _Nonnull model) {
        self.dataModel = model;
        NSLog(@"%@",self.dataModel);
        [self.orderListTableView reloadData];
    } failure:^(id errorObject) {
        
    }];
}
-(void)initLaizTableView{
    self.orderListTableView = [UITableView new];
    self.orderListTableView.delegate = self;
    self.orderListTableView.dataSource = self;
    self.orderListTableView.tableFooterView = [UIView new];
    self.orderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.orderListTableView];
    [self.orderListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return autoScaleH(243);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel.list.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderInfoTableViewCell"];
    if(!cell){
        cell = [[OrderInfoTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"OrderInfoTableViewCell"];
    }
    cell.model = self.dataModel.list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetail*model =  self.dataModel.list[indexPath.row];
    OrderDetailViewController *orderDetailVC  = [[OrderDetailViewController alloc]init];
    orderDetailVC.ID = model.id;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
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
