//
//  AMDNotificationSettingsViewController.m
//  AppMicroDistribution
//
//  Created by 马清霞 on 15/5/22.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//

#import "AMDNotificationSettingsViewController.h"
//#import "AMDNotificationModel.h"
#import<Masonry.h>
//#import "STMConstVar.h"
//#import <AMDNetworkService/AMDNetworkService.h>
//#import "AMDSettingModule.h"
//#import "AMDRemindViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface AMDNotificationSettingsViewController ()<UIScrollViewDelegate>
{
    NSArray *accountlists;
    NSMutableArray *pushArr;
    NSMutableArray *smsArr;
    NSString *myType;
    NSInteger pushSendNotify;
    NSInteger smsSendNotify;
    NSInteger rcSendNotify;
}
@property (nonatomic, strong)NSArray *imgArr;
//@property (nonatomic, strong)AMDNotificationModel *currentModel;
@property (nonatomic, strong)UIButton* notificationMobile;
@property (nonatomic, strong)UISwitch* notificationSMS;
@property (nonatomic, strong)UISwitch* notificationRC;

@end

@implementation AMDNotificationSettingsViewController

//+ (void)load
//{
//    // 调用
//    [AMDRouter registerURLPattern:AMDNotificationSettingsURLPath withClass:[self class] withDescription:@"提醒通知设置"];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = @"提醒通知设置";
//    pushArr = [NSMutableArray array];
//    smsArr = [NSMutableArray array];
    [self initContentTableView];
//    [self startRequestNotification];
}


-(void)initContentTableView{
//    self.supportBackBt = YES;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(SScreenWidth, SScreenHeight+1);
    [self.contentView addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    //第一行cell视图
    UIView *cell1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SScreenWidth, 50)];
    cell1.backgroundColor = [UIColor whiteColor];
    //     分区title
    UILabel *contentLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 75, SScreenWidth-10, 40)];
    contentLB.font = SSFontWithName(@"", 12);
    //多少行
    contentLB.numberOfLines = 0;
    //怎么断句
    contentLB.lineBreakMode = 0;

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    contentLB.text = [[NSString alloc]initWithFormat:@"请打开“设置”->“通知”，找到“%@”并允许通知。开启推送设置，可及时接收开奖信息提醒。",app_Name];

    contentLB.textColor =  SSColorWithRGB(119,119,119, 1);
    [scrollView addSubview:contentLB];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SScreenWidth-70, 50/2-15, 55, 30)];
    label.textColor =  SSColorWithRGB(119,119,119, 1);
    label.font = SSFontWithName(@"", 14);
    [cell1 addSubview:label];
    [contentLB sizeToFit];
    
        //iOS 10以上
    id notificationCenter = NSClassFromString(@"UNUserNotificationCenter");
    if (notificationCenter !=nil ) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
//            NSLog(@"%ld",(long)settings.authorizationStatus);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                    label.text = @"已开启";
                }else{
                    label.text = @"未开启";
                }
            });
        }];
    }else{
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue < 10) { // iOS系统版本 <10
            UIUserNotificationSettings* type = [[UIApplication sharedApplication] currentUserNotificationSettings];
            if (UIUserNotificationTypeNone != type.types) {
                label.text = @"已开启";
            }else{
                label.text = @"未开启";
            }
        }
    }
    
    AMDLineView *line = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, SSLineHeight) Color:SSLineColor];
    [cell1 addSubview:line];
    AMDLineView *line4 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 50, SScreenWidth, SSLineHeight) Color:SSLineColor];
    [cell1 addSubview:line4];
    UILabel *titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 50/2-20, 150, 40)];
    titleLB.font = SSFontWithName(@"", 15);
    titleLB.text = @"推送设置";
    titleLB.textColor =SSColorWithRGB(51,51,51, 1);
    [cell1 addSubview:titleLB];
    
//    //第二行cell视图
//    UIView *cell2 = [[UIView alloc]initWithFrame:CGRectMake(0, 120, SScreenWidth, 50)];
//    cell2.backgroundColor = [UIColor whiteColor];
//    AMDLineView *line2 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, SSLineHeight) Color:SSLineColor];
//    [cell2 addSubview:line2];
//    AMDLineView *line3 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 50, SScreenWidth, SSLineHeight) Color:SSLineColor];
//    [cell2 addSubview:line3];
//    UILabel *titleLB2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50/2-20, 150, 40)];
//    titleLB2.font = SSFontWithName(@"", 15);
//    titleLB2.text = @"短信提示";
//    titleLB2.textColor =SSColorWithRGB(51,51,51, 1);
//    [cell2 addSubview:titleLB2];
//    
//    UISwitch *swich = [[UISwitch alloc]initWithFrame:CGRectMake(SScreenWidth-70, 50/2-15, 55, 30)];
//    [swich addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    swich.onTintColor = btn_dark_color;
//    _notificationSMS = swich;
//    [cell2 addSubview:swich];
    
    //第三行cell视图
