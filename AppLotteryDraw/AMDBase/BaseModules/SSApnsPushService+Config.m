//
//  SSApnsPushService+Config.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/11/29.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "SSApnsPushService+Config.h"
#import "LoginInfoStorage.h"

@implementation SSApnsPushService (Config)


#pragma mark - SSPushConfig
// AppKey
- (NSString *)pushAppKey
{
    // 彩票开奖平台
    return @"4f2ef88c0741558123d5bccc";
}

// 测试AppKey
- (NSString *)pushAppKey_Dev
{
    return [self pushAppKey];
}

// 注册Tag
- (NSSet *)pushTags
{
    return nil;
}

- (NSSet *)pushTags_Dev
{
    return [self pushTags];
}

// 别名
- (NSString *)pushAlias
{
    return nil;
}

- (NSString *)pushAlias_Dev
{
    return [[self pushAlias] stringByAppendingString:@"_dev"];
}

- (void (^)(SSPluginActionModel *actionModel))handleAction
{
//    return ^(SSPluginActionModel *actionModel){
//        [YLJsBridgeSDK bridgeActionWithType:actionModel.action_type actionParams:actionModel.action_params];
//    };
    return nil;
}


@end






