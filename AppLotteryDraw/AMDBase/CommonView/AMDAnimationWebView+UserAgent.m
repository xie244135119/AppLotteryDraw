//
//  AMDAnimationWebView+UserAgent.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/6/20.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "AMDAnimationWebView+UserAgent.h"
#import <objc/runtime.h>
#import "MultiProjectManager.h"
#import "AASPlatformAuthorize.h"
#import "AASWebOauthAuthorize.h"
#import "YLJsBridgeSDK.h"
#import "LoginInfoStorage.h"
#import "AMDRequestService.h"


@implementation AMDAnimationWebView (UserAgent)

+ (void)load
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
//    [self exchangeSel:@selector(webviewUserAgent:) senderSel:@selector(amd_webviewUserAgent:)];
    [self exchangeSel:@selector(initWkWebView) senderSel:@selector(amd_initWkWebView)];
    [self exchangeSel:@selector(setController:) senderSel:@selector(amd_setController:)];
#pragma clang diagnostic pop
}


- (void)amd_initWkWebView
{
    [self amd_initWkWebView];
    
    // 建立WkWebView 和bridgeSDK 之间的桥接
    NSString *js = [[NSString alloc]initWithFormat:@"window.webkit.messageHandlers.%@.postMessage()",YLJsBridgeClassName];
    WKUserScript *script = [[WKUserScript alloc]initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [self.wkWebView.configuration.userContentController addUserScript:script];
    
    __weak YLJsBridgeSDK *weakSDK = [self bridgeSDK];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:weakSDK name:YLJsBridgeClassName];
    
    // 设置UserAgent
    self.extraUserAgent = [self webviewExtraUserAgent];
    
    // 设置预加载block
    __block AASPlatformAuthorize *_currentPlatformAuthorize = nil;
    __block AASWebOauthAuthorize *_currentWebOauthAuthorize = nil;
    __weak typeof(self) weakself = self;
    self.shouldStartLoad = ^BOOL(WKWebView *webView, NSURLRequest *aUrlRequest, BOOL *continueLoad) {
        
        // 执行需要的js加载
        [weakself _loadScriptWithUrl:aUrlRequest.URL
                       wkWebview:webView];
    
        // 如果来自我们官方的请求
        NSArray<NSString *> *whiteschemes_config = [LoginInfoStorage sharedStorage].configInfoModel.whiteListUrl;
        NSArray *whiteschemes_default = @[@"wdwd.com",@"maifou.com",@"mai2.cn",@"mai2.cc",@"mmai.cc",@"maimaias.cn",@"gemii.cc",@"wsaler.com"];
        whiteschemes_default = whiteschemes_config.count>0?whiteschemes_config:whiteschemes_default;
        BOOL platformAuthorize = NO;
        for (NSString *scheme in whiteschemes_default) {
            if ([aUrlRequest.URL.host containsString:scheme]) {
                platformAuthorize = YES;
                break;
            }
        }
        
        // 是否允许继续执行
        *continueLoad = !platformAuthorize;
        
        // 平台签名
        if (platformAuthorize) {
            // 未签名的情况下进入官方网址默认签名处理
            if (_currentPlatformAuthorize == nil) {
                _currentPlatformAuthorize = [[AASPlatformAuthorize alloc]init];
                _currentPlatformAuthorize.prismAppSecret = [weakself appSecret];
                _currentPlatformAuthorize.prismAppKey = [weakself appKey];
                _currentPlatformAuthorize.presentSenderID = AMDTestPassportID;
            }
            
            // 签名不可用的时候--进入重新签名处理
            if (![_currentPlatformAuthorize isAvailableWithSign:[aUrlRequest.allHTTPHeaderFields valueForKey:@"Authorization"]]) {
                BOOL resault = [_currentPlatformAuthorize wkWebView:webView shouldStartLoadWithRequest:aUrlRequest];
                return resault;
            }
            
            // 默认进行oauth登录请求--用于第三方登录
            if ([aUrlRequest.URL.path rangeOfString:@"/oauth/authorize"].length > 0) {
                if (_currentWebOauthAuthorize == nil) {
                    _currentWebOauthAuthorize = [[AASWebOauthAuthorize alloc]init];
                    _currentWebOauthAuthorize.prismAppSecret = [weakself appSecret];
                    _currentWebOauthAuthorize.presentSenderID = AMDTestShopID;
                }
                BOOL resault = [_currentWebOauthAuthorize wkWebView:webView shouldStartLoadWithRequest:aUrlRequest];
                return resault;
            }
        }
        
        return YES;
    };
    
//    return self;
}


// 设置控制器
- (void)amd_setController:(UIViewController *)controller
{
    [self amd_setController:controller];
    
    [self bridgeSDK].operationController = (AMDRootViewController *)controller;
}



#pragma mark - private api

