//
//  ZJPickView.m
//  Code beta2
//
//  Created by zj on 16/5/10.
//  Copyright © 2016年 王思峒. All rights reserved.
//

#import "ZJPickView.h"
//#import <RACEXTScope.h>
#import "UserModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation ZJPickView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        UIView *view    = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mScreenWidth, mScreenHeight)];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        [self addSubview:view];
        [self getDataList];
        
    }
    return self;
}
-(void)getDataList{
    [[UserModel sharedInstance] getAllAreaListSuccess:^(id  _Nonnull model) {
        [self loadAreaPlist:model];
    } failure:^(id errorObject) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",errorObject]];
    }];
}
#pragma mark-------以下是选择地址
- (void)loadAreaPlist:(NSDictionary *)dicALL{
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistPath = [bundle pathForResource:@"ZJarea" ofType:@"plist"];
    areaDic = dicALL[@"list"];
//    NSArray *components = [areaDic allKeys];
//    NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
//
//        if ([obj1 integerValue] > [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedDescending;
//        }
//
//        if ([obj1 integerValue] < [obj2 integerValue]) {
//            return (NSComparisonResult)NSOrderedAscending;
//        }
//        return (NSComparisonResult)NSOrderedSame;
//    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
    for (int i=0; i<[areaDic count]; i++) {
//        NSString *index = [sortedArray objectAtIndex:i];
        NSDictionary *model = areaDic[i];
        NSArray *tmp = [model allKeys];
        [provinceTmp addObject: [tmp objectAtIndex:0]];
    }
    
    province = [[NSArray alloc] initWithArray: provinceTmp];
    NSDictionary *firstModel = [areaDic objectAtIndex:0];
    NSString *key= [province objectAtIndex:0];
    NSArray *array = firstModel[key];
    NSDictionary *dic = array.firstObject;
    NSArray *cityArray = [dic allKeys];
//    NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
    city = [[NSArray alloc] initWithArray: cityArray];
//    NSString *selectedCity = [city objectAtIndex: 0];
    district = [[NSArray alloc] initWithArray: [dic objectForKey: [cityArray objectAtIndex:0]]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, mScreenHeight-300, mScreenWidth, 250)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];

    picker = [[UIPickerView alloc] initWithFrame: CGRectMake(0, view.frame.origin.y+40, view.frame.size.width, view.frame.size.height-40)];
    picker.backgroundColor = [UIColor whiteColor];

    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    [picker selectRow: 0 inComponent: 0 animated: YES];
  
    
    selectedProvince = [province objectAtIndex: 0];





    _button = [UIButton buttonWithType:100];
    [_button setTitle: @"确定" forState: UIControlStateNormal];
    [_button setFrame: CGRectMake(view.frame.size.width-60, 5, _button.bounds.size.width, _button.bounds.size.height)];
    [_button setTintColor: [UIColor blackColor]];
    _button.titleLabel.font = mFont(15);
//    button.enabled = NO;
    [_button addTarget: self action: @selector(buttobClicked:) forControlEvents: UIControlEventTouchUpInside];

    UIButton *buttoncancle = [UIButton buttonWithType:(100)];
    buttoncancle.tag = 3;
    buttoncancle.titleLabel.font = mFont(15);

    [buttoncancle setTitle:@"取消"forState:(UIControlStateNormal)];
    [buttoncancle setFrame: CGRectMake(30, 5, _button.bounds.size.width, _button.bounds.size.height)];
    [buttoncancle setTintColor: [UIColor blackColor]];
    [buttoncancle addTarget:self action:@selector(buttobClicked:) forControlEvents:(UIControlEventTouchUpInside)];

    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(buttoncancle.frame.size.width+buttoncancle.frame.origin.x,5 , mScreenWidth-buttoncancle.frame.origin.x-buttoncancle.frame.size.width-_button.frame.size.width-autoScaleW(30), _button.frame.size.height)];
    lable.text= @"请选择地区";
    lable.textColor = [UIColor lightGrayColor];
    lable.textAlignment= NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:14];
    [self addSubview:view];
    [self addSubview: picker];
    [view addSubview: _button];
    [view addSubview: buttoncancle];
    [view addSubview: lable];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark- button clicked

- (void) buttobClicked:(id)sender {
    
    UIButton*button = (UIButton*)sender;
    if(button.tag==3){
        self.hidden=YES;
    }else {
        NSInteger provinceIndex = [picker selectedRowInComponent: PROVINCE_COMPONENT];
        NSInteger cityIndex = [picker selectedRowInComponent: CITY_COMPONENT];
        NSInteger districtIndex = [picker selectedRowInComponent: DISTRICT_COMPONENT];
        
        NSString *provinceStr = [province objectAtIndex: provinceIndex];
        NSString *cityStr = [city objectAtIndex: cityIndex];
        NSString *districtStr = [district objectAtIndex:districtIndex];
        NSString *showMsg = [NSString stringWithFormat:@"%@%@%@", provinceStr,cityStr,districtStr];
            NSLog(@"%@",showMsg);
        if ([_delegate respondsToSelector:@selector(addressProvince:city:district:)]) {
            [_delegate addressProvince:provinceStr city:cityStr district:districtStr];
        }
    }
}



#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [province count];
    }
    else if (component == CITY_COMPONENT) {
        return [city count];
    }
    else {
        return [district count];
    }
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == PROVINCE_COMPONENT) {
        return [province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [city objectAtIndex: row];
    }
    else {
        return [district objectAtIndex: row];
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    if (component == PROVINCE_COMPONENT) {
//        _button.enabled = YES;

        selectedProvince = [province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectAtIndex:row]];
        NSArray *dic = [NSArray arrayWithArray:[tmp objectForKey: selectedProvince]];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[dic count]; i++) {
            [array addObjectsFromArray:[dic[i] allKeys]];
        }

        city = [[NSArray alloc] initWithArray: array];
//      NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        district = [[NSArray alloc] initWithArray: [dic objectAtIndex:0][[city objectAtIndex: 0]]];
        [picker reloadComponent: CITY_COMPONENT];
        [picker reloadComponent: DISTRICT_COMPONENT];
        [picker selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
      

    }
    else if (component == CITY_COMPONENT) {
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [areaDic objectAtIndex:[province indexOfObject: selectedProvince]]];
        NSArray *dic = [NSArray arrayWithArray:[tmp objectForKey: selectedProvince]];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[dic count]; i++) {
            [array addObjectsFromArray:[dic[i] allKeys]];
        }
        city = [[NSArray alloc] initWithArray: array];
        district = [[NSArray alloc] initWithArray: [dic objectAtIndex:row][[city objectAtIndex: row]]];
        [picker selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [picker reloadComponent: DISTRICT_COMPONENT];
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 81;
    }
    else if (component == CITY_COMPONENT) {
        return 101;
    }
    else {
        return 116;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [province objectAtIndex:row];
        myView.font = mFont(16);
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [city objectAtIndex:row];
        myView.font = mFont(16);
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [district objectAtIndex:row];
        myView.font = mFont(16);
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.hidden=YES;
//    _button.enabled = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
