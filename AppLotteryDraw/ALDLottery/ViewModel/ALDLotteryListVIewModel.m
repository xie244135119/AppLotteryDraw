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
    __weak UIView *_currentContentView; //scroller上层的背景视图 后续所有控件的背景视图
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
        make.left.right.bottom.top.offset(0);
    }];
    //内部背景视图
    UIView *scrollerContentView = [[UIView alloc]init];
    [scrollerView addSubview:scrollerContentView];
    [scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
    }];
}

-(void)setSourceArray:(NSArray *)sourceArray{
    
    
    for (int i = 0; i < sourceArray.count; i++) {
        //行
        NSInteger row = i/4;
        //列
        NSInteger column = i%4;
        //承载image和label
        UIView *backView = [[UIView alloc]init];
        backView.layer.borderWidth = 1;
        [_currentContentView addSubview:backView];
        
    }
    
    
}


@end
