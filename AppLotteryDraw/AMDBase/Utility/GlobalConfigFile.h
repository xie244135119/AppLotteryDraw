//
//  GlobalConfigFile.h
//  AppMicroDistribution
//  全局配置文件
//  Created by SunSet on 15-12-27.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GlobalConfigFile <NSObject>

@optional
// 友盟的appkey
- (NSString *)uMengDebugAppKey;
- (NSString *)uMengReleaseAppKey;
- (NSString *)uMengShareAppKey;


#pragma mark - 推送相关
// 极光推送
- (NSString *)jPushAppKey;
- (NSString *)jPushAppKey_Dev;

// 推送的Tag
- (NSString *)jPushTag;
- (NSString *)jPushTag_Dev;
- (NSArray *)jPushTags;

#pragma mark 分享相关Key
// sharesdk的appkey
- (NSString *)shareSDKAppKey;

// 微信的appkey 以及 额外的
- (NSString *)wechatAppKey;
- (NSString *)wechatAppKey_Second;
- (NSString *)wechatAppSecret;
- (NSString *)wechatAppSecret_Second;

// qq的appkey appsecret
- (NSString *)qqAppKey;
- (NSString *)qqAppSecret;

// 新浪微博的appkey appsecret sinaRedirectUri
- (NSString *)sinaAppKey;
- (NSString *)sinaAppSecret;
- (NSString *)sinaRedirectUri;

#pragma mark - 融云AppKey
// 融云聊天服务器相关的Appkey sandbox stage 线上环境
- (NSString *)rcIMAppKey_Sandbox;
- (NSString *)rmIMAppKey_Stage;
- (NSString *)rmIMappkey;


#pragma mark - Prism AppKey
// prism平台的appkey
- (NSString *)prismAppkey;
- (NSString *)prismAppkey_Sandbox;
- (NSString *)prismAppkey_Stage;

// prism平台的appsecret
- (NSString *)prismAppSecret;
- (NSString *)prismAppSecret_Sandbox;
- (NSString *)prismAppSecret_Stage;
#pragma mark

// 热修复机制的appKey <目前已废弃>
- (NSString *)hotfixAppKey;

// 跳转回来的标识
- (NSString *)appURLScheme;

// App内部配置的UserAgent 额外的标识
//- (NSString *)userAgent_Identifier;(已废弃)             //不同类型的app标识
- (NSDictionary *)userAgent_ExtraIdentifier;        //额外的标识

#pragma mark - API配置
// passportInfo 配置的所有的数组
- (NSArray *)passportInfoTypeArry;
// 额外补充的请求参数
- (NSDictionary *)extraRequestParams;


//#pragma mark - 公用的文字提示

#pragma mark - 支付(微信和支付宝)配置
// 支付宝跳转回来的appScheme---需要配置在plist文件
- (NSString *)alipayAppScheme;
// 支付宝支付来源(source和enterprise 字段)
- (NSString *)alipayPaySource;
- (NSString *)alipayPayEnterprise;
// 微信支付来源(source和enterprise 字段)
- (NSString *)wechatPaySource;
- (NSString *)wechatPayEnterprise;
// 线下支付来源source
- (NSString *)offlinePaySource;
- (NSString *)offlinePayEnterprise;

// 云红包标识
- (NSString *)redacketURLScheme;


#pragma mark - Prism Host
// host
- (NSString *)prismHost;
- (NSString *)prismHost_Sandbox;
- (NSString *)prismHost_Stage;

// 有量domain
- (NSString *)ylURLHost;
- (NSString *)ylURLHost_Sandbox;
- (NSString *)ylURLHost_Stage;

//七鱼客户appkey
//- (NSString *)qiyuAppKey_Sandbox;
//- (NSString *)qiyuAppKey;


@end


@interface GlobalConfigFile : NSObject <GlobalConfigFile>

@end


















