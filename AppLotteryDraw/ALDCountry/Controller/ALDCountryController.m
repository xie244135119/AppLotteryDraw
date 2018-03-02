//
//  ALDCountryController.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ALDCountryController.h"
#import "ALDCountryViewModel.h"
#import "ALDLotteryTypeModel.h"

@interface ALDCountryController ()
{
    ALDCountryViewModel *_viewModel;
}
@end

@implementation ALDCountryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewModel];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
//
- (void)initViewModel
{
    ALDCountryViewModel *vM = [[ALDCountryViewModel alloc]init];
    vM.superView = self.contentView;
    vM.senderController = self;
    [vM prepareViewBySuper];
    _viewModel = vM;
}


#pragma mark - private api
//
- (void)loadData
{
    NSMutableArray *source = [[NSMutableArray alloc]init];
    for (int i=0; i<3; i++) {
        ALDLotteryTypeModel *model = [[ALDLotteryTypeModel alloc]init];
        model.lotteryName = @"双色球";
        model.lotteryCode = @"ssq";
        [source addObject:model];
    }
    _viewModel.tableView.sourceData = source;
    [_viewModel.tableView.tableView reloadData];;
}


@end









