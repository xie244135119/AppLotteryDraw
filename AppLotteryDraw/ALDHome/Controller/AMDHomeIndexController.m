//
//  AMDHomeIndexController.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/3/1.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "AMDHomeIndexController.h"
#import <SSBaseKit/SSGlobalVar.h>
#import <Masonry/Masonry.h>
#import "DDMenuController.h"
#import "AASMessageIndexController.h"
#import "ALDLofferyListController.h"
#import "ALDCountryController.h"
#import "LotteryDrawResultListController.h"
#import "ALDLofferyListController.h"
#import "ALDHomeIndexViewModel.h"

@interface AMDHomeIndexController ()
{
    NSDictionary *_lattoryDict;             //所有彩种数据源
    ALDHomeIndexViewModel *_viewModel;      //
}
@property(nonatomic, strong) NSArray *sourceArry;       //数据
@end

@implementation AMDHomeIndexController

- (void)dealloc
{
    _viewModel = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
//    [self initTableView];
    [self initNavView:self.titleView];
    [self loadDict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 视图加载
//
//导航视图
- (void)initNavView:(UIView *)parentView
{
    //左侧菜单
    UIButton *menu = [UIButton buttonWithType:UIButtonTypeCustom];
    [menu setFrame:CGRectMake(10,20, 40, 40)];
    [menu setBackgroundImage:[UIImage imageNamed:@"home_menu.png"] forState:UIControlStateNormal];
    [menu addTarget:self action:@selector(clickMenuAction:) forControlEvents:UIControlEventTouchUpInside];
    menu.tag = 1;
    [parentView addSubview:menu];
    
    //消息
    UIButton *messagebt = [UIButton buttonWithType:UIButtonTypeCustom];
    [messagebt setBackgroundImage:[UIImage imageNamed:(@"home_message.png")] forState:UIControlStateNormal];
    [messagebt setFrame:CGRectMake(SScreenWidth-10-40, 20, 40, 40)];
    [messagebt addTarget:self action:@selector(clickMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    messagebt.tag = 2;
    [parentView addSubview:messagebt];
}

//
//- (void)initTableView
//{
//    CustomTableView *tableView = [[CustomTableView alloc]initWithType:kCustomTableViewTypeGeneral];
//    tableView.delegate = self;
//    [self.contentView addSubview:tableView];
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
//    //
//    self.sourceArry = @[@"全国彩开奖数据",@"高频彩开奖数据",@"低频彩列表"];
//    tableView.sourceData = _sourceArry;
//}

//
- (void)initViewModel
{
    
    ALDHomeIndexViewModel *vM = [[ALDHomeIndexViewModel alloc]init];
    vM.superView = self.contentView;
    vM.senderController = self.menuVC;
    [vM prepareViewBySuper];
    _viewModel = vM;
}


#pragma mark - private api
// 初始化字典
- (void)loadDict
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (_lattoryDict == nil) {
            NSString *plistpath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LotteryType.plist"];
            NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
            _lattoryDict = dict;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself initViewModel];
        });
    });
}


#pragma mark - CustomTableViewDelegate
//
//- (UITableViewCell *)tableView:(UITableView *)tableView CellAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellider = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
//    }
//    cell.textLabel.text = self.sourceArry[indexPath.row];
//    return cell;
//}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_lattoryDict == nil) {
//        return;
//    }
//    NSString *name = @"";
//    switch (indexPath.row) {
//        case 0:     //全国彩列表
//            name = @"country";
//            break;
//        case 1:     //高频彩列表
//            name = @"gaopin";
//            break;
//        case 2:     //
//            name = @"dipin";
//            break;
//        default:
//            break;
//    }
//    NSArray *arry = _lattoryDict[name];
//    ALDLofferyListController *listVc = [[ALDLofferyListController alloc]init];
//    listVc.sourceArry = arry;
//    [self.menuVC.navigationController pushViewController:listVc animated:YES];
//}


#pragma mark - 按钮事件
// 按钮事件
- (void)clickMenuAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:{//侧边栏功能
            [self.menuVC showLeftController:YES];
        }
            break;
        default:
            break;
    }
}


// 消息事件
- (void)clickMessageAction:(UIButton *)sender
{
    AASMessageIndexController *messageVC = [[AASMessageIndexController alloc]initWithTitle:@"消息" titileViewShow:YES tabBarShow:NO];
    [self.menuVC.navigationController pushViewController:messageVC animated:YES];
}



@end





