//
//  ViewController.m
//  AppLotteryDraw
//
//  Created by SunSet on 2018/2/28.
//  Copyright © 2018年 SunSet. All rights reserved.
//

#import "ViewController.h"
#import "LotteryDrawResultListController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)clickAction:(id)sender {
    LotteryDrawResultListController *VC = [[LotteryDrawResultListController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
