//
//  MineMessageViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineOrderViewController.h"
#import <Masonry/Masonry.h>
#import "ChooseTimeView.h"
#import "UserModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@interface MineOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong)UITableView *messagetableView;
@property (nonatomic, strong)NSArray *arrayTitle;
@property (nonatomic, strong)NSMutableDictionary *dicParam;
@end

@implementation MineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dicParam = [NSMutableDictionary dictionary];
    self.messagetableView = [UITableView new];
    self.messagetableView.delegate = self;
    self.messagetableView.dataSource = self;
    self.messagetableView.tableHeaderView = [self tableHeadViewFromSelect];
    self.messagetableView.tableFooterView = [self getFootView];
    [self.view addSubview:self.messagetableView];
    [self.messagetableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.messagetableView addGestureRecognizer:tap];
    self.arrayTitle = @[@"开始时间",@"结束时间",@"接受邮箱"];
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"DCEmail"]){
        [self.dicParam setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"DCEmail"] forKey:@"email"];
    }
}

-(void)tap:(UITapGestureRecognizer*)tap{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

-(UIView *)tableHeadViewFromSelect{
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(60))];
    UIView *selectbutton = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(50))];
    selectbutton.backgroundColor = [UIColor whiteColor];
    [BGView addSubview:selectbutton];
    //选择框
    NSArray *arr = [[NSArray alloc]initWithObjects:@"按完工时间",@"按下单时间", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:arr];
    [segment addTarget:self action:@selector(segmentAction:) forControlEvents:(UIControlEventValueChanged)];
    segment.frame = CGRectMake(0, 0, autoScaleW(305), autoScaleH(30));
    segment.center = selectbutton.center;
    [selectbutton addSubview:segment];
    [segment setTintColor:mainColor];
//    segment.backgroundColor = ;
    segment.selectedSegmentIndex = 0;
    [self.dicParam setObject:[NSString stringWithFormat:@"%ld",segment.selectedSegmentIndex+1] forKey:@"type"];
    UIView *speaView = [[UIView alloc]initWithFrame:CGRectMake(0, selectbutton.frame.size.height, mScreenWidth, autoScaleH(10))];
    speaView.backgroundColor = backgroundGrayColor;
    [BGView addSubview:speaView];
    return BGView;
}

-(UIView *)getFootView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,10, mScreenWidth, autoScaleH(274/2.f))];
//    view.backgroundColor = [UIColor redColor];
    UIButton *buttonDC  = [UIButton buttonWithType:(UIButtonTypeCustom)];
    buttonDC.backgroundColor  = mainColor;
    buttonDC.frame = CGRectMake(autoScaleW(35), autoScaleH(50), autoScaleW(305), autoScaleH(50));
    [buttonDC setTitle:@"导出" forState:(UIControlStateNormal)];
    [buttonDC setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    buttonDC.titleLabel.font = mFont(15);
    buttonDC.layer.cornerRadius =10.f;
    [buttonDC addTarget:self action:@selector(buttonDCAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:buttonDC];

    UILabel *lableDetail = [[UILabel alloc]initWithFrame:CGRectMake(autoScaleW(35),buttonDC.frame.size.height+buttonDC.frame.origin.y+autoScaleH(25), mScreenWidth-100, autoScaleW(12))];
    lableDetail.text = @"单次导出最多6个月数据";
    lableDetail.font = mFont(12);
    lableDetail.textColor = lightGrayTextColor;
    [view addSubview:lableDetail];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, 0.5f)];
    line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:line];
    
    return view;
}
-(void)segmentAction:(UISegmentedControl *)sender{
    [self.dicParam setObject:[NSString stringWithFormat:@"%ld",sender.selectedSegmentIndex+1] forKey:@"type"];
}
-(void)buttonDCAction:(UIButton *)sender{
    
    NSString *email = self.dicParam[@"email"];
    if(!email.length){
        [SVProgressHUD showErrorWithStatus:@"邮箱不能为空"];
        return;
    }
    NSString *start = self.dicParam[@"start"];
    if(!start.length){
        [SVProgressHUD showErrorWithStatus:@"开始时间不能为空"];
        return;
    }
    
    NSString *end = self.dicParam[@"end"];
    if(!end.length){
        [SVProgressHUD showErrorWithStatus:@"结束时间不能为空"];
        return;
    }
    
    [[UserModel sharedInstance] getOrderListEmail:email startTime:start endTime:end type:self.dicParam[@"type"] Success:^{
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"DCEmail"];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
};
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return autoScaleH(50);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    if(indexPath.row<2){
        cell.textLabel.text = self.arrayTitle[indexPath.row];
        cell.textLabel.font = mFont(15);
        cell.textLabel.textColor = darkGrayTextColor;
        cell.detailTextLabel.text =indexPath.row==0?self.dicParam[@"start"]:self.dicParam[@"end"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        cell.textLabel.text = self.arrayTitle[indexPath.row];
        cell.textLabel.font = mFont(15);
        cell.textLabel.textColor = darkGrayTextColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UITextField *textFiled = [UITextField new];
        textFiled.text = self.dicParam[@"email"];
        textFiled.font = mFont(15);
        textFiled.textColor = darkGrayTextColor;
        textFiled.textAlignment = NSTextAlignmentRight;
        [cell addSubview:textFiled];
        [textFiled addTarget:self action:@selector(textAction:) forControlEvents:(UIControlEventEditingChanged)];
        [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell).offset(autoScaleW(-10));
            make.top.bottom.equalTo(cell);
            make.width.mas_offset(autoScaleW(200));
        }];
    }
    return cell;
}
-(void)textAction:(UITextField*)sender{
    [self.dicParam setObject:sender.text forKey:@"email"];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    if(indexPath.row==0){
        [self getChooseTimeView:indexPath];
    }else if(indexPath.row==1){
        [self getChooseTimeView:indexPath];
    }else {
        
    }
}

- (void)getChooseTimeView:(NSIndexPath*)index{
    ChooseTimeView *chooseTimeView = [[ChooseTimeView alloc] initWithFrame:CGRectZero];
    [chooseTimeView initialControl];
    [[UIApplication sharedApplication].keyWindow addSubview:chooseTimeView];
    [chooseTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    WS(weakSelf)
    [chooseTimeView setSelectiveTime:^(NSString *date) {
        NSLog(@"%@",date);
        if(index.row==0){
            [weakSelf.dicParam setObject:date forKey:@"start"];
        }else {
            [weakSelf.dicParam setObject:date forKey:@"end"];
        }
        [weakSelf.messagetableView reloadData];
    }];
}


@end
