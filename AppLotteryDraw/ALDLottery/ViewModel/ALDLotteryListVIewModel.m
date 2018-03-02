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
    
    __weak UIView *_firstBt = nil;
    __weak UIView *_lastBt = nil;
    for (int i = 0; i < sourceArray.count; i++) {
        //按钮背景
        UIView *backView = [[UIView alloc]init];
        [_currentContentView addSubview:backView];
//        backView.tag = [shareTitles hash];
        //分享图片按钮
        AMDButton *shareBt = [[AMDButton alloc]init];
        shareBt.tag = i;
        shareBt.layer.cornerRadius = 25;
        shareBt.layer.masksToBounds = YES;
        [shareBt setBackgroundColor:nil forState:UIControlStateHighlighted];
        [shareBt setImage2: nil forState:UIControlStateNormal];
        [shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:shareBt];
        [shareBt.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.centerX.equalTo(shareBt.mas_centerX);
            make.centerY.equalTo(shareBt.mas_centerY);
        }];
        [shareBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@50);
            make.centerX.equalTo(backView.mas_centerX);
            make.top.equalTo(@5);
        }];
        
        //分享标题
        UILabel *titleLB = [[UILabel alloc]init];
        titleLB.text = @"ceshi";
        titleLB.tag = i;
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.font = SSFontWithName(@"", 12);
        titleLB.textColor = SSColorWithRGB(119,119,119, 1);
        [backView addSubview:titleLB];
        
        [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@15);
            make.top.equalTo(shareBt.mas_bottom).with.offset(5);
        }];
        
        NSInteger row = i/4;
        NSInteger column = i%4;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@150);
            
            // 第一个按钮不存在的时候
            if (_firstBt == nil) {
                make.top.equalTo(@10);
                make.left.equalTo(@10);
            }
            else {
                // 设置等宽度
                make.width.equalTo(_lastBt.mas_width);
                // 第一行
                if (row == 0) {
                    make.top.equalTo(_firstBt.mas_top);
                }
                else {  //其余行的时候
                    make.top.equalTo(_firstBt.mas_bottom).with.offset(15);
                }
                
                // 首列
                if (column == 0) {  make.left.equalTo(@10); }
                else {// 设置左侧约束
                    make.left.equalTo(_lastBt.mas_right).with.offset(10);
                    
                    // 末列
                    if (column == 3) {  make.right.equalTo(@-10); }
                }
            }
        }];
        
        _lastBt = backView;
        if (i == 0)  _firstBt = backView;
    }
}

- (void)clickAction:(AMDButton *)sender{
    
}
@end
