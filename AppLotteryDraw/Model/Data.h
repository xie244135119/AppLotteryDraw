//
//	Data.h
//
//	Create by 清霞 马 on 1/3/2018
//	Copyright © 2018. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
@protocol Data @end
@interface Data : NSObject

@property (nonatomic, strong) NSString * expect;
@property (nonatomic, strong) NSString * opencode;
@property (nonatomic, strong) NSString * opentime;
@property (nonatomic, assign) NSInteger opentimestamp;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
