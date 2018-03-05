//
//  LotteryDrawResultListController.m
//  AppLotteryDraw
//  抽奖结果列表页
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListController.h"
#import "LotteryDrawResultListViewModel.h"
#import "LotteryModel.h"
#import "ALDLotteryRequestHandle.h"

@interface LotteryDrawResultListController ()
{
   __block LotteryDrawResultListViewModel *_view;
}
@end

@implementation LotteryDrawResultListController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.titleView.title = @"开奖结果";
    self.view .backgroundColor = [UIColor whiteColor];
    [self initContentView];
     [self requestApi];
}

- (void)initContentView{
    LotteryDrawResultListViewModel *view = [[LotteryDrawResultListViewModel alloc]init];
    view.refreashList = _refreashList;
    view.lotteryInfo = self.lotteryInfo;
    __weak typeof(self) weakself = self;
    view.reafreshAction = ^(id collection) {
        [weakself requestApi];
    };
    view.loadingAction = ^BOOL(id collection) {
        return [weakself requestApi];
    };
    _view = view;
    view.senderController = self;
    [view prepareView];
}

- (BOOL)requestApi{
    [[ALDLotteryRequestHandle shareInstance] getListWithLotteryCode:self.lotteryInfo[@"lotteryCode"] completion:^(NSArray<Data> *list) {
        _view.sourceArray = list;
    }];
    return YES;
    //初始化一个session
    NSURLSession *session = [NSURLSession sharedSession];
    //通过地址得到一个url
    NSString *urlStr = [NSString stringWithFormat:@"http://f.apiplus.net/%@.json",self.lotteryInfo[@"lotteryCode"]];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        LotteryModel *model = [[LotteryModel alloc]initWithDictionary:dic];
        
        //回到主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
//            _view.sourcesModel = model;
        });
    }];
    [task resume];
    return YES;
}


@end
