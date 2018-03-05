//
//  ALDMyAttentionController.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/5.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDMyAttentionController.h"
#import "ALDMyAttentionViewModel.h"

@interface ALDMyAttentionController ()
{
    ALDMyAttentionViewModel *_viewModel;
}
@end

@implementation ALDMyAttentionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewModel];
}

- (void)initViewModel{
    self.titleView.title = @"我的关注";
    ALDMyAttentionViewModel *view = [[ALDMyAttentionViewModel alloc]init];
    view.lotteryCode = @"lotteryinfo";
    _viewModel = view;
    view.senderController = self;
    [view prepareView];
}

@end
