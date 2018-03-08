//
//  ALDHomeIndexViewModel.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDHomeIndexViewModel.h"
#import <Masonry/Masonry.h>
#import "AYESupplyOfGoodsCell.h"
#import "LotteryDrawResultListController.h"
#import <SSBaseLib/NSObject+SSBindValue.h>
#import "ALDLofferyListController.h"

static NSString *const kModel = @"kModel";

@interface ALDHomeIndexViewModel()<CustomTableViewDelegate>

@end

@implementation ALDHomeIndexViewModel

- (void)dealloc
{
    self.lotteryTypeDict = nil;
}

- (void)prepareViewBySuper
{
    [self initContentView];
}

//
- (void)initContentView
{
    CustomTableView *tableView = [[CustomTableView alloc]initWithType:kCustomTableViewTypeGeneral];
    tableView.delegate = self;
    [self.superView addSubview:tableView];
    _tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    //
    NSString *lotteryplistpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Lotterys.plist"];
    NSArray *arry = [[NSArray alloc]initWithContentsOfFile:lotteryplistpath];
    tableView.sourceData = arry;
    tableView.tableView.tableHeaderView = [self hintView];
    tableView.tableView.tableHeaderView.hidden = YES;
}


#pragma Mark - 不带任何其他控件的无网络展示视图
- (UIView *)hintView{
    //提示背景视图
    UIView *hintBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, 40)];
    hintBackView.backgroundColor = SSColorWithRGB(252, 223, 224, 1);
    
    //图片
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.2, 25, 25)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.layer.cornerRadius = 25/2;
    imageView.layer.masksToBounds = YES;
    [hintBackView addSubview:imageView];
    
    //提示内容
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, SScreenWidth-50, 40)];
    contentLabel.text = @"当前网络不可用，请检查你的网络设置";
    contentLabel.font = [UIFont systemFontOfSize:14];
    [hintBackView addSubview:contentLabel];
    return hintBackView;
}


#pragma mark - Table view data source and delegate
//
- (UITableViewCell *)tableView:(UITableView *)tableView CellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellider = @"cell";
    AYESupplyOfGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
    if (cell == nil) {
        cell = [[AYESupplyOfGoodsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
    }
    NSDictionary *dict =_tableView.sourceData[indexPath.row];
    [cell configSupplyTitle:dict[@"name"]];
    //销售商品
    NSString *key = dict[@"type"];
    NSArray *lottertlist = _lotteryTypeDict[key];
    NSInteger count = MIN(lottertlist.count, 3);
    NSArray *bts = [cell recommendProductsWithCount:count];
    for (NSInteger i =0;i < count;i++) {
        NSDictionary *dict = lottertlist[i];
        AMDButton *sender = bts[i];
        NSString *lotteryName = dict[@"lotteryName"];
        NSString *imgName = [[NSString alloc]initWithFormat:@"%@/%@",@"Lottery.bundle",dict[@"imgName"]];
        [sender.imageView setImage:[UIImage imageNamed:imgName]];
        sender.titleLabel.text = lotteryName;
        [sender addTarget:self action:@selector(clickLotteryInfoAction:) forControlEvents:UIControlEventTouchUpInside];
        [sender bindWeakValue:dict forKey:kModel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AYESupplyOfGoodsCell cellHeight];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *lotteryDict = _tableView.sourceData[indexPath.row];
    NSString *type = lotteryDict[@"type"];
    NSArray *arry = _lotteryTypeDict[type];
    ALDLofferyListController *listVc = [[ALDLofferyListController alloc]init];
    listVc.sourceArry = arry;
    [self.senderController.navigationController pushViewController:listVc animated:YES];
}



#pragma mark - 按钮事件
// 按钮事件
- (void)clickLotteryInfoAction:(AMDButton *)sender
{
    NSDictionary *dict = [sender getBindValueForKey:kModel];
    //
    LotteryDrawResultListController *resault = [[LotteryDrawResultListController alloc]initWithTitle:dict[@"lotteryName"]];
    resault.lotteryInfo = dict;
    [self.senderController.navigationController pushViewController:resault animated:YES];
}

#pragma mark - 开始动画和结束动画
- (void)noNetworkView:(BOOL)show{
    if (show) {
        [self showHintView];
    }else{
        [self hiddenHintView];
    }
}

//没有搜索栏是直接把提示语添加到headerview控制偏移量实现动画效果
- (void)showHintView{
    _tableView.tableView.tableHeaderView.hidden = NO;
    [UIView animateWithDuration:.5 animations:^{
        [_tableView.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }];
}

- (void)hiddenHintView{
    [UIView animateWithDuration:.5 animations:^{
        [_tableView.tableView setContentInset:UIEdgeInsetsMake(-40, 0, 0, 0)];
    } completion:^(BOOL finished) {
        _tableView.tableView.tableHeaderView.hidden = YES;
    }];
}


@end
