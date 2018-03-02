//
//  ALDImageInfoModel.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALDImageInfoModel : NSObject

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, assign) CGFloat imageW;
@property (nonatomic, assign) CGFloat imageH;

+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic;

@end
