//
//  OrderDetailViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
//几种cell
#import "OrderProjectInfoTableViewCell.h"
#import "OrderContentTableViewCell.h"
#import "OrderServiceTableViewCell.h"
#import "OrderProjectReportTableViewCell.h"
#import "OrderReportPriceTableViewCell.h"
#import "CollectionImageTableViewCell.h"
#import "OrderProjectWebViewController.h"
//图片处理器
#import "YBIBUtilities.h"
#import "YBImageBrowserTipView.h"
#import "YBImageBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImageCollectionViewCell.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,YBImageBrowserDataSource, YBImageBrowserDelegate>
@property (nonatomic, strong)OrderDetailList *model;
@property (nonatomic, strong)UITableView *orderDetailTableView;
@property (nonatomic, assign)BOOL isShow;//来判断是否展开最后一个分区
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initliazTableView];
    [self getOrderInfo];
}
-(void)createUIfootView{
    UIView *BGview = [UIView new];
    BGview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BGview];
    [BGview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        if(IS_IPHONE_X){
            make.height.mas_offset(autoScaleH(72));
        }else {
            make.height.mas_offset(autoScaleH(50));
        }
    }];
    UIButton *buttonService = [UIButton new];
    [buttonService setTitle:@"联系客服" forState:(UIControlStateNormal)];
    buttonService.titleLabel.font = mFont(15);
    buttonService.titleLabel.textColor = [UIColor whiteColor];
    buttonService.layer.cornerRadius = autoScaleW(10.f);
    [BGview addSubview:buttonService];
    buttonService.backgroundColor = darkGrayTextColor;
    [buttonService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(autoScaleW(-10));
        make.centerY.equalTo(BGview);
        make.width.mas_offset(autoScaleW(95));
        make.height.mas_offset(autoScaleH(35));
    }];
    UIButton *buttonCancle = [UIButton new];
    buttonCancle.backgroundColor = lightGrayTextColor;
    [buttonCancle setTitle:@"取消" forState:(UIControlStateNormal)];
    buttonCancle.titleLabel.font = mFont(15);
    buttonCancle.titleLabel.textColor = [UIColor whiteColor];
    buttonCancle.layer.cornerRadius = autoScaleW(10.f);
    [BGview addSubview:buttonCancle];
    [buttonCancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buttonService.mas_left).offset(autoScaleW(-10));
        make.centerY.equalTo(BGview);
        make.width.mas_offset(autoScaleW(95));
        make.height.mas_offset(autoScaleH(35));
    }];
    if([self.model.ordstat isEqualToString:@"3"]){
        buttonCancle.hidden = YES;
    }else if([self.model.ordstat isEqualToString:@"4"]){
        [buttonCancle setTitle:@"付款" forState:(UIControlStateNormal)];
        buttonCancle.backgroundColor = mainColor;
    }else if([self.model.ordstat isEqualToString:@"5"]){
        BGview.hidden = YES;
    }
    
}
- (void)showBrowserForSimpleCaseWithIndex:(NSInteger)index {
    
    NSMutableArray *browserDataArr = [NSMutableArray array];
    for (int i = 0; i<self.model.lgpics.count; i++) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.url = [NSURL URLWithString:self.model.lgpics[i]];
        data.sourceObject = [self sourceObjAtIdx:i];
        [browserDataArr addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}
- (id)sourceObjAtIdx:(NSInteger)idx {
    CollectionImageTableViewCell *collectionCell = [self.orderDetailTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)[collectionCell.collectionImgView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    return cell ? cell.imageContent : nil;
}


-(void)initliazTableView{
    self.orderDetailTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.orderDetailTableView.backgroundColor = [UIColor whiteColor];
    self.orderDetailTableView.delegate = self;
    self.orderDetailTableView.dataSource = self;
    self.orderDetailTableView.tableFooterView  = [self getFootViewFromMore];
    self.orderDetailTableView.tableHeaderView = [self getHeadViewFromTitle];
    self.orderDetailTableView.estimatedRowHeight = 200.0f;
    self.orderDetailTableView.sectionFooterHeight = 0;
    self.orderDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.orderDetailTableView];
    [self.orderDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(IS_IPHONE_X){
            make.edges.equalTo(self.view);
        }else {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(autoScaleH(-22));
        }
        
    }];
    [self.orderDetailTableView registerClass:[OrderProjectInfoTableViewCell class] forCellReuseIdentifier:@"OrderProjectInfoTableViewCell"];
    [self.orderDetailTableView registerClass:[OrderContentTableViewCell class] forCellReuseIdentifier:@"OrderContentTableViewCell"];
    [self.orderDetailTableView registerClass:[OrderProjectReportTableViewCell class] forCellReuseIdentifier:@"OrderProjectReportTableViewCell"];
    [self.orderDetailTableView registerClass:[OrderReportPriceTableViewCell class] forCellReuseIdentifier:@"OrderReportPriceTableViewCell"];
    [self.orderDetailTableView registerClass:[CollectionImageTableViewCell class] forCellReuseIdentifier:@"CollectionImageTableViewCell"];

}
-(void)getOrderInfo{
    [SVProgressHUD show];
    [[OrderModel sharedInstance] getOrderInfoListWithID:self.ID success:^(OrderDetailList * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.model = model;
        NSLog(@"%@",self.model);
        //改变订单状态
        UILabel *lable = [self.view viewWithTag:1120];
        lable.text = self.model.status;
        [self.orderDetailTableView reloadData];
        [self createUIfootView];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
//开始展示
-(UIView *)getHeadViewFromTitle{
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(60))];
    BGView.backgroundColor = mainColor;
    UILabel *lableTitle = [[UILabel alloc]initWithFrame:CGRectMake(autoScaleW(55), 0, mScreenWidth-autoScaleW(55), BGView.frame.size.height)];
    lableTitle.font = mFont(18);
    lableTitle.textColor = [UIColor whiteColor];
    lableTitle.tag = 1120;
    lableTitle.text = @"等待需方付款";
    [BGView addSubview:lableTitle];
    return BGView;
}
//结尾收起
-(UIView*)getFootViewFromMore{
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(118))];
    UIButton *buttonMore = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [buttonMore addTarget:self action:@selector(buttonMoreAction:) forControlEvents:(UIControlEventTouchUpInside)];
    buttonMore.frame = CGRectMake(0, 0, autoScaleW(73), autoScaleH(25));
    buttonMore.center = BGView.center;
    [buttonMore setImage:[UIImage imageNamed:@"order_More"] forState:(UIControlStateNormal)];
    [BGView addSubview:buttonMore];
    return BGView;
}
-(void)buttonMoreAction:(UIButton *)sender{
    self.isShow=!self.isShow;
    if(!self.isShow){
        [sender setImage:[UIImage imageNamed:@"order_More"] forState:(UIControlStateNormal)];
    }else {
        [sender setImage:[UIImage imageNamed:@"order_release"] forState:(UIControlStateNormal)];
    }
//    [self.orderDetailTableView reloadData];
    [self.orderDetailTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==4){//如果是最后一个分区 需要单独处理
        if(!self.isShow){
            return 0;
        }else {
            return 30;
        }
    }else {//其他分区的
        if((indexPath.section==0&&indexPath.row==1)||//第一分区里面的文字自适应
           (indexPath.section==1&&indexPath.row==4)){//第二分区里面的文字自适应
            return UITableViewAutomaticDimension;
        }else if(indexPath.section==0&&indexPath.row==0){
            return autoScaleH(234/2.f);
        }else if(indexPath.section==1){
            return autoScaleH(35);
        }else if(indexPath.section==3||indexPath.section==4){
            return autoScaleH(30);
        }else {
            if(indexPath.section==2&&indexPath.row==0){
                return autoScaleH(50);
            }else if(indexPath.section==0&&indexPath.row==2){
                if(self.model.smpics.count){
                    return  autoScaleH(114);
                }else {
                    return  0;
                }
            }else{
                return  autoScaleH(114);
            }
        }
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 3;
    }else if(section==1){
        return 5;
    }else if(section==2){
        return 2;
    }else if(section==3){
        return 3;
    }else {
        return 5;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(10))];
    BGView.backgroundColor = backgroundGrayColor;
    return BGView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1||section==2||section==3){
        return autoScaleH(10);
    }else {
        return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0&&indexPath.row==0){//第一分区三行
        OrderProjectInfoTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"OrderProjectInfoTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else if((indexPath.section==0&&indexPath.row==1)||//文字介绍
             (indexPath.section==1&&indexPath.row==4)){
        OrderContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderContentTableViewCell" forIndexPath:indexPath];
        cell.lableContent.text = indexPath.row==1?self.model.content:self.model.okcont;
        return cell;
    }else if(indexPath.section==2){
        if(indexPath.row==0){
            OrderProjectReportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderProjectReportTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else {
            OrderReportPriceTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"OrderReportPriceTableViewCell" forIndexPath:indexPath];
            cell.lablePirceY.text  = self.model.prepayfee;
            cell.lablePirceTotal.text  = self.model.ordfee;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if(indexPath.section==0&&indexPath.row==2){
        CollectionImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionImageTableViewCell" forIndexPath:indexPath];
        cell.arrayImageList = self.model.smpics;
        [cell setSeletIndex:^(NSIndexPath * _Nonnull index) {
            NSLog(@"%ld",(long)index.row);
            [self showBrowserForSimpleCaseWithIndex:index.row];
        }];
        return cell;
    }
    else{
        OrderServiceTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"OrderServiceTableViewCell"];
        if(!cell){
            cell = [[OrderServiceTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"OrderServiceTableViewCell"];
        }
        if(indexPath.section==1){
            if (indexPath.row==0) {
                cell.lableTitle.text = @"身份代表";
                cell.lableContent.text = self.model.actfor;
            }else if(indexPath.row==1){
                cell.lableTitle.text = @"服务地点";
                cell.lableContent.text = self.model.place;
            }else if(indexPath.row==2){
                cell.lableTitle.text = @"上门时间";
                cell.lableContent.text = self.model.whichday;
            }else if(indexPath.row==3){
                cell.lableTitle.text = @"现场联系";
                cell.lableContent.text = self.model.duty;
            }
        }else if(indexPath.section==3){
            if (indexPath.row==0) {
                cell.lableTitle.text = @"订单归属";
                cell.lableContent.text = self.model.owner;
            }else if(indexPath.row==1){
                cell.lableTitle.text = @"下单账号";
                cell.lableContent.text = self.model.adder;
            }else if(indexPath.row==2){
                cell.lableTitle.text = @"订单编号";
                cell.lableContent.text = self.model.ordno;
            }
        }else if(indexPath.section==4){
            if (indexPath.row==0) {
                cell.lableTitle.text = @"创建时间";
                cell.lableContent.text = self.model.createtime;
            }else if(indexPath.row==1){
                cell.lableTitle.text = @"完工时间";
                cell.lableContent.text = self.model.oktime;
            }else if(indexPath.row==2){
                cell.lableTitle.text = @"付款时间";
                cell.lableContent.text = self.model.paytime;
            }else if(indexPath.row==3){
                cell.lableTitle.text = @"付款方式";
                cell.lableContent.text = self.model.paytype;
            }else if(indexPath.row==4){
                cell.lableTitle.text = @"开票状态";
                cell.lableContent.text = self.model.invoicestat;
            }
        }
        if(indexPath.section==1){
            cell.lableEdges = NO;
        }else {
            cell.lableEdges = YES;
        }
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==2&&indexPath.row==0){
        OrderProjectWebViewController *orderprojectVC = [[OrderProjectWebViewController alloc]init];
        orderprojectVC.urlID = self.model.ordno;
        [self.navigationController pushViewController:orderprojectVC animated:YES];
    }
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
