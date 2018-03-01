//
//	Data.h
//
//	Create by 清霞 马 on 1/3/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "AMDBaseModel.h"

@protocol Data @end
@interface Data : AMDBaseModel

@property (nonatomic, strong) NSString * expect;
// 12,13,18,21,29+02,08
@property (nonatomic, strong) NSString * opencode;
@property (nonatomic, strong) NSString * opentime;
@property (nonatomic, assign) NSInteger opentimestamp;

#pragma mark - 解析使用
@property(nonatomic, strong) NSArray *redArry;
@property(nonatomic, strong) NSArray *blueArry;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)toDictionary;
@end
