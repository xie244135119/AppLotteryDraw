//
//  AMDTabbarItem+Custom.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/10/20.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "AMDTabbarItem+Custom.h"
#import <objc/runtime.h>

@implementation AMDTabbarItem (Custom)


// 改变两者之间实现
+ (void)exchangeSel:(SEL)originSel senderSel:(SEL)senderSel
{
    Method orignMethod = class_getInstanceMethod([self class], originSel);
    Method senderMethod = class_getInstanceMethod([self class], senderSel);
    method_exchangeImplementations(orignMethod, senderMethod);
}


+ (void)load
{
    [self exchangeSel:@selector(amd_init) senderSel:@selector(init)];
}



- (instancetype)amd_init
{
    typeof(self) v = [self amd_init];
    
    // 设置默认选中色
    [v setTitleColor:App_Main_Color controlState:UIControlStateSelected];
    return v;
}



@end


