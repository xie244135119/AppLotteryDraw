//
//  AASMenuController.m
//  AppAmountStore
//
//  Created by SunSet on 15-2-2.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "AASMenuController.h"
#import <SSBaseKit/SSGlobalVar.h>
#import "AASMenuCell.h"
#import <Masonry/Masonry.h>
//#import "AASTool.h"
//#import "AASHelpCenterController.h"
//#import "AASSetIndexController.h"
//#import "AASShopInfoController.h"
//#import "AASCommonClass.h"
//#import "AASAppIndexViewController.h"
//#import "AASButton.h"
//#import "AASShareCommonController.h"
//#import "UIImageView+WebCache.h"
//#import "AASStoreHomeController.h"

#import "DDMenuController.h"

@interface AASMenuController ()<CustomTableViewDelegate>
{
    __weak CustomTableView *_currentTableView;  //当前表格
    __weak UILabel *_shopTitleLb;               //店铺标题
    __weak UIImageView *_shopLogoImgView;               //店铺logo地址
}
@end

@implementation AASMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @autoreleasepool {
        [self initContentView];
        [self initExitView];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 视图加载
- (void)initContentView
{
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    imgView.image = [UIImage imageNamed:@"menubackground.png"];
    [self.contentView addSubview:imgView];
    CustomTableView *tab = [[CustomTableView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, self.contentView.frame.size.height-50) Type:kCustomTableViewTypeGeneral];
    tab.delegate = self;
    [self.contentView addSubview:tab];
    _currentTableView = tab;
    [self setTableViewHeaderView:tab.tableView];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //
//    tab.sourceData = @[@{@"imageName":@"menu_myshop.png",@"title":@"我的微店"},@{@"imageName":@"menu_store.png",@"title":@"我的门店"},@{@"imageName":@"menu_help.png",@"title":@"帮助中心"},@{@"imageName":@"menu_recommend.png",@"title":@"推荐给好友"},@{@"imageName":@"menu_set.png",@"title":@"设置"}];
    tab.sourceData = @[@{@"imageName":@"menu_myshop.png",@"title":@"我的关注"},@{@"imageName":@"menu_help.png",@"title":@"帮助中心"},@{@"imageName":@"menu_recommend.png",@"title":@"推荐给好友"},@{@"imageName":@"menu_set.png",@"title":@"设置"}];
}

//设置tableView头部视图
- (void)setTableViewHeaderView:(UITableView *)tableView
{
    UIControl *headeView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, 115)];
    [headeView addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    tableView.tableHeaderView = headeView;
    
    //icon
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 35, 60, 60)];
    [headeView addSubview:iconView];
    _shopLogoImgView = iconView;
    iconView.layer.cornerRadius = 30;
    iconView.layer.masksToBounds = YES;
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 35+11.5, SScreenWidth-100-85-10, 37)];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = SSColorWithRGB(66, 68, 70, 1);
    [headeView addSubview:titleLabel];
    _shopTitleLb = titleLabel;
    
    //线条
    AMDLineView *line = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 115-0.5, SScreenWidth, 0.5) Color:SSColorWithRGB(209, 202, 198, 1)];
    [headeView addSubview:line];
}

//退出视图
- (void)initExitView
{
    //线条
    AMDLineView *line = [[AMDLineView alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-50, SScreenWidth, 0.5) Color:SSColorWithRGB(230, 230, 230, 1)];
    [self.contentView addSubview:line];
    
    //退出
//    AASButton *exitbt = [[AASButton alloc]initWithFrame:CGRectMake(0, self.contentView.frame.size.height-50, SScreenWidth-100, 50)];
//    exitbt.titleLabel.text = @"退出";
//    exitbt.titleLabel.textColor = ColorWithRGB(119, 119, 119, 1);
//    exitbt.imageView.image = imageFromPath(@"menu_signout.png");
//    exitbt.imageView.frame = CGRectMake(20, 13, 24, 24);
////    exitbt.selectBackgroundColor = [UIColor whiteColor];
////    [loginbt setBackgroundColor:AASNavBarColor forState:UIControlStateNormal];
//    [exitbt setBackgroundColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [exitbt addTarget:self action:@selector(clickExit:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:exitbt];
}


