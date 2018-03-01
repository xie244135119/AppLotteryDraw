//
//  UIView+AMD.h
//  SSBaseLib
//
//  Created by SunSet on 2017/10/31.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (offset)

/**
 修正 View在当前视图上的偏移量
 主要用于键盘弹出的时候，需要自动偏移文字
 @param sender 需要偏移的视图
 */
- (void)fixOffsetWithView:(UIView *)sender;


@end



