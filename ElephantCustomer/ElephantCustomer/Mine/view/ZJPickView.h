//
//  ZJPickView.h
//  Code beta2
//
//  Created by zj on 16/5/10.
//  Copyright © 2016年 王思峒. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@protocol ZJPickViewDelegate <NSObject>

-(void)addressProvince:(NSString*)province
                  city:(NSString*)city
              district:(NSString*)district;

@end

@interface ZJPickView : UIView
<UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView*picker;

    
    NSMutableArray *areaDic;
    NSArray *province;
    NSArray *city;
    NSArray *district;
    
    NSString *selectedProvince;
    NSString *addressText;
}
@property (nonatomic, assign)id<ZJPickViewDelegate>delegate;
@property (nonatomic, strong) UIButton *button;
@end