- (YLJsBridgeSDK *)bridgeSDK
{
    static YLJsBridgeSDK *_sdk = nil;
    if (_sdk == nil) {
        _sdk = [[[MultiProjectManager bridgeSDK] alloc]init];
    }
    return _sdk;
}


#pragma mark - 资源数据
// 当前AppSecret
- (NSString *)appSecret
{
    NSString *appSecret = nil;
    
    switch ([LoginInfoStorage sharedStorage].loginEnvironment) {
            case LoginEnvironmentSandbox:
            appSecret = [[MultiProjectManager globalConfigFile] prismAppSecret_Sandbox];
            break;
            case LoginEnvironmentStage:
            appSecret = [[MultiProjectManager globalConfigFile] prismAppSecret_Stage];
            break;
            case LoginEnvironmentProduct:
            appSecret = [[MultiProjectManager globalConfigFile] prismAppSecret];
            break;
        default:
            break;
    }
    return appSecret;
}

// appkey
- (NSString *)appKey
{
    NSString *appKey = nil;
    
    switch ([LoginInfoStorage sharedStorage].loginEnvironment) {
            case LoginEnvironmentSandbox:
            appKey = [[MultiProjectManager globalConfigFile] prismAppkey_Sandbox];
            break;
            case LoginEnvironmentStage:
            appKey = [[MultiProjectManager globalConfigFile] prismAppkey_Stage];
            break;
            case LoginEnvironmentProduct:
            appKey = [[MultiProjectManager globalConfigFile] prismAppkey];
            break;
        default:
            break;
    }
    return appKey;
}


// 扩展的UserAgent
- (NSString *)webviewExtraUserAgent
{
    NSDictionary *identifier = [[MultiProjectManager globalConfigFile] userAgent_ExtraIdentifier];
    NSMutableString *extra = [[NSMutableString alloc]init];
    if (identifier.allKeys.count > 0) {
        for (NSString *key in identifier.allKeys) {
            NSString *value = identifier[key];
            [extra appendFormat:@" %@/%@",key,value];
        }
    }
    return extra;
}


// 改变两者之间实现
+ (void)exchangeSel:(SEL)originSel senderSel:(SEL)senderSel
{
    Method orignMethod = class_getInstanceMethod([self class], originSel);
    Method senderMethod = class_getInstanceMethod([self class], senderSel);
    method_exchangeImplementations(orignMethod, senderMethod);
}




#pragma mark - http://m.xuanwonainiu.com/sp-search 内部插入js加载
// 动态插入js
- (void)_loadScriptWithUrl:(NSURL *)aUrl
                 wkWebview:(WKWebView *)wkWebView
{
    // http://wd2.wdwdcdn.com/assets/statics/js/bundle/apps_uchat_xuanwonainiu.js
    // http://m.xuanwonainiu.com/sp-search?nav=0&p=14299&searchText=&splitWord=true
    
    // 动态插入引用js
    NSString *urlhostpath = [aUrl.host stringByAppendingString:aUrl.relativePath];
    NSDictionary *allowInsertUrls = @{@"m.xuanwonainiu.com/sp-search":@"wd2.wdwdcdn.com/assets/statics/js/bundle/apps_uchat_xuanwonainiu.js",@"m.xuanwonainiu.com/sp-dlsearch":@"wd2.wdwdcdn.com/assets/statics/js/bundle/apps_uchat_xuanwonainiu.js"};
    if (![[allowInsertUrls allKeys] containsObject:urlhostpath]) {
        return;
    }
    __weak typeof(self) weakself = self;
    [allowInsertUrls enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:urlhostpath]) {
            // 先移除之前的js
            [wkWebView.configuration.userContentController removeAllUserScripts];
            
            // 加载前插入
            NSString *jspath = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/apps_uchat_xuanwonainiu.js"];
            NSString *startjs = [[NSString alloc]initWithContentsOfFile:jspath encoding:4 error:nil];
            WKUserScript *startscript = [[WKUserScript alloc]initWithSource:startjs injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
            [wkWebView.configuration.userContentController addUserScript:startscript];
            // 加载后插入
            NSString *endjs = [[NSString alloc]initWithFormat:@"__yl_loadScript('%@://%@?timestamp=%li')",aUrl.scheme,obj,(long)[weakself timeStamp]];
            WKUserScript *endscript = [[WKUserScript alloc]initWithSource:endjs injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
            [wkWebView.configuration.userContentController addUserScript:endscript];
            
            *stop = YES;
        }
    }];
}


// 1个小时内的时间戳
- (long)timeStamp
{
    NSDateComponents *component = [SSDateTool toDateComponentsFromDate:[NSDate date]];
    component.minute = 0;
    component.second = 0;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [calendar dateFromComponents:component];
    return (long)[date timeIntervalSince1970];
}







@end





