//
//  AMDAdvertiseView.h
//  AppMicroDistribution
//  广告视图
//  Created by SunSet on 15-11-20.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import <SSBaseKit/SSBaseKit.h>
#import "AMDLaunchAdvertiseModel.h"

@interface AMDAdvertiseView : AMDBaseView


@property(nonatomic, copy) void (^completeBlock)(void);

// 初始化实体类
- (id)initWithModel:(AMDLaunchAdvertiseModel *)advertiseModel;

// 显示视图
- (void)show;


@end





















