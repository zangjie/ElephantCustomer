//
//  PlaceOrderViewController.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/7.
//  Copyright © 2019 zj. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import <Masonry/Masonry.h>
#import "ContentAndPhotoTableViewCell.h"
#import <TZImagePickerController/TZImagePickerController.h>

#import "YBIBUtilities.h"
#import "YBImageBrowserTipView.h"
#import "YBImageBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HomeImageCollectionViewCell.h"
#import "PlaceInfoTableViewCell.h"
#import "TextProjectNameTableViewCell.h"
@interface PlaceOrderViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,YBImageBrowserDataSource, YBImageBrowserDelegate>
@property (nonatomic, strong)UITableView *placeOrderTableView;
@property (nonatomic, strong)NSMutableArray *arrayPhoto;
@property (nonatomic, strong)NSMutableArray *selectedAssets;
@end

@implementation PlaceOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initlaizTableView];
}
-(void)initlaizTableView{
    self.placeOrderTableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    self.placeOrderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.placeOrderTableView.delegate = self;
    self.placeOrderTableView.tableFooterView = [UIView new];
    self.placeOrderTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.placeOrderTableView.sectionFooterHeight = 0;
    self.placeOrderTableView.sectionHeaderHeight = autoScaleH(10);
    self.placeOrderTableView.dataSource = self;
    [self.view addSubview:self.placeOrderTableView];
    [self.placeOrderTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.placeOrderTableView registerClass:[ContentAndPhotoTableViewCell class] forCellReuseIdentifier:@"ContentAndPhotoTableViewCell"];
    [self.placeOrderTableView registerClass:[PlaceInfoTableViewCell class] forCellReuseIdentifier:@"PlaceInfoTableViewCell"];
    [self.placeOrderTableView registerClass:[TextProjectNameTableViewCell class] forCellReuseIdentifier:@"TextProjectNameTableViewCell"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 2;
    }else if(section==1){
        return 3;
    }else if(section==2){
        return 2;
    }else {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return autoScaleH(60);
    }else if(indexPath.section==1){
        if(indexPath.row==0){
            return autoScaleH(50);
        }else if(indexPath.row==1){
            return autoScaleH(270/2);
        }else{
            return autoScaleH(100);
        }
    }else {
        if(indexPath.row==0){
            return autoScaleH(50);
        }else {
            return autoScaleH(60);
        }
    }
    
};

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        PlaceInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceInfoTableViewCell"];
        if(!cell){
            cell = [[PlaceInfoTableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"PlaceInfoTableViewCell"];
        }
        if(indexPath.row==0){
            cell.lableTitle.text = @"订单归属";
        }else {
            cell.lableTitle.text = @"服务范畴";
        }
        return cell;
    }else if(indexPath.section==1){
        if(indexPath.row==2){
            ContentAndPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentAndPhotoTableViewCell" forIndexPath:indexPath];
            cell.arrayImageList = self.arrayPhoto;
            [cell setSeletIndex:^(NSIndexPath * _Nonnull index) {
                if(self.arrayPhoto.count==index.item){
                    [self pushImagePickerControllerWithOption:@"photo"];
                }else {
                    [self showBrowserForSimpleCaseWithIndex:index.item];
                }
            }];
            [cell setDeleAction:^(NSInteger index) {
                [self.selectedAssets removeObjectAtIndex:index];
                [self.arrayPhoto removeObjectAtIndex:index];
                ContentAndPhotoTableViewCell *collectionCell = [self.placeOrderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                collectionCell.arrayImageList =self.arrayPhoto;
            }];
            return cell;
        }else if(indexPath.row==0){
            TextProjectNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextProjectNameTableViewCell" forIndexPath:indexPath];
            return cell;
        }else {
            TextProjectNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextProjectNameTableViewCell" forIndexPath:indexPath];
            return cell;
        }
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
        }
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
    }
}

- (void)showBrowserForSimpleCaseWithIndex:(NSInteger)index {
    
    NSMutableArray *browserDataArr = [NSMutableArray array];
    for (int i = 0; i<self.selectedAssets.count; i++) {
        YBImageBrowseCellData *data = [YBImageBrowseCellData new];
        data.phAsset = self.selectedAssets[i];
        data.sourceObject = [self sourceObjAtIdx:i];
        [browserDataArr addObject:data];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = browserDataArr;
    browser.currentIndex = index;
    [browser show];
}
- (id)sourceObjAtIdx:(NSInteger)idx {
    ContentAndPhotoTableViewCell *collectionCell = [self.placeOrderTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    HomeImageCollectionViewCell *cell = (HomeImageCollectionViewCell *)[collectionCell.collectionImgView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
    return cell ? cell.imageContent : nil;
}

- (void)pushImagePickerControllerWithOption:(NSString *)option {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:7 columnNumber:5 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.selectedAssets = self.selectedAssets;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.maxImagesCount = 6;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.showSelectBtn = YES;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
-(void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    self.arrayPhoto  = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    NSLog(@"%@",photos);
    [self.placeOrderTableView reloadData];
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
