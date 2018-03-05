//
//  AMDFeedBackViewController.m
//  AppMicroDistribution
//
//  Created by 马清霞 on 15/5/24.
//  Copyright (c) 2015年 SunSet. All rights reserved.
//
//static NSString *WWDCNotification = @"WWDCNotification";
//static NSString *WWDCNotifications = @"WWDCNotifications";


#import "AMDFeedBackViewController.h"
//#import "AMDFeedBackImageView.h"
//#import "AMDDebugControl.h"
#import <Masonry.h>
//#import "AMDSettingModule.h"
//#import "AMDDebugControl.h"
#import <AMDNetworkService/AMDNetworkService.h>
//#import "STMConstVar.h"

@interface AMDFeedBackViewController ()<AMDControllerTransitionDelegate>
{
    NSString *_severDomain;         //服务器端的bucket
    NSInteger _currentImageCount;//当前图片数量
//    AMDFeedBackImageView *_currentImageView;
}
@property (nonatomic, strong) CustomTextView *contentTextView;
//@property (nonatomic, strong) AMDPhotoService *photoService;          //相机或相册
@property (nonatomic, strong) AMDButton *addImgBT;                         //添加图片按钮
@end

@implementation AMDFeedBackViewController

//+ (void)load
//{
//    // 调用
//    [AMDRouter registerURLPattern:AMDFeedBackURLPath withClass:[self class] withDescription:@"意见反馈"];
//}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    self.photoService = nil;
//    self.addImgBT = nil;
//    _currentImageView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleView.title = @"意见反馈";
    [self initContentView];
    [self shakedownTest];
}

#pragma mark - 搭建界面
//初始化调试界面
-(void)shakedownTest{
    self.titleView.titleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(debugClick)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.numberOfTapsRequired = 5;
    [self.titleView.titleLabel addGestureRecognizer:tapGestureRecognizer];
}

- (void)initContentView {
//    self.supportBackBt = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.contentSize = CGSizeMake(SScreenWidth, scrollView.frame.size.height+1) ;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.contentView addSubview:scrollView];

    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    
    
    //上面的输入框
    CustomTextView *tv=[[CustomTextView alloc]initWithFrame:CGRectMake(10, 20,SScreenWidth-20 , 150)];
    tv.placeHolderLabel.text = @"请写下你的任何意见或建议，我们会认真聆听，感谢您对我们的支持～";
    tv.placeHolderLabel.textColor =SSColorWithRGB(204, 204, 204, 1);
    tv.placeHolderLabel.amd_height = 30;
    tv.placeHolderLabel.font = SSFontWithName(@"", 14);
    self.contentTextView = tv;
    tv.placeHolderLabel.numberOfLines = 0;
    [scrollView addSubview:tv];
    tv.customText = self.feedbackText;
    tv.font = SSFontWithName(@"", 14);

    //反馈图片视图
//    _currentImageView = [[AMDFeedBackImageView alloc]initWithFrame:CGRectMake(10, tv.frame.size.height+30, SScreenWidth-20, 80)];
//    _currentImageView.delegate = self;
//    [scrollView addSubview:_currentImageView];
    
//    //添加图片按钮
//    _addImgBT = [[AMDButton alloc]initWithFrame:CGRectMake(10, tv.frame.size.height+40, SScreenWidth-20, 50)];
//    [scrollView addSubview:_addImgBT];
//    _addImgBT.tag = 1;
//    _addImgBT.titleLabel.text = @"添加图片";
//    _addImgBT.titleLabel.font = SSFontWithName(@"", 14);
//    [_addImgBT setBackgroundColor:nil forState:UIControlStateHighlighted];
//    [_addImgBT setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_addImgBT setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    _addImgBT.layer.borderColor = SSLineColor.CGColor;//边框颜色
//    _addImgBT.layer.cornerRadius=1;
//    _addImgBT.layer.borderWidth = 0.5;
//    [_addImgBT addTarget:self action:@selector(clickBT:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加右边nav按钮
    AMDButton *saveBT = [[AMDButton alloc]initWithFrame:CGRectMake(SScreenWidth-50, 0, 50, 44)];
    saveBT.titleLabel.text = @"确定";
    saveBT.titleLabel.font = SSFontWithName(@"", 16);
    saveBT.tag = 2;
    [saveBT setTitleColor:self.titleView.titleLabel.textColor forState:UIControlStateNormal];
    [saveBT addTarget:self action:@selector(clickBT:) forControlEvents:UIControlEventTouchUpInside];
    self.titleView.rightViews = @[saveBT];
}

