//
//  LotteryDrawResultListController.m
//  AppLotteryDraw
//  抽奖结果列表页
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListController.h"
#import "LotteryDrawResultListView.h"

@interface LotteryDrawResultListController ()

@end

@implementation LotteryDrawResultListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContentView];
}

- (void)initContentView{
    LotteryDrawResultListView *view = [[LotteryDrawResultListView alloc]init];
    [self.view addSubview:view];
}

@end
