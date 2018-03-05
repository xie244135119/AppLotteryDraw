//
//  ALDMyAttentionCell.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/5.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDMyAttentionCell.h"
#import <SSBaseKit/SSBaseKit.h>
#import <Masonry/Masonry.h>

@implementation ALDMyAttentionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView{
    self.frame = CGRectMake(0, 0, SScreenWidth, 80);
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, 60, 60)];
    _lotteryImageView = imageView;
    [self.contentView addSubview:imageView];

    //名称
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, SScreenWidth-110, 60)];
    _lotteryLabel = lable;
//    lable.layer.borderWidth = 1;
    [self.contentView addSubview:lable];
    AMDLineView *line = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, SSLineHeight) Color:SSLineColor];
    AMDLineView *line2 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 80, SScreenWidth, SSLineHeight) Color:SSLineColor];
    [self addSubview:line];
    [self addSubview:line2];
}

@end
