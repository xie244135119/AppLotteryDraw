//
//  LoginInfoStorage.h
//  AppMicroDistribution
//  登录信息存储类
//  Created by SunSet on 16-3-24.
//  Copyright (c) 2016年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LoginInfoStorage : NSObject

//
+ (instancetype)sharedStorage;


#pragma mark - 用户信息处理
// 全局唯一的全局队列
- (dispatch_queue_t)serialQueue;


@end












