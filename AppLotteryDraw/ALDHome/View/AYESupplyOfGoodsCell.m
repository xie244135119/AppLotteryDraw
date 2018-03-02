//
//  AYESupplyOfGoodsCell.m
//  AppMicroDistribution
//
//  Created by leo on 16/6/6.
//  Copyright © 2016年 SunSet. All rights reserved.
//

#import "AYESupplyOfGoodsCell.h"
#import <SSBaseLib/SSBaseLib.h>
#import <SSBaseKit/SSGlobalVar.h>

@implementation AYESupplyOfGoodsCell
{
    __weak UIView *_currentMiddelView;              //中间视图
    __weak AMDButton *_gradeBt ;      //供应商等级
    __weak UIView *_creditLevelView;               //详细内容
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
}

+ (CGFloat)cellHeight
{
    return 190;
}


- (void)initContentView
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, 65+125)];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:middleView];
    _currentMiddelView = middleView;
    
    // 供应商名称
    AMDButton *namelb = [[AMDButton alloc]initWithFrame:CGRectMake(15, 10, SScreenWidth-80-24-10-55, 17)];
    namelb.titleLabel.textAlignment = NSTextAlignmentLeft;
    namelb.backgroundColor = [UIColor clearColor];
    namelb.titleLabel.font = SSFontWithName(@"", 14);
    namelb.titleLabel.textColor = SSColorWithRGB(34, 34, 34, 1);
    [middleView addSubview:namelb];
    _supplierNameBt = namelb;
    
    AMDLineView *middleline = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 37, SScreenWidth, 0.5) Color:SSColorWithRGB(230, 230, 230, 0.5)];
    [middleView addSubview:middleline];
    
    //商品展示视图
    CGFloat photowidth = (SScreenWidth-(4*2)-(10*2))/3;
    UIView *goodsShowView = [[UIView alloc]initWithFrame:CGRectMake(0, 37+10, SScreenWidth, photowidth+12)];
    [middleView addSubview:goodsShowView];
    _goodsSourceShowView = goodsShowView;
    
    //线条
    AMDLineView *topline = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, 0.5) Color:SSColorWithRGB(230, 230, 230, 1)];
    [middleView addSubview:topline];
    
    middleView.frame = CGRectMake(0, 0, SScreenWidth, goodsShowView.amd_y+goodsShowView.amd_height);
    AMDLineView *bottomline = [[AMDLineView alloc]initWithFrame:CGRectMake(0, middleView.amd_height-0.5, SScreenWidth, 0.5) Color:SSColorWithRGB(230, 230, 230, 1)];
    [middleView addSubview:bottomline];
    
    self.frame = CGRectMake(0, 0, SScreenWidth, middleView.amd_height+middleView.amd_y+12);
}


- (void)configSupplyTitle:(NSString *)title
{
    _supplierNameBt.titleLabel.text = title;
    CGSize size = [_supplierNameBt.titleLabel sizeThatFits:CGSizeMake(SScreenWidth-80-24-10-55, 17)];
    _supplierNameBt.titleLabel.amd_width = size.width;
    _supplierNameBt.amd_width = size.width;
}



- (NSArray *)recommendProductsWithCount:(NSInteger)count
{
    [_goodsSourceShowView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 图片高
    CGFloat photowidth = (SScreenWidth-(4*2)-(10*2))/3;
//    if (count == 0) {
//        //上架商品没更新
//
//        AMDButton * showbt = [[AMDButton alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, photowidth)];
//        showbt.titleLabel.text = NSLocalizedString(@"暂无商品", @"") ;
//        showbt.titleLabel.textColor = SSColorWithRGB(153, 153, 153, 1);
//        showbt.titleLabel.font = SSFontWithName(@"", 12);
//        showbt.imageView.image = imageFromBundleName(@"SupplyModule.bundle", @"shop_no_items.png");
//        showbt.imageView.frame = CGRectMake(SScreenWidth/2-70, (showbt.amd_height-40)/2, 40, 40);
//        [_goodsSourceShowView addSubview:showbt];
//        showbt.userInteractionEnabled = NO;
//        return nil;
//    }
    
    NSMutableArray *bts = [[NSMutableArray alloc]init];
    // 商品图片展示
    for (NSInteger i = 0; i < count; i++) {
        //
        AMDButton *bt = [[AMDButton alloc]initWithFrame:CGRectMake(10+(photowidth+4)*i, 0, photowidth, photowidth)];
        bt.imageView.frame = bt.bounds;
        bt.titleLabel.frame = CGRectMake(0, photowidth-20, photowidth, 20);
        bt.titleLabel.backgroundColor = SSColorWithRGB(0, 0, 0, 0.4);
        bt.titleLabel.textColor = [UIColor whiteColor];
        bt.titleLabel.text = @"";
//        bt.titleLabel.font = SSFontWithName(@"", 10);
        [_goodsSourceShowView addSubview:bt];
        
        [bts addObject:bt];
    }
    return bts;
}

@end