#pragma mark - 按钮事件
//进入到我的店铺
- (void)clickAction:(UIButton *)sender
{
//    AASShopInfoController *feedBackVC = [[AASShopInfoController alloc]initWithTitle:@"店铺信息"];
//    [AASTool pushViewController:feedBackVC];
}

- (void)clickExit:(UIButton *)sender
{
//    __weak typeof(self) weakself = self;
//    [[AASCommonClass sharedAASCommonClass] showAlertTitle:@"温馨提醒" Message:@"确定退出当前账号么" action:^(NSInteger index) {
//        if (index == 1) {//退出
//            [weakself handleExitLogin];
//        }
//    } cancelBt:@"取消" otherButtonTitles:@"退出", nil];
}

//退出登录
- (void)handleExitLogin
{
//    SetDefaults(AASHasLogin, @NO);
//    //清空本地的token
//    RemoveDefaults(AASRefreshToken);
//    SetDefaultsSynchronize();
//
//    //清除webview的cookie---避免我的统计页面缓存问题
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//    for (NSHTTPCookie *cookie in cookies) {
//        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//    }
//
//    //跳转到登录
//    AASAppIndexViewController *indexVC = [[AASAppIndexViewController alloc]initWithTitle:nil titileViewShow:NO tabBarShow:NO];
//    indexVC.delegateVC = self.menuVC.navigationController.viewControllers[0];
//    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:indexVC];
//    navVC.navigationBarHidden = YES;
//    navVC.interactivePopGestureRecognizer.delegate = indexVC;
//    __weak typeof(self) weakself = self;
//    [AASTool presentModelController:navVC completion:^{
//        //退出到引导页面
//        [weakself.menuVC.navigationController popToRootViewControllerAnimated:YES];
//    }];
}


#pragma mark - CustomTableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView CellAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellider = @"cell";
    AASMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellider];
    if (cell == nil) {
        cell = [[AASMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellider];
    }
    NSDictionary *dict = _currentTableView.sourceData[indexPath.row];
    UIImage *image = [UIImage imageNamed:(dict[@"imageName"])];
    cell.iconImageView.image = image;
    cell.titleLabel.text = dict[@"title"];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    switch (indexPath.row+1) {
        case 1:{//我的微店
            //
            [self.menuVC showRootController:YES];
        }
            break;
//        case 1:{//我的门店
//            AASStoreHomeController *VC = [[AASStoreHomeController alloc]initWithTitle:nil titileViewShow:NO tabBarShow:NO];
//            [AASTool pushViewController:VC];
//        }
//            break;
        case 2:{//帮助中心
//            AASHelpCenterController *feedBackVC = [[AASHelpCenterController alloc]initWithTitle:@"帮助中心"];
//            [AASTool pushViewController:feedBackVC];
        }
            break;
        case 3:{//推荐给好友
//            AASShareCommonController *feedBackVC = [[AASShareCommonController alloc]initWithTitle:@"推荐给好友"];
//            feedBackVC.shareTitle = @"有量微店";
//            feedBackVC.shareImageURL = [NSString stringWithFormat:@"local:%@",GetFilePath(@"icon120x120.png")];
//            feedBackVC.shareInfoURL = @"http://wdwd.com/app/";
//            feedBackVC.shareType = AASShareTypeApp;
//            [AASTool pushViewController:feedBackVC];
        }
            break;
        case 4:{//设置
//            AASSetIndexController *feedBackVC = [[AASSetIndexController alloc]initWithTitle:@"设置" titileViewShow:YES tabBarShow:NO];
//            [AASTool pushViewController:feedBackVC];
        }
            break;
            
        default:
            break;
    }
}



@end





