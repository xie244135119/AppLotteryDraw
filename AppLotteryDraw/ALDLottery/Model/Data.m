//
//	Data.m
//
//	Create by 清霞 马 on 1/3/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Data.h"

NSString *const kDataExpect = @"expect";
NSString *const kDataOpencode = @"opencode";
NSString *const kDataOpentime = @"opentime";
NSString *const kDataOpentimestamp = @"opentimestamp";

@interface Data ()
@end
@implementation Data




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kDataExpect] isKindOfClass:[NSNull class]]){
		self.expect = dictionary[kDataExpect];
	}	
	if(![dictionary[kDataOpencode] isKindOfClass:[NSNull class]]){
		self.opencode = dictionary[kDataOpencode];
	}	
	if(![dictionary[kDataOpentime] isKindOfClass:[NSNull class]]){
		self.opentime = dictionary[kDataOpentime];
	}	
	if(![dictionary[kDataOpentimestamp] isKindOfClass:[NSNull class]]){
		self.opentimestamp = [dictionary[kDataOpentimestamp] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.expect != nil){
		dictionary[kDataExpect] = self.expect;
	}
	if(self.opencode != nil){
		dictionary[kDataOpencode] = self.opencode;
	}
	if(self.opentime != nil){
		dictionary[kDataOpentime] = self.opentime;
	}
	dictionary[kDataOpentimestamp] = @(self.opentimestamp);
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
	if(self.expect != nil){
		[aCoder encodeObject:self.expect forKey:kDataExpect];
	}
	if(self.opencode != nil){
		[aCoder encodeObject:self.opencode forKey:kDataOpencode];
	}
	if(self.opentime != nil){
		[aCoder encodeObject:self.opentime forKey:kDataOpentime];
	}
	[aCoder encodeObject:@(self.opentimestamp) forKey:kDataOpentimestamp];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.expect = [aDecoder decodeObjectForKey:kDataExpect];
	self.opencode = [aDecoder decodeObjectForKey:kDataOpencode];
	self.opentime = [aDecoder decodeObjectForKey:kDataOpentime];
	self.opentimestamp = [[aDecoder decodeObjectForKey:kDataOpentimestamp] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	Data *copy = [Data new];

	copy.expect = [self.expect copy];
	copy.opencode = [self.opencode copy];
	copy.opentime = [self.opentime copy];
	copy.opentimestamp = self.opentimestamp;

	return copy;
}

-(void)setOpencode:(NSString *)opencode{
    if (opencode.length>0) {
        _opencode = opencode;
        [self resolveOpenCode];
    }
}

//分解opencode
-(void)resolveOpenCode{
    NSArray  *array = [_opencode componentsSeparatedByString:@"+"];
    if (array != 0) {
        //蓝色号
        _blueArry = [array[1] componentsSeparatedByString:@","];
        //红色号
        _redArry = [array[0] componentsSeparatedByString:@","];
    }else{
        //只有红色号
        NSArray  *redArray = [_opencode componentsSeparatedByString:@","];
        _redArry = redArray;
    }
}


@end




