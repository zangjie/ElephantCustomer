//
//  MineMessageViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/4.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineMessageViewController.h"
#import "MessageTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UserModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface MineMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *messagetableView;
@property (nonatomic, strong)NSMutableArray *dataList;
@end

@implementation MineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";
    self.view.backgroundColor = [UIColor whiteColor];
    self.messagetableView = [UITableView new];
    self.messagetableView.delegate = self;
    self.messagetableView.dataSource = self;
    self.messagetableView.tableFooterView  = [UIView new];
    [self.view addSubview:self.messagetableView];
    [self.messagetableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self getMessageSoureData];
}
-(void)getMessageSoureData{
    
    [SVProgressHUD show];
    [[UserModel sharedInstance] getAllMessage:@"1" Success:^(MessageList * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.dataList = [NSMutableArray arrayWithArray:model.list];
        [self.messagetableView reloadData];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  autoScaleH(70);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[MessageTableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    Message *model = self.dataList[indexPath.row];
    cell.lableTime.text = model.date;
    cell.lableContent.text = model.noti;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
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