//#pragma mark - AMDPhotoServiceDelegate
//- (void)pickerType:(UIImagePickerControllerSourceType)type
//   orignPhotoPaths:(NSArray *)photopaths
//       thumpImages:(NSArray *)thumpimages{
//    [_currentImageView.imgPathArr addObjectsFromArray:photopaths];
//
//    //调整按钮位置 然后加载图片
//    [UIView animateWithDuration:.25 animations:^{
//        _addImgBT.frame = CGRectMake(10,  150+60+(SScreenWidth-20)/4-5, SScreenWidth-20, 50);
//    } completion:^(BOOL finished) {
//        for (UIImage *img in thumpimages) {
//            [_currentImageView addImageViewWithImage:img];
//        }
//    }];
//
//    //调整按钮title
//    if (_currentImageCount<4) {
//        _addImgBT.titleLabel.text = [NSString stringWithFormat:@"还能传%ld图片", 4-_currentImageCount];
//        _addImgBT.selected = NO;
//    }else{
//        _addImgBT.titleLabel.text = [NSString stringWithFormat:@"只能传4张图片"];
//        _addImgBT.selected = YES;
//        _addImgBT.userInteractionEnabled = NO;
//    }
//}

#pragma mark - 点击事件
-(void)clickBT:(AMDButton *)sender{
    [self.contentTextView resignFirstResponder];
//   AMDSettingModule *manager = [AMDSettingModule module];
    switch (sender.tag) {
//        case 1://添加图片
//        {
//            __weak typeof(self) weakself = self;
//            if ([manager.requestDelegate respondsToSelector:@selector(selectImage:completion:)]) {
//              [ manager.requestDelegate selectImage:4-_currentImageCount completion:^(NSArray *photopaths, NSArray *thumpimages) {
//                  [weakself pickerType:UIImagePickerControllerSourceTypeCamera orignPhotoPaths:photopaths thumpImages:thumpimages];
//                }];
//            }
//
////            if (!self.photoService) {
////                AMDPhotoService *service = [[AMDPhotoService alloc]init];
////                self.photoService = service;
////                service.rootViewController = self;
////                service.delegate = self;
////            }
////            self.photoService.maximumNumberOfSelection = 4-_currentImageCount;
////            [self.photoService showAction];
//        }
//            break;
        case 2://确定
        {
            
            sleep(1);
            
            __weak typeof(self) weakself = self;
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"感谢您的反馈 我们将迅速处理" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakself.navigationController popViewControllerAnimated:YES];
            }];
            
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
//            if (_currentImageCount == 0&&self.contentTextView.text.length == 0) {
//                [manager.requestDelegate showToastWithTitle:@"请输入反馈内容或图片"];
////                [AMDUIFactory makeToken:self.contentView message:@"请输入反馈内容或图片"];
//                return;
//            }
//
//            //如果有图片 获取七牛token并且上传图片  没有直接请求反馈
//            if (_currentImageCount>0) {
//                [self invokeGetQiniuTokenRequest];
//            }else{
//                [self invokeFeedBackRequestWithPhotos:@[]];
//            }
        }
            break;

        default:
            break;
    }
}

//点击进入调试
//-(void)debugClick{
//    __weak typeof(self) weakself = self;
//    UIAlertController *VC = [UIAlertController alertControllerWithTitle:@"是否进入调试界面" message:nil
//                                                         preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *affirmAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        AMDDebugControl *VC = [[AMDDebugControl alloc]init];
//        [weakself.navigationController pushViewController:VC animated:YES];
//    }];
//    [VC addAction:cancelAction];
//    [VC addAction:affirmAction];
//    [self presentViewController:VC animated:YES completion:nil];

    
//    [[AMDCommonClass sharedAMDCommonClass] showAlertTitle:@"是否进入调试界面" Message:nil action:^(NSInteger index) {
//        switch (index) {
//            case 1:     //确定
//            {
//                [AMDRouter openURL:@"ylwfx://amd/mysetting/debug"];
//            }
//                break;
//                
//            default:
//                break;
//        }
//    } cancelBt:@"取消" otherButtonTitles:@"确认", nil];
//}

#pragma mark - 网络请求
//提交意见反馈请求
//- (void)invokeFeedBackRequestWithPhotos:(NSArray *)photokeys
//{
//    NSString *urlpath = @"/api/manager/feedback/add";
//    NSDictionary *params = @{@"shop_id":[AMDSettingModule module].requestDelegate.stm_shop_id,@"feedback":self.contentTextView.text,@"screenshot":photokeys,@"type":@"wfx"};
////    [[AMDRequestService sharedAMDRequestService]requestWithPOSTURL:urlpath parameters:params type:002 delegate:self animation:YES];
//    [self actionRequest:urlpath params:params requestType:(NSRequestType)NSRequestPOST resultType:002];
//}

