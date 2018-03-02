//
//  UIView+AMD.m
//  SSBaseLib
//
//  Created by SunSet on 2017/10/31.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "UIView+AMD.h"

@implementation UIView (offset)

- (void)fixOffsetWithView:(UIView *)sender
{
    CGRect frame = [self.superview convertRect:sender.frame fromView:sender.superview];
    CGFloat distance = (frame.size.height+frame.origin.y+256+30)-self.frame.size.height;
    // > 0 说明当前输入框被遮住
    if (distance > 0) {
        if ([self respondsToSelector:@selector(contentOffset)]) {
            CGPoint oldpoint = [(UIScrollView *)self contentOffset];
            oldpoint.y += distance;
            [(UIScrollView *)self setContentOffset:oldpoint animated:YES];
        }
        else {
            CGPoint oldcenter = self.center;
            oldcenter.y -= distance;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.center = oldcenter;
            }];
        }
    }
}



@end
