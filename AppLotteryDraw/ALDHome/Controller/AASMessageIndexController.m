//
//  AASMessageIndexController.m
//  AppAmountStore
//
//  Created by SunSet on 14-8-14.
//  Copyright (c) 2014年 SunSet. All rights reserved.
//

//NSString *const AASMessageURL = @"/nova-msg/msg";
//static NSString *const kMessageIndexCellIder = @"messageindexcell";

#import "AASMessageIndexController.h"
//#import "AASMessageTableController.h"
//#import "AASBoardTabController.h"
//#import "AASMessageChoiceView.h"

@interface AASMessageIndexController()//<AASMessageChoiceDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
//    NSInteger _currentIndex;        //当前页数
//    BOOL _isNoticeType;             //是否是通知类型
//    UIPageViewController *_pageViewController;      //当前pagecontroller
//    __weak AASMessageChoiceView *_currentMessageChoiceView;    //当前tab
    
//    NSString *_currentRequestTimeStamp;     //当前时间戳
}
//@property(nonatomic,strong) AASMessageTableController *messageTableVC;      //消息tab
//@property(nonatomic,strong) AASBoardTabController *boardTableVC;            //公告tab
@end

@implementation AASMessageIndexController

- (void)dealloc
{
//    self.messageTableVC = nil;
//    self.boardTableVC = nil;
//    _pageViewController = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self initContentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self invokeRequest];
}


#pragma mark - ******************* 初始化View *******************
//-(void)initContentView
//{
//    self.supportBackBt = YES;
//    self.titleView.title = @"消息信息";
//    // 选择 标签
//    AASMessageChoiceView *choiceView = [[AASMessageChoiceView alloc]initWithFrame:CGRectMake(0, 0, APPWidth,45) titles:@[@"通知",@"公告"]];
//    choiceView.delegate =self;
//    [self.contentView addSubview:choiceView];
//    _currentMessageChoiceView = choiceView;
//
//    //
//    self.messageTableVC = [[AASMessageTableController alloc]initWithTitle:nil titileViewShow:NO tabBarShow:NO];
//    _messageTableVC.view.frame = CGRectMake(0, 45, APPWidth, self.contentView.frame.size.height-45);
//    self.boardTableVC = [[AASBoardTabController alloc]initWithTitle:nil titileViewShow:NO tabBarShow:NO];
//    _boardTableVC.view.frame = CGRectMake(0, 45, APPWidth, self.contentView.frame.size.height-45);
//    UIPageViewController *pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    pageVC.view.frame = CGRectMake(0, 45, APPWidth, self.contentView.frame.size.height-45);
//    pageVC.dataSource = self;
//    pageVC.delegate = self;
//    [pageVC setViewControllers:@[_messageTableVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    [self addChildViewController:pageVC];
//    [self.contentView insertSubview:pageVC.view belowSubview:choiceView];
//    _pageViewController = pageVC;
//}
//
//
//#pragma mark - AASMessageChoiceDelegate
//- (void)messageChoiceView:(AASMessageChoiceView *)view sender:(UIButton *)sender
//{
//    UIViewController *VC =sender.tag==1?_messageTableVC:_boardTableVC;
//    [_pageViewController setViewControllers:@[VC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//}
//
//
//#pragma mark - UIPageViewControllerDataSource
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
//{
//    return [viewController isEqual:_messageTableVC]?_boardTableVC:_messageTableVC;
//}
//
//- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
//{
//    return [viewController isEqual:_messageTableVC]?_boardTableVC:_messageTableVC;
//}
//
//
//#pragma mark - UIPageViewControllerDelegate
//- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
//{
//    if (previousViewControllers.count > 0 && completed) {
//        BOOL noticetype = [previousViewControllers[0] isKindOfClass:[AASMessageTableController class]];
//        [_currentMessageChoiceView selectChoiceAtIndex:noticetype?2:1];
//    }
//}



@end





