//
//  LotteryDrawResultListView.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryModel.h"

@interface LotteryDrawResultListView : UIView

//数据源
@property (nonatomic, strong)LotteryModel *sourcesModel;

//开始刷新
@property (nonatomic, copy)void(^reafreshAction)(id collection);
//开始加载
@property (nonatomic, copy)BOOL(^loadingAction)(id collection);


@end
