//
//	LotteryModel.h
//
//	Create by 清霞 马 on 1/3/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "Data.h"

@interface LotteryModel : NSObject

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSArray<Data> *data;
@property (nonatomic, strong) NSString * info;
@property (nonatomic, assign) NSInteger rows;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
