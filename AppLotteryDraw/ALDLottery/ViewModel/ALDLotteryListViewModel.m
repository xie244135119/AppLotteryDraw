//
//  ALDLotteryListVIewModel.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDLotteryListViewModel.h"
#import <SSBaseKit/SSBaseKit.h>
#import <Masonry/Masonry.h>
#import <UIImageView+WebCache.h>
#import "LotteryDrawResultListController.h"

@interface ALDLotteryListViewModel()
{
    __weak AMDRootViewController *_senderController;
    UIView *_currentContentView; //scroller上层的背景视图 后续所有控件的背景视图
    __weak UIScrollView *_currentScrollerView;
}
@end

@implementation ALDLotteryListViewModel

-(void)prepareView{
    _senderController = (AMDRootViewController *)self.senderController;
    [self initContentView];
}


- (void)initContentView{
    //滚动的背景视图
    UIScrollView *scrollerView = [[UIScrollView alloc]init];
    _currentScrollerView = scrollerView;
    [_senderController.contentView addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];
    //内部背景视图
    UIView *scrollerContentView = [[UIView alloc]init];
    _currentContentView = scrollerContentView;
    [scrollerView addSubview:scrollerContentView];
    [scrollerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.width.offset(SScreenWidth);
    }];
}

-(void)setSourceArray:(NSArray *)sourceArray{
    
    __weak AMDButton *_firstBt = nil;
    __weak AMDButton *_lastBt = nil;
    __block AMDButton *_upBt = nil;

    for (int i = 0; i < sourceArray.count; i++) {
        //分享图片按钮
        AMDButton *shareBt = [[AMDButton alloc]init];
        shareBt.layer.borderWidth = .5;
        shareBt.layer.cornerRadius = 5;
        shareBt.layer.borderColor = SSLineColor.CGColor;
        shareBt.tag = i;
        shareBt.layer.masksToBounds = YES;
        [shareBt setBackgroundColor:nil forState:UIControlStateHighlighted];
        [shareBt setImage2: nil forState:UIControlStateNormal];
        [shareBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_currentContentView addSubview:shareBt];
//        shareBt.imageView.backgroundColor = [UIColor redColor];
//        shareBt.titleLabel.backgroundColor = [UIColor greenColor];
        shareBt.titleLabel.font = [UIFont systemFontOfSize:12];
        shareBt.titleLabel.textColor = SSColorWithRGB(51, 51, 51, 1);
        NSDictionary *sourceDic =  sourceArray[i];
        shareBt.imageView.image = [[UIImage alloc]initWithContentsOfFile:SSGetFilePathFromBundle(@"Lottery.bundle",[sourceDic valueForKey:@"imgName"])];
        shareBt.titleLabel.text = [sourceDic valueForKey:@"lotteryName"];
        [shareBt.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-3);
            make.top.left.offset(3);
            make.height.offset(95);
            make.centerX.equalTo(shareBt.mas_centerX);
        }];
        
        [shareBt.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(-3);
            make.height.offset(20);
        }];
        
        NSInteger row = i/4;
        NSInteger column = i%4;
        [shareBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@130);
            
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
                    make.top.equalTo(_upBt.mas_bottom).offset(15);
                }
                
                // 首列
                if (column == 0) {  make.left.equalTo(@10); }
                else {// 设置左侧约束
                    make.left.equalTo(_lastBt.mas_right).with.offset(10);
                    
                    // 末列
                    if (column == 3) {  make.right.equalTo(@-10); }
                }
            }
            NSString *sc = [NSString stringWithFormat:@"%ld",(long)column];
            if ([sc rangeOfString:@"3"].location != NSNotFound) {
                _upBt = shareBt;
                make.right.equalTo(@-10);
            }
        }];
        
        _lastBt = shareBt;
        if (i == 0)  _firstBt = shareBt;
    }
    _currentScrollerView.contentSize = CGSizeMake(SScreenWidth, sourceArray.count/4*145+10);
    [_currentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_lastBt.mas_bottom).offset(20);
    }];
}

- (void)clickAction:(AMDButton *)sender{
    LotteryDrawResultListController *VC = [[LotteryDrawResultListController alloc]init];
    [_senderController.navigationController pushViewController:VC animated:YES];
}
@end
