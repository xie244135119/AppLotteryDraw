//
//  ALDMyAttentionViewModel.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/5.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDMyAttentionViewModel.h"
#import <Masonry/Masonry.h>
#import "ALDMyAttentionCell.h"
#import "LotteryModel.h"
#import <SSUserDefaults/SSUserDefaults.h>
#import "GlobalVar.h"
#import "LotteryDrawResultListController.h"



@interface ALDMyAttentionViewModel()<CustomTableViewDelegate>
{
    AMDRootViewController *_senderController;
    NSArray *_sourceArray;
}
@end

@implementation ALDMyAttentionViewModel

-(void)prepareView{
    _senderController = (AMDRootViewController *)self.senderController;
    [self initContentView];
}

-(void)initContentView{
  //搭建表格
    CustomTableView *tableView = [[CustomTableView alloc]initWithType:kCustomTableViewTypeGeneral];
    tableView.delegate = self;
    [_senderController.contentView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    NSArray *model = [self lotteryModel];
    _sourceArray = model;
    tableView.sourceData = _sourceArray;
}

#pragma mark - CustomTableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView CellAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier =@"cell";
    ALDMyAttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ALDMyAttentionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.lotteryLabel.text = [_sourceArray[indexPath.row] valueForKey:@"lotteryName"];
    cell.lotteryImageView.image = [[UIImage alloc]initWithContentsOfFile:SSGetFilePathFromBundle(@"Lottery.bundle",[_sourceArray[indexPath.row] valueForKey:@"imgName"])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LotteryDrawResultListController *resault = [[LotteryDrawResultListController alloc]initWithTitle:_sourceArray[indexPath.row][@"lotteryName"]];
    resault.lotteryInfo = _sourceArray[indexPath.row];
    [self.senderController.navigationController pushViewController:resault animated:YES];
    
}

#pragma mark - 数据处理
- (NSArray *)lotteryModel{
    SSUserDefaults *defaults = [SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb];
    NSArray *model = [defaults objectForKey:SSLevelMyCareKey];
    return model;
}

#pragma mark - 提示用户（只需要一次）
- (void)showhint{
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"我的关注提示文案还没给" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertCtr addAction:confirmAction];
    [_senderController presentViewController:alertCtr animated:YES completion:nil];
}

@end
