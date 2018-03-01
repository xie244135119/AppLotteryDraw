//
//  LotteryDrawResultListView.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListView.h"
#import "LotteryDrawResultListCell.h"



@interface LotteryDrawResultListView()<UITableViewDelegate,UITableViewDataSource>
{
     UITableView *_currentTableView;
    NSArray *_sourceArray;
}
@end

@implementation LotteryDrawResultListView

-(instancetype)init
{
    if (self = [super init]) {
        _sourceArray= @[@"34",@"64",@"26",@"43",@"24",@"66",@"3",@"4",@"6",@"00",@"64",@"26",@"36",@"34",@"26",@"43",@"44",@"46",@"00",@"24",@"16",@"13",@"14",@"16",@"33",@"34",@"06",@"36",@"03",@"04",@"06",@"00"];
        self.frame = [UIScreen mainScreen].bounds;
        [self initTableView];
    }
    return self;
}

- (void)initTableView{
    UITableView *currentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStyleGrouped];
    currentTable.delegate = self;
    currentTable.dataSource = self;
    _currentTableView = currentTable;
    currentTable.layer.borderWidth = 1;
    [self addSubview:currentTable];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LotteryDrawResultListCell cellHeight:_sourceArray.count];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    LotteryDrawResultListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LotteryDrawResultListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.itemSourceArray = _sourceArray;
//    cell.infoSourceArray = @[@"dfafds"];
    return cell;
}


@end
