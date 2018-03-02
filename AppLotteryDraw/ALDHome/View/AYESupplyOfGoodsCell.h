//
//  AYESupplyOfGoodsCell.h
//  AppMicroDistribution
//  我的货源cell
//  Created by leo on 16/6/6.
//  Copyright © 2016年 SunSet. All rights reserved.
//

#import <SSBaseKit/SSBaseKit.h>

@interface AYESupplyOfGoodsCell : AMDBaseCell

@property(nonatomic, weak) AMDButton *supplierNameBt;
// 发现认证类型
@property(nonatomic, readonly) UILabel *updateAtTimeLabel;                  //更新时间
@property(nonatomic, readonly) UILabel *productCountLabel;                  //上新品数量
@property(nonatomic, readonly) UIView *goodsSourceShowView;                 //商品展示视图

/**
 *  设置推荐新品内容
 *
 *  @param count 数量为0的时候 返回空， 数量为3的时候返回一组按钮
 *
 *  @return 一组按钮
 */
- (NSArray *)recommendProductsWithCount:(NSInteger)count;


// 配置店铺标题
- (void)configSupplyTitle:(NSString *)title;

// cell高度
+ (CGFloat)cellHeight;


@end











