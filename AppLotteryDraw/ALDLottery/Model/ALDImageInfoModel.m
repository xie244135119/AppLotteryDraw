//
//  ALDImageInfoModel.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDImageInfoModel.h"

@implementation ALDImageInfoModel

+ (instancetype)imageWithImageDic:(NSDictionary *)imageDic {
    ALDImageInfoModel *image = [[ALDImageInfoModel alloc] init];
    image.imageURL = [NSURL URLWithString:imageDic[@"img"]];
    image.imageW = [imageDic[@"w"] floatValue];
    image.imageH = [imageDic[@"h"] floatValue];
    return image;
}

@end
