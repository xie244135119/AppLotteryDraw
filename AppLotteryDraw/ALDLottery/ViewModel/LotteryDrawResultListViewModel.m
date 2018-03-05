//
//  LotteryDrawResultListView.m
//  AppLotteryDraw
//
//  Created by 马清霞 on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "LotteryDrawResultListViewModel.h"
#import "LotteryDrawResultListCell.h"
#import "Data.h"
#import "AMDMJRefresh.h"
#import <SSBaseKit/SSBaseKit.h>
#import <SSBaseLib/SSBaseLib.h>
#import <Masonry/Masonry.h>
#import <SSUserDefaults/SSUserDefaults.h>
#import "GlobalVar.h"


//屏幕宽度
//#define APPWidth [UIScreen mainScreen].bounds.size.width
//#define APPHeight [UIScreen mainScreen].bounds.size.height

@interface LotteryDrawResultListViewModel()<UITableViewDelegate,UITableViewDataSource>
{
     UITableView *_currentTableView;
    AMDRootViewController *_senderController;
}
@end

@implementation LotteryDrawResultListViewModel

-(instancetype)init
{
    if (self = [super init]) {
       
    }
    return self;
}
-(void)prepareView{
    _senderController = (AMDRootViewController *)self.senderController;
    [self initTableView];
    [self initNavigationBarItem];
}


//初始化表格
- (void)initTableView{
    UITableView *currentTable = [[UITableView alloc]init];
    currentTable.delegate = self;
    currentTable.dataSource = self;
    _currentTableView = currentTable;
    [_senderController.contentView addSubview:currentTable];
    [currentTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
//    [_currentTableView addHeaderWithTarget:self action:@selector(tableViewDidStartRefreshing:)];
//    [_currentTableView addFooterWithTarget:self action:@selector(tableViewDidStartLoading:)];
}


//初始化导航item
- (void)initNavigationBarItem{
    AMDButton *rightBt = [[AMDButton alloc]initWithFrame:CGRectMake(SScreenWidth-100-5, 2, 100, 40)];
    rightBt.titleLabel.text = @"添加关注";
    rightBt.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    _senderController.titleView.rightViews = @[rightBt];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     Data *dataModel = _sourcesModel.data[indexPath.row];
//    cell.itemSourceArray = [dataModel openCode];
    [cell setItemCodel:dataModel.redArry blueCode:dataModel.blueArry];
    cell.dateLabel.text = [NSString stringWithFormat:@"第%@期",dataModel.expect] ;
    cell.timeLabel.text = [self timestampSwitchTime:dataModel.opentimestamp ];
//    cell.infoSourceArray = @[@"dfafds"];
    return cell;
}

-(NSString *)timestampSwitchTime:(NSInteger)timestamp{
    NSDateComponents *commponent = [SSDateTool toDateComponentsFromTimeStamp:@(timestamp)];
    NSArray *weektitles = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    return [NSString stringWithFormat:@"%@ %@",weektitles[commponent.weekday-1] ,[SSDateTool toStringFromTimeStamp:@(timestamp) formateString:@"YYYY-MM-dd hh:ss"]] ;
}

-(void)setSourcesModel:(LotteryModel *)sourcesModel{
    _sourcesModel = sourcesModel;
    [_currentTableView reloadData];
}

#pragma mark - 刷新和加载
- (void)tableViewDidStartRefreshing:(id)collectionView
{
    [_currentTableView headerEndRefreshing];
    if (_reafreshAction) {
        _reafreshAction(collectionView);
    }
}

- (void)tableViewDidStartLoading:(id)collectionView{
    [_currentTableView footerEndRefreshing];
    if (_loadingAction) {
        if (_loadingAction(collectionView)) {
            _currentTableView.footerHidden = YES;
        }
    }
}


#pragma mark - 按钮事件
- (void)clickAction:(AMDButton *)sender{
    __weak typeof(self) weakself = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否添加到关注" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakself saveObject];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [_senderController presentViewController:alert animated:YES completion:nil];
}


- (void)saveObject{
    SSUserDefaults *defaults = [SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb];
    NSArray *model = [defaults objectForKey:SSLevelMyCareKey];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if (model != nil) {
        [array addObjectsFromArray:model];
    }
//    NSDictionary *oldmodeldict = [defaults objectForKey:SSLevelMyCareKey];
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:oldmodeldict];
//    [dict setObject:_lotteryInfo forKey:@"lotteryinfo"];
    [array addObject:_lotteryInfo];
    // 存值
    [defaults setObject:array forKey:SSLevelMyCareKey];
}
@end
