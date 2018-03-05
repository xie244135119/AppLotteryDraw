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
    resault.lotteryCode = dict[@"lotteryCode"];
    [self.senderController.navigationController pushViewController:resault animated:YES];
}



@end
