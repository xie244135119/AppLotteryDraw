//
//  ALDMyAttentionViewModel.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/5.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <SSBaseLib/SSBaseLib.h>
#import <SSBaseKit/SSBaseKit.h>

@interface ALDMyAttentionViewModel : AMDBaseViewModel

//彩票code
@property (nonatomic, copy)NSString *lotteryCode;

@property (nonatomic ,strong)CustomTableView *currentTableView;

@end
