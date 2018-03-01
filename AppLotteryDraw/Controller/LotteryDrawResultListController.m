//
//  LotteryDrawResultListController.m
//  AppLotteryDraw
//  抽奖结果列表页
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListController.h"
#import "LotteryDrawResultListView.h"
#import "LotteryModel.h"

@interface LotteryDrawResultListController ()
{
    LotteryDrawResultListView *_view;
}
@end

@implementation LotteryDrawResultListController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self requestApi];
}

- (void)initContentViewWithSourceModel:(LotteryModel *)model{
    self.view.backgroundColor = [UIColor whiteColor];
    LotteryDrawResultListView *view = [[LotteryDrawResultListView alloc]init];
    _view = view;
    view.sourcesModel = model;
    [self.view addSubview:view];
}

- (void)requestApi{
    __weak typeof(self) weakself = self;
    //初始化一个session
    NSURLSession *session = [NSURLSession sharedSession];
    //通过地址得到一个url
    NSString *urlStr = @"http://f.apiplus.net/dlt-20.json";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        LotteryModel *model = [[LotteryModel alloc]initWithDictionary:dic];
        //回到主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself initContentViewWithSourceModel:model];
        });
    }];
    [task resume];
}


@end
