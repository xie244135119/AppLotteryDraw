//
//  AMDAdvertiseView.m
//  AppMicroDistribution
//
//  Created by SunSet on 15-11-20.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "AMDAdvertiseView.h"
#import "UIButton+WebCache.h"
#import "YLJsBridgeSDK.h"
#import "AMDRequestService.h"
#import "LoginInfoStorage.h"


@interface AMDAdvertiseView() <AMDRequestServiceDelegate>
{
    __weak UIView *_middleView;             //中间视图
    YLJsBridgeSDK *_currentBridgeSdk;       //当前桥接的sdk
}
// 广告实体类
@property(nonatomic, strong) AMDLaunchAdvertiseModel *advertiseModel;
@end


@implementation AMDAdvertiseView


- (void)dealloc
{
    self.advertiseModel = nil;
    self.completeBlock = nil;
    _currentBridgeSdk = nil;
}


- (id)initWithModel:(AMDLaunchAdvertiseModel *)advertiseModel
{
    if (self = [super initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)]) {
        _advertiseModel = advertiseModel;
        [self initContentView];
    }
    return self;
}

//- (id)init
//{
//    if (self = [super initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight)]) {
//        [self initContentView];
//    }
//    return self;
//}

// 内部视图
- (void)initContentView
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
 
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    // 中间视图
    CGSize imagesize = [self imageSizeFromWidth:_advertiseModel.w.floatValue/2 height:_advertiseModel.h.floatValue/2];
    UIButton *imgView = [[UIButton alloc]initWithFrame:CGRectMake((width-imagesize.width)/2, (height-imagesize.height)/2, imagesize.width, imagesize.height)];
    imgView.adjustsImageWhenHighlighted = NO;
    NSURL *imgurl = [[NSURL alloc]initWithString:_advertiseModel.src_url];
    [imgView sd_setBackgroundImageWithURL:imgurl forState:UIControlStateNormal placeholderImage:AMDLoadingImage];
    [imgView addTarget:self action:@selector(clickImgViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:imgView];
    _middleView = imgView;
    
    // 关闭按钮
    AMDButton *closebt = [[AMDButton alloc]initWithFrame:CGRectMake(imgView.frame.size.width-42, 0, 42, 42)];
    closebt.imageView.image = imageFromBundleName(@"CommonUIModule.bundle", @"adver_pop_close.png");
    closebt.imageView.frame = CGRectMake(0, 0, 42, 42);
    [imgView addSubview:closebt];
    [closebt addTarget:self action:@selector(clickCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    imgView.layer.masksToBounds = YES;
    imgView.layer.cornerRadius = AMDCornerRadius;
}

// 显示视图
- (void)show
{
    id app = [[UIApplication sharedApplication] delegate];
    [[app window] addSubview:self];
    
    _middleView.transform = CGAffineTransformMakeScale(0.1, .1);
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        _middleView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        weakself.backgroundColor = SSColorWithRGB(0, 0, 0, 0.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            _middleView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
}

// 隐藏视图
- (void)hide
{
    // 关闭广告信息
//    [[LoginInfoStorage sharedStorage] setLaunchAdvertiseModel:nil];
    
    //  动画消失
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        _middleView.transform = CGAffineTransformMakeScale(0.1, .1);
        weakself.backgroundColor = SSColorWithRGB(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [weakself removeFromSuperview];
        
        if (_completeBlock) {
            _completeBlock();
        }
    }];
    
    // 移空数据
    self.advertiseModel = nil;
}

// 按钮事件
- (void)clickCloseAction:(UIButton *)sender
{
    // 请求数据
    [self invokeRequestWithClosTime:@((NSInteger)[[NSDate date] timeIntervalSince1970]) clickTime:@0];
    
    // 关闭视图
    [self hide];
}

// 图片事件
- (void)clickImgViewAction:(UIButton *)sender
{
    NSString *action_type = _advertiseModel.click.action_type;
    NSString *action_param = _advertiseModel.click.action_param;
    [YLJsBridgeSDK bridgeActionWithType:action_type actionParams:action_param];
    
    // 点击广告事件
    [self invokeRequestWithClosTime:@0 clickTime:@((NSInteger)[[NSDate date] timeIntervalSince1970])];
    
    // 隐藏视图
    [self hide];
}


#pragma mark - 大小处理
- (CGSize)imageSizeFromWidth:(CGFloat)width height:(CGFloat)height
{
    CGSize size = CGSizeZero;
    
    // 最大不能超多屏幕-160
    CGFloat maxwidth = (APPWidth-40*2);
    // 超过最大宽度
    if (width > maxwidth) {
        size.width = maxwidth;
        size.height = (CGFloat)maxwidth*height/width;
        
        return size;
    }
    
    // 超过最大高度
    CGFloat maxheight = (APPHeight-50*2);
    if (height > maxheight) {
        size.height = maxheight;
        size.width = (CGFloat)maxheight*width/height;
        return size;
    }
    
    size.width = width;
    size.height = size.width*height/width;
    
    return size;
}


#pragma mark - UITouch事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    //
    if (CGRectContainsPoint(_middleView.frame, location)) {
        return;
    }
//    [self hide];
}


#pragma mark - 网络请求
// 关闭广告
- (void)invokeRequestWithClosTime:(NSNumber *)closeTime clickTime:(NSNumber *)clickTime
{
    NSString *urlpath = [AMDPublicServiceURLPath stringByAppendingString:@"/start-ads/vis"];
    NSDictionary *params = @{@"user_id":AMDTestShopID,@"user_type":@"bshop",@"ad_id":_advertiseModel.ad_id,@"close_time":closeTime,@"click_time":clickTime};
    [[AMDRequestService sharedAMDRequestService] requestWithPOSTURL:urlpath parameters:params type:0 delegate:nil animation:NO];
}

//#pragma mark  - AMDRequestServiceDelegate
//- (void)requestFinished:(NSDictionary *)resault type:(AMDRequestServiceType)type
//{
//    NSLog(@" 请求结果: %@ ",resault);
//}
//
////代理方法---请求出错
//- (void)requestFailed:(id)resault error:(NSError *)error type:(AMDRequestServiceType)type
//{
//    NSLog(@" 请求失败结果: %@ ",resault);
//}


@end































