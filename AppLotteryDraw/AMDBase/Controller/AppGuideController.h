//
//  AppGuideController.h
//  AppMicroDistribution
//
//  Created by SunSet on 2017/8/30.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import <SSBaseKit/SSBaseKit.h>
// 引导启动页
@protocol AppGuideProtrol<NSObject>

// 进入App首页
- (void)didEnterAppIndexController;

// App启动页大小配置
- (CGRect)appGuideImageViewFrame;

@end


@interface AppGuideController : AMDRootViewController<AppGuideProtrol>

@end
