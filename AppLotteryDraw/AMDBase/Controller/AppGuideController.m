//
//  AppGuideController.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/8/30.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "AppGuideController.h"
#import <Masonry/Masonry.h>
#import <SSBaseKit/AMDTabbarController.h>
#import "DDMenuController.h"
#import "AMDHomeIndexController.h"
#import "AASMenuController.h"


@interface AppGuideController ()<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>
{
}
@end

@implementation AppGuideController

- (instancetype)initWithTitle:(NSString *)title titileViewShow:(BOOL)titleViewShow tabBarShow:(BOOL)tabbarshow
{
    return [super initWithTitle:title titileViewShow:NO tabBarShow:NO];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLogoView];
    [self invokeCheckAppRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 兼容ios11
- (void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
    }];
}


#pragma mark - 视图加载
// 背景
- (void)initLogoView
{
//    if (_currentViewModel == nil) {
//        _currentViewModel = [[AYEGuideViewModel alloc]init];
//        _currentViewModel.superView = self.contentView;
//    }
//    [_currentViewModel prepareViewBySuper];
//    _currentViewModel.guideImgView.frame = [self appGuideImageViewFrame];
//
//    // 加载默认图
//    NSString *startimg = [[LoginInfoStorage sharedStorage] appStartImage];
//    __weak typeof(self) weakself = self;
//    [_currentViewModel configGuideImageUrl:startimg completion:^{
//        // 加载完毕进入主页
//        [weakself loginToIndexController];
//    }];
}

// app引导视图
- (CGRect)appGuideImageViewFrame
{
    return self.view.bounds;
}



#pragma mark - 登录处理
- (void)config
{
//    __weak typeof(self) weakself = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginToIndexController) name:AMDLoginToIndexNotification object:nil];
//        // 自动登录<目前先不接>
//        [weakself autoLogin];
//    });
}



#pragma mark - AppGuideProtrol
// 进入到主页
- (void)didEnterAppIndexController
{
    // 侧边栏
    AASMenuController *leftVc = [[AASMenuController alloc]initWithTitle:nil titileViewShow:NO tabBarShow:NO];
    
    // 主页
    AMDHomeIndexController *homeVc = [[AMDHomeIndexController alloc]init];
    
    //
    DDMenuController *menuVc = [[DDMenuController alloc]initWithRootViewController:homeVc];
    [menuVc setLeftViewController:leftVc];
    [self.navigationController pushViewController:menuVc animated:YES];
    leftVc.menuVC = menuVc;
    homeVc.menuVC = menuVc;
}



#pragma mark - V2.0登录流程处理
// 自动登录流程
- (void)autoLogin
{
//    if (_loginHandle == nil) {
//        _loginHandle = [[AMDLoginHandle alloc]init];
//    }
//    // 配置access_token 用于登录其他App
//    [_loginHandle oAuthSuccess:^(NSString *accessToken) {
//        // 配置传统老一套prism的 Token
//        [AMDRequestService sharedAMDRequestService].prismIOS.prismAccessToken = accessToken;
//
//        // 配置新的Api框架令牌
//        PrismIOS *prism = [[NSApi shareInstance] valueForKey:@"prismIOS"];
//        prism.prismAccessToken = accessToken;
//    }];
//
//    // 配置登录成功的流程
//    __weak typeof(self) weakself = self;
//    [_loginHandle loginSuccess:^(NSDictionary *passportinfo) {
//        // 登录相关信息缓存
//        LoginInfoStorage *storage = [LoginInfoStorage sharedStorage];
//        [storage configPassportInfo:passportinfo];
//        [storage login];
//
//        // 昵称为空处理操作
//        if ([storage.passInfoModel.userinfo.nickname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
//            // 进入到完善个人资料页面
//            [weakself loginToPersonInfoController];
//            return;
//        }
//
//        // 启动预配置页面
//        if ([LoginInfoStorage sharedStorage].startInterestURL.length > 0) {
//            [weakself loginToConfigControllerWithUrlstr:[LoginInfoStorage sharedStorage].startInterestURL];
//            return;
//        }
//
//        // 进入App主页
//        [weakself loginToIndexController];
//    }];
//
//    // 登录失败的处理
//    [_loginHandle loginError:^(NSError *error, NSInteger requestType, NSInteger errorType) {
//        [weakself loginToLoginController];
//    }];
//
//    // 如果用户尚未登录
//    if ([_loginHandle isExpireLogin]) {
//        [self loginToLoginController];
//        return;
//    }
//    // 免登流程
//    [_loginHandle handleLogin];
}




#pragma mark - 网络请求
//获取App更新操作
- (void)invokeCheckAppRequest
{
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSDictionary *params = @{@"platform":@"ios",@"version":version};
//    NSString *urlstr = [[NSString alloc]initWithFormat:@"%@/wfx_ent/version",AMDAPPURL];
//    [[AMDRequestService sharedAMDRequestService] requestWithGetURL:urlstr parameters:params animation:NO compleiton:^(id responseObject, NSError *error) {
//        {    //检查更新
//            if ([responseObject[@"status"] isEqualToString:@"success"]) {
//                NSDictionary *data = responseObject[@"data"];
//                [[LoginInfoStorage sharedStorage] configAppInitInfo:data];
//
//                //扩展的地址--关于 帮助 统计地址
//                NSDictionary *urls = data[@"urls"];
//                if ([urls isKindOfClass:[NSDictionary class]]) {
//                    SetDefaults(AMDRecommendedPoliteURL, urls[@"recommend_url"]);
//                    SetDefaults(AMDAboutYouLiangURL, urls[@"about_url"]);
//                    SetDefaults(AMDHowToWithdrawalURL, urls[@"help_url"]);              //如何
//                    SetDefaultsSynchronize();
//                }
//            }
//            //进入首页
//            [self config];
//        }
//    }];
    
    [self performSelector:@selector(didEnterAppIndexController) withObject:nil afterDelay:0.5];
}



#pragma mark - UINavigationControllerDelegate
//
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    switch (operation) {
        case UINavigationControllerOperationPush:       //推送
        {
            //
            if ([fromVC conformsToProtocol:@protocol(UIViewControllerAnimatedTransitioning)] ) {
                return (id<UIViewControllerAnimatedTransitioning>)fromVC;
            }
            if ([toVC conformsToProtocol:@protocol(UIViewControllerAnimatedTransitioning)]) {
                return (id<UIViewControllerAnimatedTransitioning>)toVC;
            }
        }
            break;
        default:
            break;
    }
    
    return nil;
}


#pragma mark - UIViewControllerAnimatedTransitioning
//
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //    return;
    UIView *conterView = transitionContext.containerView;
    UIViewController *toVC =  [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [conterView addSubview:toVC.view];
    
    toVC.view.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.transform = CGAffineTransformMakeScale(2, 2);
        toVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        //必须添加---否则视图结束后无法操作
        fromVC.view.transform = CGAffineTransformMakeScale(1, 1);
        [transitionContext completeTransition:YES];
    }];
}


#pragma mark - UIViewControllerTransitioningDelegate---模态展示
//
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    //优化弹出登录页面的时候
    if ([source isKindOfClass:[self class]]) {
        return self;
    }
    return nil;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    //消失的时候么有动画
    return nil;
}





@end






