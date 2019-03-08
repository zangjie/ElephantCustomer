//
//  MineChangeJobViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineChangeJobViewController.h"
#import <Masonry/Masonry.h>
#import "UserModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface MineChangeJobViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *changeJobTableView;
@property (nonatomic, strong)NSArray *jobArrays;
@end

@implementation MineChangeJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择职位";
    self.changeJobTableView = [UITableView new];
    self.changeJobTableView.delegate = self;
    self.changeJobTableView.dataSource  = self;
    [self.view addSubview:self.changeJobTableView];
    [self.changeJobTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self getAllJobs];
}

-(void)getAllJobs{
    [SVProgressHUD show];
    [[UserModel sharedInstance] getAllJobsSuccess:^(id  _Nonnull model) {
        [SVProgressHUD dismiss];
        self.jobArrays = model[@"list"];
        NSLog(@"%@",model[@"list"]);
        [self.changeJobTableView reloadData];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.changeJob){
        self.changeJob(self.jobArrays[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.jobArrays.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  autoScaleH(50);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.jobArrays[indexPath.row];
    cell.textLabel.textColor = darkGrayTextColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
};



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
