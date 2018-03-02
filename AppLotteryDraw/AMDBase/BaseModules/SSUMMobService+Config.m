//
//  SSUMMobService+Config.m
//  AppMicroDistribution
//
//  Created by SunSet on 2017/11/29.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "SSUMMobService+Config.h"
#import "MultiProjectManager.h"

@implementation SSUMMobService (Config)


#pragma mark - SSMobConfig
//
- (NSString *)mobAppKey
{
    return [[MultiProjectManager globalConfigFile] uMengReleaseAppKey];
}




@end
