//
//  OrderDetailList.h
//  ElephantCustomer
//
//  Created by zj on 2019/3/5.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
/*
 "title": "贵州吉利汽车",
 "devtype": "固定分隔式低压开关柜",
 "servtags": "配合调试",
 "content": "低压动力柜与消防联动的线路整改",
 "smpics": [
 "https://newtest.epscn.net/uploads/order/2018/08/314075c3da23d76753_6929.jpg_400x400.jpg",
 "https://newtest.epscn.net/uploads/order/2018/08/232925c6632ec15dfb_4008.jpg_400x400.jpg",
 "https://newtest.epscn.net/uploads/order/2018/08/5043905c3d39c38d50c_3272.jpg_400x400.jpg"
 ],
 "lgpics": [
 "https://newtest.epscn.net/uploads/order/2018/08/314075c3da23d76753_6929.jpg",
 "https://newtest.epscn.net/uploads/order/2018/08/232925c6632ec15dfb_4008.jpg",
 "https://newtest.epscn.net/uploads/order/2018/08/5043905c3d39c38d50c_3272.jpg"
 ],
 "actfor": "山东泰开成套电器有限公司",
 "place": "贵州省贵阳市观山湖区金清大道西",
 "whichday": "2018-08-12",
 "duty": "夏工13027889521",
 "okcont": "低压动力柜与消防联动的线路整改，联系人，13027889521工程部夏工，直接跟他联系就行，他在现场",
 "prepayfee": "0.00",
 "ordfee": "1600.00",
 "owner": "芜湖翔宇电气自动化有限公司",
 "adder": "13961259813",
 "ordno": "1808245793615",
 "createtime": "2018-08-11 15:36",
 "oktime": "2018-08-16 16:56",
 "paytime": "2018-09-11 22:05",
 "paytype": "微信支付",
 "invoicestat": "未开票",
 "btn_cancel": "0",
 "btn_pay": "0",
 "btn_staff": "0",
 "staffmobile": "15295129982"*/
@interface OrderDetailList : JSONModel
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *ordstat;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *devtype;
@property (nonatomic, strong)NSString *servtags;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray *smpics;
@property (nonatomic, strong)NSArray *lgpics;
@property (nonatomic, strong)NSString *actfor;
@property (nonatomic, strong)NSString *place;
@property (nonatomic, strong)NSString *whichday;
@property (nonatomic, strong)NSString *duty;
@property (nonatomic, strong)NSString *okcont;
@property (nonatomic, strong)NSString *prepayfee;
@property (nonatomic, strong)NSString *ordfee;
@property (nonatomic, strong)NSString *owner;
@property (nonatomic, strong)NSString *adder;
@property (nonatomic, strong)NSString *ordno;
@property (nonatomic, strong)NSString *createtime;
@property (nonatomic, strong)NSString *oktime;
@property (nonatomic, strong)NSString *paytime;
@property (nonatomic, strong)NSString *paytype;
@property (nonatomic, strong)NSString *invoicestat;
@property (nonatomic, strong)NSString *btn_cancel;
@property (nonatomic, strong)NSString *btn_pay;
@property (nonatomic, strong)NSString *btn_staff;
@property (nonatomic, strong)NSString *staffmobile;
@end

NS_ASSUME_NONNULL_END
