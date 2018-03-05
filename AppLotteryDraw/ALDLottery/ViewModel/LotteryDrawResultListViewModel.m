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
    AMDButton *_currentRightBt ;//是否关注按钮
}
@end

@implementation LotteryDrawResultListViewModel


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
    _currentRightBt = rightBt;
    if ([self lotteryModel]) {
        rightBt.titleLabel.text = @"取消关注";
        rightBt.tag = 1;
    }else{
        rightBt.titleLabel.text = @"添加关注";
    }
    rightBt.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBt.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    _senderController.titleView.rightViews = @[rightBt];
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Data *dataModel = _sourceArray[indexPath.row];
    return [LotteryDrawResultListCell cellHeight:dataModel.redArry.count+dataModel.blueArry.count];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    LotteryDrawResultListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LotteryDrawResultListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     Data *dataModel = _sourceArray[indexPath.row];
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


- (void)setSourceArray:(NSArray *)sourceArray{
    _sourceArray = sourceArray;
    [_currentTableView reloadData];
}

//-(void)setSourcesModel:(LotteryModel *)sourcesModel{
//    _sourcesModel = sourcesModel;
//    [_currentTableView reloadData];
//}

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
    NSString *statusText = @"";
    if (sender.tag == 1) {
        //取消关注
        statusText = @"是否取消关注";
    }else{
        //添加关注
        statusText = @"是否添加关注";
    }
    
    __weak typeof(self) weakself = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:statusText message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(sender.tag == 1){
            [weakself cancelAttention];
        }else
            [weakself saveAttention];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [_senderController presentViewController:alert animated:YES completion:nil];
}

//添加关注
- (void)saveAttention{
    SSUserDefaults *defaults = [SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb];
    NSArray *model = [defaults objectForKey:SSLevelMyCareKey];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if (model != nil) {
        [array addObjectsFromArray:model];
    }
    [array addObject:_lotteryInfo];
    // 存值
    [defaults setObject:array forKey:SSLevelMyCareKey];
    _currentRightBt.titleLabel.text = @"取消关注";
}

//取消关注
- (void)cancelAttention{
    SSUserDefaults *defaults = [SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb];
    NSArray *model = [defaults objectForKey:SSLevelMyCareKey];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if (model != nil) {
        [array addObjectsFromArray:model];
    }
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"lotteryCode == %@", self.lotteryInfo[@"lotteryCode"]];
    NSArray *results1 = [array filteredArrayUsingPredicate:predicate1];
    [array removeObject:results1[0]];
     [defaults setObject:array forKey:SSLevelMyCareKey];
    _currentRightBt.titleLabel.text = @"添加关注";
}


//扫描数据看是否已经添加关注
- (BOOL)lotteryModel{
    SSUserDefaults *defaults = [SSUserDefaults defaultsWithType:SSUserDefaultsLevelDb];
    NSArray *modelArr = [defaults objectForKey:SSLevelMyCareKey];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"lotteryCode == %@", self.lotteryInfo[@"lotteryCode"]];
    NSArray *results1 = [modelArr filteredArrayUsingPredicate:predicate1];
    return results1.count==0?NO:YES;
}

@end
