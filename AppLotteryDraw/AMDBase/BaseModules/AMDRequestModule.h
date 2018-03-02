//
//  AMDRequestModule.h
//  AppMicroDistribution
//
//  Created by SunSet on 2017/8/4.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSModuleManager/SSModule.h>

@interface AMDRequestModule : NSObject<SSModule>




/**
 配置后续请求的host

 @param hostStr 请求地址
 */
+ (void)configRequestHost:(NSString *)hostStr;


/**
 配置所有api需要的请求参数

 @param extra {"supplyId":xxx}
 */
+ (void)configReuestExtraParmas:(NSDictionary *)extra;

@end
