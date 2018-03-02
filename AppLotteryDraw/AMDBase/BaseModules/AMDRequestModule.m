//
//  AMDRequestModule.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/8/4.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "AMDRequestModule.h"
#import <AMDNetworkService/NSApi.h>
#import "AMDRequestService.h"
#import "MultiProjectManager.h"
#import "LoginInfoStorage.h"


@implementation AMDRequestModule



#pragma mark - SSModuleProtrol
// 注册
- (void)loadModule
{
    // 注册主机地址
#ifdef DEBUG
    // Sandbox地址
    [NSApi registerHostUrl:[NSURL URLWithString:[@"https://" stringByAppendingString:[MultiProjectManager globalConfigFile].prismHost_Sandbox]]];
#else
    [NSApi registerHostUrl:[NSURL URLWithString:[@"https://" stringByAppendingString:[MultiProjectManager globalConfigFile].prismHost]]];
#endif
    
    // 注册自定义ua
    [NSApi registerUserAgent:[[MultiProjectManager globalConfigFile] userAgent_ExtraIdentifier]];
    
    // 统一注册prismappkey
    switch (([LoginInfoStorage sharedStorage].loginEnvironment)) {
        case LoginEnvironmentSandbox:
            [NSApi registerPrismKey:[[MultiProjectManager globalConfigFile] prismAppkey_Sandbox] secret:[[MultiProjectManager globalConfigFile] prismAppSecret_Sandbox]];
            break;
        case LoginEnvironmentStage:
            [NSApi registerPrismKey:[[MultiProjectManager globalConfigFile] prismAppkey_Stage] secret:[[MultiProjectManager globalConfigFile] prismAppSecret_Stage]];
            break;
        default:       //默认线上
            [NSApi registerPrismKey:[[MultiProjectManager globalConfigFile] prismAppkey] secret:[[MultiProjectManager globalConfigFile] prismAppSecret]];
        
            break;
    }
}

// 退出--清空相关配置项
- (void)logout
{
    [NSApi registerCustomParams:nil];
}


#pragma mark - Public Api
// 配置请求的host
+ (void)configRequestHost:(NSString *)hostStr
{
    [NSApi registerHostUrl:[NSURL URLWithString:[@"https://" stringByAppendingString:hostStr]]];

    // 统一注册prismappkey
    if ([hostStr isEqualToString:[MultiProjectManager globalConfigFile].prismHost_Stage]) {
        [NSApi registerPrismKey:[[MultiProjectManager globalConfigFile] prismAppkey_Stage] secret:[[MultiProjectManager globalConfigFile] prismAppSecret_Stage]];
    }
    else if ([hostStr isEqualToString:[MultiProjectManager globalConfigFile].prismHost_Sandbox]) {
        [NSApi registerPrismKey:[[MultiProjectManager globalConfigFile] prismAppkey_Sandbox] secret:[[MultiProjectManager globalConfigFile] prismAppSecret_Sandbox]];
    }
    else {
        [NSApi registerPrismKey:[[MultiProjectManager globalConfigFile] prismAppkey] secret:[[MultiProjectManager globalConfigFile] prismAppSecret]];
    }
}

+ (void)configReuestExtraParmas:(NSDictionary *)extra
{
//    [NSApi registerCustomParams:[[MultiProjectManager globalConfigFile] extraRequestParams]];
    [NSApi registerCustomParams:extra];
}



@end









