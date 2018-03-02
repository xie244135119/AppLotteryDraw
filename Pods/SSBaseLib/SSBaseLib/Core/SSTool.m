//
//  SSTool.m
//  SSBaseLib
//
//  Created by SunSet on 2017/10/31.
//  Copyright © 2017年 SunSet. All rights reserved.
//

#import "SSTool.h"

@implementation SSTool


//计算文字尺寸---用户去除警告
+ (CGSize)calculateText:(NSString *)text
                maxSize:(CGSize)maxsize
                   font:(UIFont *)font
              lineSpace:(CGFloat)linespace
          lineBreakMode:(NSLineBreakMode)linebreakdmode
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = linebreakdmode;
    style.lineSpacing = linespace;
    NSDictionary *att = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:style};
    CGRect textrect = [text boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    CGSize textSize = textrect.size;
    return textSize;
}



@end
