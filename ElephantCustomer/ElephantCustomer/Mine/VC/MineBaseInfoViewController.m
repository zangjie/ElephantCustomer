//
//  MineBaseInfoViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import "MineBaseInfoViewController.h"
#import "UserModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import "SelectPhotoManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ChooseTimeView.h"
#import "MineChangeJobViewController.h"
#import "ZJPickView.h"
@interface MineBaseInfoViewController ()<UITableViewDelegate,UITableViewDataSource,ZJPickViewDelegate>
@property (nonatomic, strong)UITableView *baseTableView;
@property (nonatomic, strong)NSArray *arrayTitle;
@property (nonatomic, strong)SelectPhotoManager *photoManager;
@property (nonatomic, strong)BaseInfo *model;
@property (nonatomic, strong)ZJPickView *pickView;
@end

@implementation MineBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"基本资料";
    self.view.backgroundColor  = [UIColor whiteColor];
    self.arrayTitle = @[@"性别",@"生日",@"常住",@"职位"];
    [self initliazTableView];
    [self getBaseInfo];
    [self createZJPicView];
}

-(void)getBaseInfo{
    [[UserModel sharedInstance] getBaseInfoSuccess:^(BaseInfo * _Nonnull model) {
        self.model = model;
        [self.baseTableView reloadData];
    } failure:^(id errorObject) {
        
    }];
}
-(void)initliazTableView{
    self.baseTableView = [UITableView new];
    self.baseTableView.scrollEnabled = NO;
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
    self.baseTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.baseTableView];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return autoScaleH(80);
    }else {
        return autoScaleH(50);
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else {
        return 4;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==1){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(10))];
        view.backgroundColor = backgroundGrayColor;
        return view;
    }else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, autoScaleH(10))];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    };
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1){
        return autoScaleH(10);
    }else {
        return autoScaleH(20);
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(indexPath.section ==0){//头像和个人信息
//        MineInfo *model = [UserModel sharedInstance].mineInfo;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@"place_holdImage_B"]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        CGSize itemSize = CGSizeMake(autoScaleH(60), autoScaleH(60));
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        cell.imageView.clipsToBounds = YES;
        cell.imageView.layer.cornerRadius = autoScaleH(60)/2.f;
        cell.detailTextLabel.text = @"修改头像";
    }else {
        cell.textLabel.text = self.arrayTitle[indexPath.row];
        if(indexPath.row==0){
            cell.detailTextLabel.text = self.model.gender;
        }else if(indexPath.row == 1){
            cell.detailTextLabel.text = self.model.birthday;
        }else if(indexPath.row == 2){
            if(self.model.province.length&&
               self.model.city.length&&
               self.model.district.length){
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.district];
            }
        }else if(indexPath.row == 3){
            cell.detailTextLabel.text = self.model.jobpost;
        }
    }
    cell.textLabel.textColor = darkGrayTextColor;
    cell.detailTextLabel.textColor = lightGrayTextColor;
    cell.detailTextLabel.font = mFont(15);
    cell.textLabel.font = mFont(15);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if (!_photoManager) {
            _photoManager =[[SelectPhotoManager alloc]init];
        }
        [_photoManager startSelectPhotoWithImageName:@"选择头像"];
        WS(weakSelf)
        //选取照片成功
        _photoManager.successHandle=^(SelectPhotoManager *manager,UIImage *image){
            NSData *data = UIImageJPEGRepresentation(image,10.0f) ;
            [weakSelf savAvater:data];
        };
    }else {
        if(indexPath.row == 0){//性别
            WS(weakSelf)
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改我的性别" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction: [UIAlertAction actionWithTitle: @"男" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [weakSelf saveGend:@"男"];
            }]];
            [alertController addAction: [UIAlertAction actionWithTitle: @"女" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [weakSelf saveGend:@"女"];
            }]];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else if(indexPath.row == 1){//生日
            [self getChooseTimeView];
        }else if(indexPath.row == 2){//常驻
            self.pickView.hidden = NO;
        }else if(indexPath.row == 3){//职位
          WS(weakSelf)
            MineChangeJobViewController *changJobVC = [[MineChangeJobViewController alloc]init];
            [self.navigationController pushViewController:changJobVC animated:YES];
            [changJobVC setChangeJob:^(NSString * _Nonnull jobName) {
                [weakSelf saveJob:jobName];
            }];
        }
    }
}
-(void)createZJPicView{
    self.pickView = [[ZJPickView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
    self.pickView.delegate= self;
    self.pickView.hidden = YES;
    [self.view addSubview:self.pickView];
};
-(void)addressProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    self.pickView.hidden = YES;
    [SVProgressHUD show];
    [[UserModel sharedInstance] uploadAddressInfoProvince:province city:city district:district Success:^(BaseInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.model = model;
        
        [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationNone)];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
    
}

-(void)saveJob:(NSString *)jobName{
    [SVProgressHUD show];
    [[UserModel sharedInstance] uploadBaseInfoJobpost:jobName Success:^(BaseInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.model = model;
        [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationNone)];
    } failure:^(id errorObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
- (void)getChooseTimeView {
    ChooseTimeView *chooseTimeView = [[ChooseTimeView alloc] initWithFrame:CGRectZero];
    [chooseTimeView initialControl];
    [[UIApplication sharedApplication].keyWindow addSubview:chooseTimeView];
    [chooseTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    WS(weakSelf)
    [chooseTimeView setSelectiveTime:^(NSString *date) {
        NSLog(@"%@",date);
        [weakSelf saveBirthDay:date];
    }];
}
-(void)saveBirthDay:(NSString *)birthday{
    [SVProgressHUD show];
    [[UserModel sharedInstance] uploadBaseInfoBirthday:birthday Success:^(BaseInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.model = model;
        [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationNone)];
    } failure:^(id errorObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}

-(void)saveGend:(NSString *)sexString{
    [SVProgressHUD show];
    [[UserModel sharedInstance] uploadBaseInfoGender:sexString Success:^(BaseInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.model = model;
//        [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationNone)];
        [self.baseTableView reloadData];

    } failure:^(id errorObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
-(void)savAvater:(NSData *)date{
    [SVProgressHUD show];
    [[UserModel sharedInstance]uploadBaseInfoAvatar:date Success:^(BaseInfo * _Nonnull model) {
        [SVProgressHUD dismiss];
        self.model = model;
        [self.baseTableView reloadData];
        if(self.delegate){
            [self.delegate changeHeadImageWithURL:model.avatar];
        }
    } failure:^(id errorObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
    
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
