//
//  AASMenuCell.m
//  AppAmountStore
//
//  Created by SunSet on 15-2-2.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "AASMenuCell.h"
#import <SSBaseKit/SSGlobalVar.h>
#import <SSBaseKit/AMDLineView.h>

@implementation AASMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    self.contentView.backgroundColor = highlighted?[UIColor whiteColor]:[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected?[UIColor whiteColor]:[UIColor clearColor];
}


#pragma mark - 视图加载
- (void)initContentView
{
    self.frame = CGRectMake(0, 0, SScreenWidth, 50);
    self.backgroundColor = [UIColor clearColor];
    //icon
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 13, 24, 24)];
    [self.contentView addSubview:iconView];
    _iconImageView = iconView;
    
    //主页
    UILabel *messagelb = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, self.contentView.frame.size.width-65-30, 50)];
    messagelb.font = SSFontWithName(@"", 15);
    messagelb.textColor = SSColorWithRGB(96, 99, 102, 1);
    messagelb.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:messagelb];
    _titleLabel = messagelb;
    
    //箭头
    UIImageView *jiantouimgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow-right"]];
    jiantouimgView.frame = CGRectMake(SScreenWidth-100-24, 13, 24, 24);
    [self.contentView addSubview:jiantouimgView];
    
    //线条
    AMDLineView *line = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 50-0.5, SScreenWidth, 0.5) Color:SSColorWithRGB(209, 202, 198, 1)];
    [self.contentView addSubview:line];
    
}




@end







