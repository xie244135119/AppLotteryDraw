//
//  LotteryDrawResultListView.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//
#import <SSBaseLib/SSBaseLib.h>
//#import <UIKit/UIKit.h>
#import "LotteryModel.h"

@interface LotteryDrawResultListViewModel :AMDBaseViewModel

//需要刷新上个页面时候用 默认0：添加  1：删除
@property (nonatomic, copy)void(^refreashList)(NSUInteger status, NSDictionary *infoDic);

@property (nonatomic, strong)NSDictionary *lotteryInfo;
//数据源
//@property (nonatomic, strong)LotteryModel *sourcesModel;
@property (nonatomic, strong)NSArray *sourceArray;

//开始刷新
@property (nonatomic, copy)void(^reafreshAction)(id collection);
//开始加载
@property (nonatomic, copy)BOOL(^loadingAction)(id collection);


@end
