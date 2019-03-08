//
//  ChooseTimeView.m
//  ElephantCustomer
//
//  Created by zj on 2019/3/1.
//  Copyright © 2019 zj. All rights reserved.
//

#import "ChooseTimeView.h"
#import <Masonry/Masonry.h>
//#import "GlobalMarco.h"

@interface ChooseTimeView ()
@property (strong, nonatomic) UIDatePicker *dataPicker;
@end

@implementation ChooseTimeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initialControl {
    UIButton *lucencyButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    lucencyButton.backgroundColor = [UIColor blackColor];
    lucencyButton.alpha = 0.5;
    [lucencyButton addTarget:self action:@selector(removeChooseTimeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lucencyButton];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UICOLOR_WITH_RGB(242,242,242,1);
    [self addSubview:backgroundView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:UICOLOR_WITH_RGB(135,135,135,1) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(removeChooseTimeView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:cancelButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:mainColor forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(selectiveTimeClicked) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:confirmButton];
    
    self.dataPicker = [[UIDatePicker alloc] init];
    self.dataPicker.locale =  [NSLocale localeWithLocaleIdentifier:@"zh"];
    self.dataPicker.datePickerMode = self.isShowTime?UIDatePickerModeDateAndTime:UIDatePickerModeDate;
    self.dataPicker.backgroundColor = [UIColor whiteColor];
    
    NSDateComponents *dateComponents = [self getDateComponents];
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",dateComponents.year - 199, (long)dateComponents.month,(long)dateComponents.day];
    [self.dataPicker setMinimumDate:[self formatterDateWithDate:dateString]];
    [self.dataPicker setMaximumDate:[NSDate date]];
    
    [backgroundView addSubview:self.dataPicker];
    
    if (!self.isShowTime) {
        // 时间字符串
        NSString *string = @"1980-01-01";
        // 日期格式化类
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        // 设置日期格式(为了转换成功)
        fmt.dateFormat = @"yyyy-MM-dd";
        // NSString * -> NSDate *
        NSDate *date = [fmt dateFromString:string];
        
        [self.dataPicker setDate:date animated:YES];
    }
    
    [lucencyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(235);
    }];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.equalTo(self.dataPicker.mas_top);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(cancelButton);
        make.right.mas_equalTo(-10);
    }];
    
    [self.dataPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
}

- (void)removeChooseTimeView {
    [super removeFromSuperview];
}

- (void)selectiveTimeClicked {
    [super removeFromSuperview];
    
    NSDate *currentDate = self.dataPicker.date;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat = self.isShowTime?@"yyyy-MM-dd hh:mm":@"yyyy-MM-dd";//指定转date得日期格式化形式
    NSString *newString = [dateFormatter stringFromDate:currentDate];
    if (self.selectiveTime) {
        self.selectiveTime(newString);
    }
}

- (NSDateComponents *)getDateComponents {
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags;
    if(self.isShowTime){
        unitFlags =NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay;
        //        |NSCalendarUnitHour|NSCalendarUnitMinute;
    }else{
        unitFlags = NSCalendarUnitYear |
        NSCalendarUnitMonth |  NSCalendarUnitDay;
    }
    // 获取不同时间字段的信息
    return [gregorian components:unitFlags fromDate:[NSDate date]];
}

- (NSDate *)formatterDateWithDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:self.isShowTime?@"yyyy-MM-dd":@"yyyy-MM-dd"];
    //NSDate转NSString
    return self.isShowTime?[NSDate dateWithTimeIntervalSinceNow:-30 * 24 * 60 * 60]:[dateFormatter dateFromString:date];
}

@end
