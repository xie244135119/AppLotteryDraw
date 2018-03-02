//
//  LotteryDrawResultListView.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListView.h"
#import "LotteryDrawResultListCell.h"
#import "Data.h"


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
        self.backgroundColor = [UIColor whiteColor];
        _sourceArray= _sourcesModel.data;
        self.frame = [UIScreen mainScreen].bounds;
        [self initTableView];
    }
    return self;
}

- (void)initTableView{
    UITableView *currentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, APPWidth, APPHeight) style:UITableViewStylePlain];
    currentTable.delegate = self;
    currentTable.dataSource = self;
    _currentTableView = currentTable;
    currentTable.layer.borderWidth = 1;
    [self addSubview:currentTable];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Data *dataModel = _sourcesModel.data[indexPath.row];
    return [LotteryDrawResultListCell cellHeight:dataModel.redArry.count+dataModel.blueArry.count];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourcesModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    LotteryDrawResultListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LotteryDrawResultListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
     Data *dataModel = _sourcesModel.data[indexPath.row];
//    cell.itemSourceArray = [dataModel openCode];
    [cell setItemCodel:dataModel.redArry blueCode:dataModel.blueArry];
    cell.dateLabel.text = dataModel.expect;
    cell.timeLabel.text = [self timestampSwitchTime:dataModel.opentimestamp ];
//    cell.infoSourceArray = @[@"dfafds"];
    return cell;
}

-(NSString *)timestampSwitchTime:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

-(void)setSourcesModel:(LotteryModel *)sourcesModel{
    _sourcesModel = sourcesModel;
    [_currentTableView reloadData];
}


@end
