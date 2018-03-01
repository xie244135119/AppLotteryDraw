//
//  SSTool.h
//  SSBaseLib
//
//  Created by SunSet on 2017/10/31.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSTool : NSObject


+ (CGSize)calculateText:(NSString *)text
                maxSize:(CGSize)maxsize
                   font:(UIFont *)font
              lineSpace:(CGFloat)linespace
          lineBreakMode:(NSLineBreakMode)linebreakdmode;



@end