//获取七牛请求
//- (void)invokeGetQiniuTokenRequest
//{
//    NSString *urlstr = [[NSString alloc]initWithFormat:@"%@/image/qiniu-uploadtoken",STMQiNiuTokenURL];
////    [[AMDRequestService sharedAMDRequestService] requestWithGetURL:urlstr parameters:@{@"image-type":@"other"} type:001 delegate:self animation:YES];
//    [self actionRequest:urlstr params:@{@"image-type":@"other"} requestType:NSRequestGET resultType:001];
//}

//
- (void)actionRequest:(NSString *)url params:(NSDictionary *)params requestType:(NSRequestType)requestType resultType:(NSUInteger)resultType
{
    __weak typeof(self) weakself = self;
    NSHttpConfiguration *config = [[NSHttpConfiguration alloc]init];
    config.animated = YES;
    config.animateView = self.contentView;
    config.controller = self;
    NSHttpRequest *request = [[NSHttpRequest alloc]initWithConfiguration:config];
    request.urlPath = url;
    request.requestParams = params;
    request.type = requestType;
    request.completion = ^(id responseObject, NSError *error) {
//        [weakself requestFinished:responseObject type:resultType];
    };
    [[NSApi shareInstance] sendReq:request];
}

#pragma mark - 请求结果
//请求成功
//- (void)requestFinished:(NSDictionary *)resault type:(NSUInteger)type
//{
//    NSString *status = resault[@"status"];
//    if (![status isEqualToString:@"success"]) {
//        return;
//    }
//    switch (type) {
//        case 002:{//意见反馈成功
//            [[AMDSettingModule module].requestDelegate showToastWithTitle:@"感谢您的反馈 我们将迅速处理"];;
//
////            [AMDUIFactory makeToken:nil message:@"感谢您的反馈 我们将迅速处理"];
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//            break;
//        case 001:{ //获取七牛token
//
//            NSString *token = resault[@"data"][@"token"];
//            _severDomain = resault[@"data"][@"domain"];
//            __weak typeof(self) weakself = self;
//            [[AMDSettingModule module].requestDelegate uploadFilePaths:_currentImageView.imgPathArr token:token completion:^(BOOL result, NSArray *photos) {
//                if (result) {
//                    [weakself uploadFinished:photos];
//                }else{
//                    [weakself uploadFailed:nil failedKey:nil error:nil];
//                }
//            }];
////            [[AMDRequestService sharedAMDRequestService] uploadFilePaths:_currentImageView.imgPathArr token:token delegate:self];
//
//        }
//            break;
//        default:
//            break;
//    }
//}

//上传成功
//- (void)uploadFinished:(NSArray *)keys
//{
//    NSMutableArray *resaultstrs = [[NSMutableArray alloc]init];
//    for (NSString *key in keys) {
//        NSString *str = [_severDomain stringByAppendingString:key];
//        [resaultstrs addObject:str];
//    }
//    [self invokeFeedBackRequestWithPhotos:resaultstrs];
//}

//上传失败
//- (void)uploadFailed:(NSArray *)keys failedKey:(NSString *)key error:(NSError *)error
//{
//    [[AMDSettingModule module].requestDelegate showToastWithTitle:@"上传图片失败 请稍后重试"];;
//    //    NSLog(@" 到某个文件上传失败 %@ 原因 %@",key,error);
////    [AMDUIFactory makeToken:self.contentView message:@"上传图片失败 请稍后重试"];
//}

//请求失败
//- (void)requestFailed:(id)resault error:(NSError *)error type:(NSUInteger)type
//{
////    NSLog(@" %@ ",resault);
//}

#pragma mark - 代理事件
//- (void)viewController:(id)viewController object:(id)sender{
//    if ([viewController isKindOfClass:[AMDFeedBackImageView class]]) {
//        NSNumber* currentImageCount = sender[@"currentCount"];
//        _currentImageCount = currentImageCount.intValue;
//        //当前图片数量为空的时候  还原按钮位置和title
//        if (_currentImageCount == 0) {
//            [UIView animateWithDuration:.25 animations:^{
//                _addImgBT.frame =CGRectMake(10,  190, SScreenWidth-20, 50);
//                _addImgBT.titleLabel.text = @"上传图片";
//            }];
//        }else{
//            //更新按钮上的title
//            _addImgBT.titleLabel.text = [NSString stringWithFormat:@"还能传%d图片", 4-currentImageCount.intValue];
//            _addImgBT.selected = NO;
//            _addImgBT.userInteractionEnabled = YES;
//        }
//    }
//}

@end
