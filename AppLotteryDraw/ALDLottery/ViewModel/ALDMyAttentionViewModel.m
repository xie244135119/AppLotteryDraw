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
    NSMutableArray *_sourceArray;
}
// 无视图显示
@property(nonatomic, weak) AMDNoDataView *noDataView;

@end

@implementation ALDMyAttentionViewModel

-(void)prepareView{
    _senderController = (AMDRootViewController *)self.senderController;
    [self initContentView];
    [self showhint];
}

-(void)initContentView{
    _sourceArray = [[NSMutableArray alloc]init];
  //搭建表格
    CustomTableView *tableView = [[CustomTableView alloc]initWithType:kCustomTableViewTypeGeneral];
    tableView.delegate = self;
    _currentTableView = tableView;
    [_senderController.contentView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    NSArray *model = [self lotteryModel];
    _sourceArray = model.mutableCopy;
    tableView.sourceData = _sourceArray;
    self.noDataView.hidden = _sourceArray.count>0;
}

#pragma mark - 没数据的时候展示的视图
- (AMDNoDataView *)noDataView
{
  
    if (!_noDataView) {
        CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
        CGFloat statusheight = statusFrame.size.height+44 ;
        AMDNoDataView *v = [[AMDNoDataView alloc] initWithFrame:CGRectMake(0, 0, SScreenWidth, SScreenHeight-statusheight)];
        _noDataView = v;
        _noDataView.titleLabel.text = NSLocalizedString(@"暂无关注", @"") ;
        _noDataView.nodataImageView.image = [UIImage imageNamed:@"nodata_space.png"];
        _noDataView.hidden = YES;
        [_currentTableView.tableView addSubview:_noDataView];
    }
    return _noDataView;
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
    resault.refreashList = ^(NSUInteger status, NSDictionary *infoDic) {
        if (status == 1) {
            //取消关注
            [_sourceArray removeObject:infoDic];
        }else{
            //添加关注
            [_sourceArray addObject:infoDic];
        }
        self.noDataView.hidden = _sourceArray.count>0;
        [_currentTableView.tableView reloadData];
    };
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
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"ifFirst"]) {
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"ifFirst"];
        UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"我的关注提示文案还没给" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertCtr addAction:confirmAction];
        [_senderController presentViewController:alertCtr animated:YES completion:nil];
    }
}

@end
