//
//  ALDLotteryTypeModel.h
//  AppLotteryDraw
//  彩票种类
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <SSBaseLib/SSBaseLib.h>

@interface ALDLotteryTypeModel : AMDBaseModel

// 彩种名称
@property(nonatomic, copy) NSString *lotteryName;
// 彩种代码
@property(nonatomic, copy) NSString *lotteryCode;
// 彩种图片
@property(nonatomic, copy) NSString *imgName;

@end










