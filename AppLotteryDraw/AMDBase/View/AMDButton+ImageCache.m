//
//  AMDButton+ImageCache.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/7/11.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "AMDButton+ImageCache.h"
#import <objc/runtime.h>
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation AMDButton (ImageCache)

// 改变两者之间实现
+ (void)exchangeSel:(SEL)originSel senderSel:(SEL)senderSel
{
    Method orignMethod = class_getInstanceMethod([self class], originSel);
    Method senderMethod = class_getInstanceMethod([self class], senderSel);
    method_exchangeImplementations(orignMethod, senderMethod);
}


+ (void)load
{
    [self exchangeSel:@selector(setImageWithUrl:placeHolder:) senderSel:@selector(amd_setImageWithUrl:placeHolder:)];
    [self exchangeSel:@selector(setBackgroundImageWithUrl:placeHolder:forState:) senderSel:@selector(amd_setBackgroundImageWithUrl:placeHolder:forState:)];
}

- (void)amd_setImageWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder
{
    [self.imageView sd_setImageWithURL:url placeholderImage:placeHolder];
//    [self sd_internalSetImageWithURL:url
//                    placeholderImage:placeHolder
//                             options:0
//                        operationKey:nil
//                       setImageBlock:nil
//                            progress:nil
//                           completed:nil];
    //    NSLog(@" 图片加载 目前注释掉 ");
}


- (void)amd_setBackgroundImageWithUrl:(NSURL *)url
                      placeHolder:(UIImage *)placeHolder
                         forState:(UIControlState)state
{
    [self.imageView sd_setImageWithURL:url placeholderImage:placeHolder];
}




@end





