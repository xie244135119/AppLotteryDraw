//
//  LotteryDrawResultListController.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <SSBaseKit/SSBaseKit.h>

@interface LotteryDrawResultListController : AMDRootViewController

//彩票信息
@property(nonatomic, copy)NSDictionary *lotteryInfo;

//需要刷新上个页面时候用 默认0：添加  1：删除
@property (nonatomic, copy)void(^refreashList)(NSUInteger status, NSDictionary *infoDic);

@end
