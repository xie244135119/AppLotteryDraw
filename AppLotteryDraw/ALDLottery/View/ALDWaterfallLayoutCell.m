//
//  ALDWaterfallLayoutCell.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDWaterfallLayoutCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
@interface ALDWaterfallLayoutCell()
{
    UIImageView *_currentImageView;
}
@end

@implementation ALDWaterfallLayoutCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
        [self initContentView];
    }
    return self;
}

- (void)initContentView{
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.borderColor = [UIColor greenColor].CGColor;
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.layer.borderWidth = 1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    _currentImageView = imageView;
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];
}


- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    NSLog(@"-------%@",imageURL);
    [_currentImageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
}
@end
