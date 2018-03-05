//
//  AppDelegate.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/2/28.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "AppDelegate.h"
#import "AppGuideController.h"
#import <AMDNetworkService/NSApi.h>
#import <SSBaseKit/AMDWebViewController.h>

@interface AppDelegate ()<UIGestureRecognizerDelegate>
{
    SSNavigationController *_navController;         //
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    // 清空推送角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // 测试
    [self performSelector:@selector(performWebSite) withObject:nil afterDelay:10];
    
    [self loadAllModules];
    //
    [self initRootController];
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - private api
// 根视图控制
- (void)initRootController
{
    //
    AppGuideController *guideVc = [[AppGuideController alloc]init];
    SSNavigationController *navVc = [[SSNavigationController alloc]initWithRootViewController:guideVc];
    navVc.navigationBarHidden = YES;
    navVc.interactivePopGestureRecognizer.delegate = self;
    navVc.delegate = (id)guideVc;
    self.window.rootViewController = navVc;
    _navController = navVc;
}


// 加载所有的模块
- (void)loadAllModules
{
    // 注册通用的host
    [NSApi registerHostUrl:[NSURL URLWithString:@"http://f.apiplus.net"]];
}


// 10s内进入预定的网页平台
- (void)performWebSite
{
    // 临时测试
    AMDWebViewController *webVc = [[AMDWebViewController alloc]init];
    webVc.requestWithSignURL = @"http://22ypcp.com";
    [_navController pushViewController:webVc animated:YES];
}


#pragma mark - UIGestureRecognizerDelegate
//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (_navController.viewControllers.count > 2) {
        return YES;
    }
    return NO;
}


#pragma mark


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
