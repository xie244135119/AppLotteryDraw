//
//  ASDSettingController.m
//  AppMicroDistribution
//
//  Created by 马清霞 on 16/2/26.
//  Copyright © 2016年 SunSet. All rights reserved.
//

#import "ASDSettingController.h"
#import <Masonry/Masonry.h>
#import "AMDNotificationSettingsViewController.h"
#import "AMDFeedBackViewController.h"

@interface ASDSettingController ()<CustomTableViewDelegate>
@property (nonatomic, strong)NSArray *sourceArr;
@property (nonatomic, strong)CustomTableView *currentTab;
@end

@implementation ASDSettingController

//+ (void)load
//{
//    [AMDRouter registerURLPattern:@"ylwfx://asd/myindex/setting" withClass:[self class] withDescription:@"设置"];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = @"设置";
    [self initContentView];
}

- (void)initContentView {
//    self.supportBackBt = YES;
    self.sourceArr = @[@[@"提醒通知设置"],@[@"意见反馈"]];
    
    CustomTableView *tab = [[CustomTableView alloc]initWithType:kCustomTableViewTypeGroup];
    tab.delegate = self;
    _currentTab = tab;
    [self.contentView addSubview:tab];
    tab.sourceData = self.sourceArr;
    tab.tableView.estimatedSectionHeaderHeight = 0;
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.offset(0);
    }];
    
    //头视图
    tab.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];

    
}

#pragma mark - 按钮事件

#pragma mark - CustomTableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView CellAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"AAcells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = SSFontWithName(@"", 15);
        cell.textLabel.textColor =SSColorWithRGB(51,51,51, 1);
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.font = SSFontWithName(@"", 14);
    }
    
    AMDLineView *line = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, SSLineHeight) Color:SSLineColor];
    [cell addSubview:line];
    AMDLineView *line2 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height, SScreenWidth, SSLineHeight) Color:SSLineColor];
    [cell addSubview:line2];
    cell.textLabel.text = self.sourceArr[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)//提醒通知设置
    {
        AMDNotificationSettingsViewController *VC = [[AMDNotificationSettingsViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
//        [AMDRouter openURL:AMDNotificationSettingsURLPath];
        
    }else if (indexPath.section == 2){//关于佰酿
        
    }else{
        switch (indexPath.row) {
            case 0:             //意见反馈
            {
                                AMDFeedBackViewController *feedBack = [[AMDFeedBackViewController alloc]initWithTitle:@"意见反馈" titileViewShow:YES tabBarShow:NO];
                                [self.navigationController pushViewController:feedBack animated:YES];
//                [AMDRouter openURL:AMDFeedBackURLPath];
            }
                break;
            default:
                break;
        }
        
    }
}


@end



