//
//  SSEvokeAppService+Config.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/11/29.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "SSEvokeAppService+Config.h"
#import "MultiProjectManager.h"
#import "YLJsBridgeSDK.h"

@implementation SSEvokeAppService (Config)


#pragma mark - SSEvokeConfig
//
- (NSString *)evokeUrlScheme
{
    return [[MultiProjectManager globalConfigFile] appURLScheme];
}

// 点击处理回调事件
- (void (^)(SSPluginActionModel *actionModel))handleAction
{
    __weak typeof(self) weakself = self;
    void (^action)(SSPluginActionModel *actionModel) = ^(SSPluginActionModel *actionModel){
        // 如果通过url跳转进来的
        if ([actionModel.action_url.scheme isEqualToString:[weakself evokeUrlScheme]]) {
            [weakself openUrl:actionModel.action_url];
        }
        // 通过universal link 功能的
        else{
            [weakself becomeActiveUniversalLink:actionModel.action_url];
        }
    };
    
    return action;
}



#pragma mark - private api
// 处理universal link功能
- (void)becomeActiveUniversalLink:(NSURL *)url
{
    if (url == nil) {
        // 如果没有地址的话
        return;
    }
    
    // 原始地址 http://m.sandbox.wdwd.com/native/posts?posts_id=xxx
    // 将原始地址改造成App支持的规则
    NSString *scheme = url.path;
    // 不是原始地址
    if (![scheme hasPrefix:@"/native"]) {
        return;
    }
    scheme = [scheme stringByReplacingOccurrencesOfString:@"/native/" withString:@""];
    
    NSString *actionparam = [[NSString alloc]initWithFormat:@"ylwfx:%@:%@",scheme, url.query];
    [YLJsBridgeSDK bridgeWithActionType:YLJsBridgeActionTypeNative actionParams:actionparam];
}


// 跳转页面处理
- (void)openUrl:(NSURL *)url
{
    if (url == nil) {
        return;
    }
    // 等登录成功跳转相应的页面
    NSString *urlstr = url.description;
    NSString *prefix = [[NSString alloc]initWithFormat:@"%@://",[self evokeUrlScheme]];
    urlstr = [urlstr stringByReplacingOccurrencesOfString:prefix withString:@"ylwfx:"];
    urlstr = [urlstr stringByReplacingOccurrencesOfString:@"?" withString:@":"];
    [YLJsBridgeSDK bridgeWithActionType:YLJsBridgeActionTypeNative actionParams:urlstr];
}





@end







