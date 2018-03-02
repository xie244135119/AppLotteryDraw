//
//  SSImageTool.h
//  SSBaseLib
//  图片处理类
//  Created by SunSet on 2017/9/28.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSImageTool : NSObject


/**
 图片裁剪

 @param clipSize 裁剪大小
 @param clitype 裁剪类型 目前支持：1 居中裁剪
 @param clipImage 裁剪图片
 @return 图片
 */
+ (UIImage *)clipWithSize:(CGSize)clipSize
                 clipType:(NSInteger)clitype
                    image:(UIImage *)clipImage;



@end







