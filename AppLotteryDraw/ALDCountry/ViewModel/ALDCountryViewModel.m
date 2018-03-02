//
//  ALDCountryViewModel.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/2.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDCountryViewModel.h"
#import <SSBaseKit/CustomTableView.h>
#import "ALDLofferyListController.h"
#import <Masonry/Masonry.h>

@interface ALDCountryViewModel() <CustomTableViewDelegate>

@end

@implementation ALDCountryViewModel

- (void)dealloc
{
    self.sourceArry = nil;
}


- (void)prepareViewBySuper
{
    [self initTableView];
}


#pragma mark -
//
- (void)initTableView
{
    CustomTableView *tableView = [[CustomTableView alloc]initWithType:kCustomTableViewTypeGeneral];
    tableView.delegate = self;
    [self.superView addSubview:tableView];
    _tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark - CustomTableViewDelegate
//
- (UITableViewCell *)tableView:(UITableView *)tableView CellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellider = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellider];
    }
    cell.textLabel.text = @"双色球";
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALDLofferyListController *listVc = [[ALDLofferyListController alloc]init];
    listVc.sourceArry = @[@"",@""];
    [self.senderController.navigationController pushViewController:listVc animated:YES];
}




@end










