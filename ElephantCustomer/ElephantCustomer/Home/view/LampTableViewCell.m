//
//  LampTableViewCell.m
//  ElephantCustomer
//
//  Created by zj on 2019/2/25.
//  Copyright © 2019 zj. All rights reserved.
//

#import "LampTableViewCell.h"
#import <JhtMarquee/JhtVerticalMarquee.h>
#import <JhtMarquee/JhtHorizontalMarquee.h>
@implementation LampTableViewCell{
    JhtHorizontalMarquee *_horizontalMarquee;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self=[super initWithStyle:style
                 reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = UICOLOR_WITH_RGB(236, 242, 252, 1);
        [self creatUI];
        self.clipsToBounds =YES;
    };
    return self;
}
-(void)creatUI{
    UIImageView *LBImage = [[UIImageView alloc]initWithFrame:CGRectMake(autoScaleW(5), autoScaleH(5), autoScaleW(25), autoScaleH(15))];
    LBImage.contentMode = UIViewContentModeScaleAspectFit;
    LBImage.image = [UIImage imageNamed:@"one_home_horn"];
    [self addSubview:LBImage];
    [self addSubview:self.horizontalMarquee];

}
-(void)setLampString:(NSString *)lampString{
        self.horizontalMarquee.text = lampString;
       [_horizontalMarquee marqueeOfSettingWithState:MarqueeStart_H];//开启跑马灯
      //[_horizontalMarquee marqueeOfSettingWithState:MarqueeShutDown_H];//关闭跑马灯
}

- (JhtHorizontalMarquee *)horizontalMarquee {
    if (!_horizontalMarquee) {
        _horizontalMarquee = [[JhtHorizontalMarquee alloc] initWithFrame:CGRectMake(autoScaleW(35), 0, mScreenWidth, autoScaleH(25)) singleScrollDuration:0.0];
        _horizontalMarquee.tag = 100;
        _horizontalMarquee.font = mFont(12);
        _horizontalMarquee.textColor = [UIColor grayColor];
    }
    return _horizontalMarquee;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
