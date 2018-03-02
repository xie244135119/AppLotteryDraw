//
//  LoginInfoStorage.m
//  AppMicroDistribution
//
//  Created by SunSet on 16-3-24.
//  Copyright (c) 2016年 SunSet. All rights reserved.
//

#import "LoginInfoStorage.h"

@interface LoginInfoStorage()

@end


@implementation LoginInfoStorage


+ (instancetype)sharedStorage
{
    static LoginInfoStorage *classstorge = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        classstorge = [[[[MultiProjectManager loginInfoStorge] class] alloc] init];
    });
    return classstorge;
}


@end








