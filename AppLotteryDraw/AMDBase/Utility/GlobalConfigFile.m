//
//  GlobalConfigFile.m
//  AppMicroDistribution
//
//  Created by SunSet on 15-12-27.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "GlobalConfigFile.h"
#import "LoginInfoStorage.h"

@implementation GlobalConfigFile

// 友盟的appkey
- (NSString *)uMengDebugAppKey
{
    return [self uMengReleaseAppKey];
}

- (NSString *)uMengReleaseAppKey
{
    return @"";
}

- (NSString *)uMengShareAppKey
{
    return [self uMengReleaseAppKey];
}

// sharesdk的appkey
- (NSString *)shareSDKAppKey
{
    return @"";
}

// 微信的appkey
- (NSString *)wechatAppKey
{
    return @"";
}

- (NSString *)wechatAppKey_Second
{
    return [self wechatAppKey];
}

- (NSString *)wechatAppSecret
{
    return @"";
}

- (NSString *)wechatAppSecret_Second
{
    return [self wechatAppSecret];
}

- (NSString *)jPushAppKey
{
    return @"";
}

- (NSString *)jPushAppKey_Dev
{
    return [self jPushAppKey];
}


- (NSString *)jPushTag
{
    return @"";
}

- (NSString *)jPushTag_Dev
{
    return [[self jPushTag] stringByAppendingString:@"_dev"];
}

- (NSArray *)jPushTags
{
    return nil;
}


// qq的appkey
- (NSString *)qqAppKey
{
    return @"";
}

- (NSString *)qqAppSecret
{
    return @"";
}

- (NSString *)rcIMAppKey_Sandbox
{
    return @"";
}

- (NSString *)rmIMAppKey_Stage
{
    return @"";
}

- (NSString *)rmIMappkey
{
    return @"";
}

- (NSString *)sinaAppKey
{
    return @"";
}

- (NSString *)sinaAppSecret
{
    return @"";
}

- (NSString *)sinaRedirectUri
{
    return @"http://www.wdwd.com";
}

- (NSString *)alipayAppScheme
{
    return @"";
}

- (NSString *)appURLScheme
{
    return @"";
}

// prism平台的appkey
- (NSString *)prismAppkey
{
    return @"";
}

- (NSString *)prismAppkey_Sandbox
{
    return @"";
}

- (NSString *)prismAppkey_Stage
{
    return @"";
}

// prism平台的appkey
- (NSString *)prismAppSecret
{
    return @"";
}

- (NSString *)prismAppSecret_Sandbox
{
    return @"";
}

- (NSString *)prismAppSecret_Stage
{
    return @"";
}

//- (NSString *)userAgent_Api
//{
//    return @"";
//}

//- (NSString *)userAgent_Identifier
//{
//    return @"";
//}

- (NSDictionary *)userAgent_ExtraIdentifier
{
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return nil;
}

- (NSString *)hotfixAppKey
{
    return @"";
}


#pragma mark - API配置
- (NSArray *)passportInfoTypeArry
{
    return @[];
}

- (NSDictionary *)extraRequestParams
{
    return nil;
}


#pragma mark - 支付相关
// 支付宝支付来源
- (NSString *)alipayPaySource
{
    return @"";
}

// 微信支付来源
- (NSString *)wechatPaySource
{
    return @"";
}

- (NSString *)alipayPayEnterprise
{
    return @"";
}

- (NSString *)wechatPayEnterprise
{
    return @"";
}


- (NSString *)offlinePaySource
{
    return @"";
}

- (NSString *)offlinePayEnterprise
{
    return @"";
}


- (NSString *)redacketURLScheme
{
    return @"";
}

//host
- (NSString *)prismHost
{
    return @"openapi.wdwd.com";
}

- (NSString *)prismHost_Sandbox
{
    return @"openapi.sandbox.wdwd.com";
}

- (NSString *)prismHost_Stage
{
    return @"openapi.stage.wdwd.com";
}

- (NSString *)ylURLHost
{
    return @"m.wdwd.com";
}

- (NSString *)ylURLHost_Sandbox
{
    return @"m.sandbox.wdwd.com";
}

- (NSString *)ylURLHost_Stage
{
    return @"m.stage.wdwd.com";
}


@end




























