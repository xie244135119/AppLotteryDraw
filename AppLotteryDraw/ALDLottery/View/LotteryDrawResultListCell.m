//
//  LotteryDrawResultListCell.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListCell.h"
#import "Masonry.h"
#import <SSBaseKit/SSBaseKit.h>

@interface LotteryDrawResultListCell()
{
    UIView *_resultBackView;
    UIView *_currentItemBack;
//    UIView *_currentSourceBack;
}
@end

@implementation LotteryDrawResultListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView
{
    //开奖时间
    UILabel *timeLabel = [[UILabel alloc]init];
    _dateLabel = timeLabel;
//    timeLabel.text = @"20180222期";
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textColor = SSColorWithRGB(51, 51, 51, 1);
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@15);
        make.right.equalTo(@-200);
        make.height.equalTo(@20);
    }];
    
    //开奖时间
    UILabel *openTime = [[UILabel alloc]init];
    _timeLabel = openTime;
    openTime.textAlignment = NSTextAlignmentRight;
    openTime.font = [UIFont systemFontOfSize:12];
    openTime.textColor = SSColorWithRGB(119, 119, 119, 1);
//    openTime.text = @"2018-03-01 15:44";
    [self addSubview:openTime];
    [openTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.bottom.equalTo(timeLabel);
        make.left.equalTo(timeLabel.mas_right);
        make.height.equalTo(@15);
    }];
    
    //开奖结果背景视图
    UIView *resultBackView = [[UIView alloc]init];
    _resultBackView = resultBackView;
    resultBackView.backgroundColor = SSColorWithRGB(230, 230, 230, 1);
    [self addSubview:resultBackView];
    [resultBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeLabel);
        make.right.equalTo(@-10);
        make.top.equalTo(timeLabel.mas_bottom).offset(10);
    }];
}

-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 5; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

//搭建相应item按钮
- (void)setItemCodel:(NSArray *)redCode blueCode:(NSArray *)blueCode{
    __block UIButton *_firstBt = nil;
    __block UIButton *_lastBt = nil;
    __block UIButton *_upBt = nil;
    if (_currentItemBack != nil) {
        [_currentItemBack removeFromSuperview];
    }
        UIView *itemBack = [[UIView alloc]init];
        _currentItemBack = itemBack;
        [_resultBackView addSubview:_currentItemBack];
        [itemBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.offset(0);
        }];
    NSMutableArray *sourceArray = [[NSMutableArray alloc]initWithArray:redCode];
    if (blueCode>0) {
        [sourceArray insertObjects:blueCode atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(redCode.count, blueCode.count)]];
    }
    
    CGFloat itemWidth = (SScreenWidth-20-(11*10))/10;
    for (int i = 0; i <sourceArray.count; i++) {
        UIButton *itemBt = [[UIButton alloc]init];
        if (i<redCode.count) {
            itemBt.backgroundColor = [UIColor redColor];
        }else{
            itemBt.backgroundColor = [UIColor blueColor];
        }
        [itemBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        itemBt.layer.cornerRadius = itemWidth/2;
        itemBt.titleLabel.font = [UIFont systemFontOfSize:15];
        [itemBt setTitle:sourceArray[i] forState:UIControlStateNormal];
        [_currentItemBack addSubview:itemBt];
        
        NSInteger row = i/10;
        NSInteger column = i%10;
        [itemBt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.equalTo(@(itemWidth));
            //当第一个按钮不存在的时候
            if (_firstBt == nil) {
                make.top.equalTo(@10);
                make.left.equalTo(@10);
            }else{
                // 设置等宽度
                make.width.equalTo(_lastBt.mas_width);
                
                //如果是第一行
                if (row == 0) {
                    make.top.equalTo(_firstBt.mas_top);
                }else{
                    make.top.equalTo(_upBt.mas_bottom).offset(10);
                }
                
                //如果是第一列
                if (column == 0) {
                    make.left.equalTo(@10);
                }else{
                    make.left.equalTo(_lastBt.mas_right).offset(10);
                    NSString *sc = [NSString stringWithFormat:@"%ld",(long)column];
                    if ([sc rangeOfString:@"9"].location != NSNotFound) {
                        make.right.equalTo(@-10);
                    }
                }
            }
            
            _lastBt = itemBt;
            if (i == 0) {
                _firstBt = itemBt;
            }

            NSString *sc = [NSString stringWithFormat:@"%ld",(long)column];
            if ([sc rangeOfString:@"9"].location != NSNotFound) {
                _upBt = itemBt;
                make.right.equalTo(@-10);
            }
        }];
    }
    [_currentItemBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_lastBt.mas_bottom);
    }];
    [_resultBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_currentItemBack.mas_bottom).offset(10);
    }];
}

+ (CGFloat)cellHeight:(NSInteger)sourceCount
{
    CGFloat itemWidth = (SScreenWidth-20-(11*10))/10;
    //一个圆的宽度
    NSUInteger column=(sourceCount-1)/10;
    return ((column+1)*(itemWidth+10)+10)+60;
}
@end
