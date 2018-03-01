//
//  LotteryDrawResultListCell.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryDrawResultListCell : UITableViewCell

//数据源
@property (nonatomic, strong)NSArray<NSString*> *itemSourceArray;

//@property (nonatomic, strong)NSArray<NSString*> *infoSourceArray;

+ (CGFloat)cellHeight:(NSInteger)sourceCount;


@end