//    AMDButton *cell3 = [[AMDButton alloc]initWithFrame:CGRectMake(0, 120, SScreenWidth, 50)];
//    AMDLineView *line22 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 0, SScreenWidth, SSLineHeight) Color:SSLineColor];
//    [cell3 addSubview:line22];
//    AMDLineView *line33 = [[AMDLineView alloc]initWithFrame:CGRectMake(0, 50, SScreenWidth, SSLineHeight) Color:SSLineColor];
//    [cell3 addSubview:line33];
//    UILabel *titleLB3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50/2-20, 150, 40)];
//    titleLB3.font = SSFontWithName(@"", 15);
//    titleLB3.text = @"消息免打扰";
//    titleLB3.textColor = SSColorWithRGB(51,51,51, 1);
//    [cell3 addSubview:titleLB3];
//    [cell3 setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cell3 setBackgroundColor:SSLineColor forState:UIControlStateHighlighted];
//    [cell3 addTarget:self action:@selector(startSettingPush) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(SScreenWidth-35, 15, 23, 23)];
//    imgv.image = STMImageName(@"arrow-right@2x.png");
//    [cell3 addSubview:imgv];
//    [scrollView addSubview:cell3];
    [scrollView addSubview:cell1];
//    [scrollView addSubview:cell2];
    
}


//-(void)startSettingPush{
//        AMDRemindViewController *settingPush = [[AMDRemindViewController alloc]initWithTitle:@"功能消息免打扰" titileViewShow:YES tabBarShow:NO];
//        [self.navigationController pushViewController:settingPush animated:YES];
////    [AMDRouter openURL:AMDDontDisturbURLPath];
//}


#pragma mark - switch点击方法
//消息提示
//-(void)switchActions:(UISwitch *)sender{
//    myType = @"rc";
//    if (sender.on) {
//        rcSendNotify = 2;
//    }else{
//        rcSendNotify = 1;
//    }
//    [self startRequestSettingNotification:rcSendNotify];
//}


////短信统一提示设置
//-(void)switchAction:(UISwitch *)sender{
//    
//    myType = @"sms";
//    if (sender.on == NO) {
//        smsSendNotify = 2;
//    }else{
//        smsSendNotify = 1;
//    }
//    [self startRequestSettingNotification:smsSendNotify];
//}


#pragma mark -请求数据
////获取设置列表
//-(void)startRequestNotification{
//    //  /api/nova-notify/notify/wfx-shop/setting
//    NSString *urlPath = [STMMessageURLPath stringByAppendingString:@"/wfx-shop/setting"];
//    NSDictionary *dic = @{@"shop_id":[AMDSettingModule module].requestDelegate.stm_shop_id};
////    [[AMDRequestService sharedAMDRequestService] requestWithGetURL:urlPath parameters:dic type:001 delegate:self animation:NO];
//    [self actionRequest:urlPath params:dic requestType:NSRequestGET resultType:001];
//}
//
//
////设置
//-(void)startRequestSettingNotification :(NSInteger)sendNotify{
//    //  /api/nova-notify/notify/wfx-shop/setting
//    NSString *urlPath = [STMMessageURLPath stringByAppendingString:@"/wfx-shop/setting"];
//    NSDictionary *dic = @{@"data":@{@"shop_id":[AMDSettingModule module].requestDelegate.stm_shop_id,@"notify_type":myType,@"send_notify":@(sendNotify)}};
////    [[AMDRequestService sharedAMDRequestService] requestWithPOSTURL:urlPath parameters:dic type:002 delegate:self animation:NO];
//    [self actionRequest:urlPath params:dic requestType:NSRequestPOST resultType:002];
//}
//
//- (void)actionRequest:(NSString *)url params:(NSDictionary *)params requestType:(NSRequestType)requestType resultType:(NSUInteger)resultType
//{
//    __weak typeof(self) weakself = self;
//    NSHttpRequest *request = [[NSHttpRequest alloc]init];
//    request.urlPath = url;
//    request.requestParams = params;
//    request.type = requestType;
//    request.completion = ^(id responseObject, NSError *error) {
//        [weakself requestFinished:responseObject type:resultType];
//    };
//    [[NSApi shareInstance]sendReq:request];
//}
//
////请求成功
//- (void)requestFinished:(NSDictionary *)resault type:(NSUInteger)type{
//    if (![resault[@"status"] isEqualToString:@"success"]) {
//        return;
//    }
//    switch (type) {
//        case 001:
//        {
//            NSDictionary *data = resault[@"data"];
//            NSArray *lists = data[@"notify_setting_arr"];
//            if (lists.count > 0) {
//                accountlists = [self modelsFromArray:lists modelClass:[AMDNotificationModel class]];
//                if ([[accountlists[0] valueForKey:@"shop_notify_sms"] intValue]== 1) {//发送
//                    smsSendNotify = 1;
//                    _notificationSMS.on = YES;
//                }else{//不发送
//                    smsSendNotify = 2;
//                    _notificationSMS.on = NO;
//                }
//                if ([[accountlists[0] valueForKey:@"shop_notify_rc"] intValue]== 1) {//发送
//                    rcSendNotify = 1;
//                    _notificationRC.on = NO;
//                }else{//不发送
//                    rcSendNotify = 2;
//                    _notificationRC.on = YES;
//                }
//
//            }
//        }
//            break;
//        case 002:
//        {
//            //            [AMDIMService sharedAMDIMService] .chatDisturbState = rcSendNotify == 2?1:2;
//        }
//        default:
//            break;
//    }
//}
//
//
////请求失败
//- (void)requestFailed:(id)resault error:(NSError *)error type:(NSUInteger)type{
//
//}
//
//- (NSArray *)modelsFromArray:(NSArray *)arry modelClass:(Class)typeclass
//{
//    __block NSMutableArray *resault = [[NSMutableArray alloc]initWithCapacity:arry.count];
//    [arry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        NSError *error = nil;
//        id model = [[typeclass alloc] initWithDictionary:obj error:&error];
//        [resault addObject:model];
//    }];
//    return resault;
//}

@end
