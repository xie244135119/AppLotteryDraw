//
//  ALDLotteryRequestHandle.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/5.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDLotteryRequestHandle.h"
#import <SSUserDefaults/SSUserDefaults.h>
#import "GlobalVar.h"
#import <SSBaseLib/SSDateTool.h>
#import "LotteryModel.h"

@implementation ALDLotteryRequestHandle


+ (instancetype)shareInstance
{
    static ALDLotteryRequestHandle *_handle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _handle = [[ALDLotteryRequestHandle alloc]init];
    });
    return _handle;
}


+ (BOOL)isReloadRequestWithCode:(NSString *)lotterycode
{
    NSDictionary *dict = [[SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb] objectForKey:SSLevelRequestTimestampKey];
    NSNumber *number = dict[lotterycode];
    if (number == nil) {
        return YES;
    }
    NSNumber *currenttimestamp = [SSDateTool toStampStringFromDate:[NSDate date]];
    // 如果相差在5s 以上不用请求
    if (currenttimestamp.integerValue-number.integerValue > 5) {
        return YES;
    }
    return NO;
}

// 根据彩票相应code更新时间戳
+ (void)updateRequestTimestamp:(NSString *)lotterycode
{
    NSDictionary *dict = [[SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb] objectForKey:SSLevelRequestTimestampKey];
    NSMutableDictionary *resault = [[NSMutableDictionary alloc]init];
    [resault addEntriesFromDictionary:dict];
    
    // 存储当前时间戳
    NSNumber *currenttimestamp = [SSDateTool toStampStringFromDate:[NSDate date]];
    [resault setObject:currenttimestamp forKey:lotterycode];
    
    [[SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb] setObject:resault forKey:SSLevelRequestTimestampKey];
}




#pragma mark -
// 获取彩种列表
- (void)getListWithLotteryCode:(NSString *)lotteryCode
                    completion:(void (^)(NSArray<Data> *list))completion
{
    // 如果不需要重新请求--直接返回最新的数据
    if (![ALDLotteryRequestHandle isReloadRequestWithCode:lotteryCode]) {
        NSArray<Data> *list = [ALDLotteryRequestHandle getLateListWithCode:lotteryCode];
        completion(list);
        return;
    }
    
    // 发起请求
    //初始化一个session
    NSURLSession *session = [NSURLSession sharedSession];
    //通过地址得到一个url
    NSString *urlStr = [NSString stringWithFormat:@"http://f.apiplus.net/%@-20.json", lotteryCode];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                              error:nil];
        LotteryModel *model = [[LotteryModel alloc]initWithDictionary:dic];
        
        // 更新本地时间戳
        [ALDLotteryRequestHandle updateRequestTimestamp:lotteryCode];
        
        if (completion) {
            completion(model.data);
        }
    }];
    [task resume];
}



#pragma mark - private api
// 获取最近的数据
+ (NSArray<Data> *)getLateListWithCode:(NSString *)Lotterycode
{
    NSDictionary *lotteryinto = [[SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb] objectForKey:SSLLevelLotteryInfoKey];
    return lotteryinto[Lotterycode];
}


//  更新本地最新的彩票数据列表
+ (void)updateLateList:(NSArray<Data> *)lotteryList
           lotteryCode:(NSString *)lotteryCode
{
    if (lotteryList.count == 0) {
        return;
    }
    
    // 一期方案：每次只保留最近的20条
    NSDictionary *dict = [[SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb] objectForKey:SSLLevelLotteryInfoKey];
    NSMutableDictionary *resault = [[NSMutableDictionary alloc]init];
    [resault addEntriesFromDictionary:dict];
    
    // 存储当前时间戳
    [resault setValue:lotteryList forKey:lotteryCode];
    [[SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb] setObject:resault forKey:SSLLevelLotteryInfoKey];
}




@end
















