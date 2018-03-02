//
//  ALDCountryViewModel.h
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <SSBaseLib/SSBaseLib.h>
#import <SSBaseKit/SSBaseKit.h>

@interface ALDCountryViewModel : AMDBaseViewModel

// 表单
@property(nonatomic, weak) CustomTableView *tableView;
// 数据源
@property(nonatomic, strong) NSArray *sourceArry;


@end



