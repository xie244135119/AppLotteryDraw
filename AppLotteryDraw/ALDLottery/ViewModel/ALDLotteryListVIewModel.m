//
//  ALDLotteryListVIewModel.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDLotteryListVIewModel.h"
#import <SSBaseKit/SSBaseKit.h>
#import <Masonry/Masonry.h>


@interface ALDLotteryListVIewModel()
{
    __weak AMDRootViewController *_senderController;
}
@end

@implementation ALDLotteryListVIewModel

-(void)prepareView{
    _senderController = (AMDRootViewController *)self.senderController;
    [self initContentView];
}


- (void)initContentView{
    //滚动的背景视图
    UIScrollView *scrollerView = [[UIScrollView alloc]init];
    scrollerView.layer.borderWidth = 1;
    [_senderController.contentView addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    UIView *scrollerContentView = [[UIView alloc]init];
    [scrollerView addSubview:scrollerContentView];
    
}

@end
