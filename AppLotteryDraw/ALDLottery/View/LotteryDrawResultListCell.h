//
//  LotteryDrawResultListCell.h
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LotteryDrawResultListCell : UITableViewCell

//开奖时间
@property (nonatomic, strong)UILabel *timeLabel;
//期数
@property (nonatomic, strong)UILabel *dateLabel;

//设置opencode
- (void)setItemCodel:(NSArray *)redCode blueCode:(NSArray *)blueCode;

+ (CGFloat)cellHeight:(NSInteger)sourceCount;


@end
