//
//  ALDHomeIndexViewModel.h
//  AppLotteryDraw
//  主页
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <SSBaseLib/SSBaseLib.h>
#import <SSBaseKit/SSBaseKit.h>

@interface ALDHomeIndexViewModel : AMDBaseViewModel

//
@property(nonatomic, strong) CustomTableView *tableView;
// 彩种数据源
@property(nonatomic, strong) NSDictionary *lotteryTypeDict;


@end



