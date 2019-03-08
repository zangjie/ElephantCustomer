//
//  HomeProjectInfo.h
//  ElephantCustomer
//
//  Created by zj on 2019/2/28.
//  Copyright © 2019 zj. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ProjectInfo <NSObject>
@end
@interface ProjectInfo : JSONModel
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *devtype;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSString *whichday;
@end
@interface HomeProjectInfo : JSONModel
@property (nonatomic, strong) NSArray<ProjectInfo>*list;
@end

NS_ASSUME_NONNULL_END
