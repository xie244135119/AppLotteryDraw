//
//	LotteryModel.m
//
//	Create by 清霞 马 on 1/3/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LotteryModel.h"

NSString *const kLotteryModelCode = @"code";
NSString *const kLotteryModelData = @"data";
NSString *const kLotteryModelInfo = @"info";
NSString *const kLotteryModelRows = @"rows";

@interface LotteryModel ()
@end
@implementation LotteryModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLotteryModelCode] isKindOfClass:[NSNull class]]){
		self.code = dictionary[kLotteryModelCode];
	}	
	if(dictionary[kLotteryModelData] != nil && [dictionary[kLotteryModelData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kLotteryModelData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			Data * dataItem = [[Data alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kLotteryModelInfo] isKindOfClass:[NSNull class]]){
		self.info = dictionary[kLotteryModelInfo];
	}	
	if(![dictionary[kLotteryModelRows] isKindOfClass:[NSNull class]]){
		self.rows = [dictionary[kLotteryModelRows] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.code != nil){
		dictionary[kLotteryModelCode] = self.code;
	}
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(Data * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kLotteryModelData] = dictionaryElements;
	}
	if(self.info != nil){
		dictionary[kLotteryModelInfo] = self.info;
	}
	dictionary[kLotteryModelRows] = @(self.rows);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.code != nil){
		[aCoder encodeObject:self.code forKey:kLotteryModelCode];
	}
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kLotteryModelData];
	}
	if(self.info != nil){
		[aCoder encodeObject:self.info forKey:kLotteryModelInfo];
	}
	[aCoder encodeObject:@(self.rows) forKey:kLotteryModelRows];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.code = [aDecoder decodeObjectForKey:kLotteryModelCode];
	self.data = [aDecoder decodeObjectForKey:kLotteryModelData];
	self.info = [aDecoder decodeObjectForKey:kLotteryModelInfo];
	self.rows = [[aDecoder decodeObjectForKey:kLotteryModelRows] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LotteryModel *copy = [LotteryModel new];

	copy.code = [self.code copy];
	copy.data = [self.data copy];
	copy.info = [self.info copy];
	copy.rows = self.rows;

	return copy;
}
@end