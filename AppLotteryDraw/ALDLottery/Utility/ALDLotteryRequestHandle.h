//
//  ALDLotteryRequestHandle.h
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/5.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotteryModel.h"

@interface ALDLotteryRequestHandle : NSObject


+ (instancetype)shareInstance;

/**
 当前彩种是否需要重新请求

 @param code 彩票code
 @return YES or NO
 */
//+ (BOOL)isReloadRequestWithCode:(NSString *)code;



/**
 获取彩票列表信息

 @param lotteryCode 彩种号码
 @param completion 完成事件
 */
- (void)getListWithLotteryCode:(NSString *)lotteryCode
                    completion:(void (^)(NSArray<Data> *list))completion;


@end








