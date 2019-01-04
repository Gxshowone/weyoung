//
//  WYAssets.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYAssets.h"

NSString *const kWYPickerGroupPropertyID    = @"kWYPickerGroupPropertyID";
NSString *const kWYPickerGroupPropertyURL   = @"kWYPickerGroupPropertyURL";
NSString *const kWYPickerAssetPropertyURL   = @"kWYPickerAssetPropertyURL";

@implementation WYAssets

#pragma mark - NSCoding
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.groupPropertyID = [aDecoder decodeObjectForKey:kWYPickerGroupPropertyID];
        self.groupPropertyURL = [aDecoder decodeObjectForKey:kWYPickerGroupPropertyURL];
        self.assetPropertyURL = [aDecoder decodeObjectForKey:kWYPickerAssetPropertyURL];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_groupPropertyID forKey:kWYPickerGroupPropertyID];
    [aCoder encodeObject:_groupPropertyURL forKey:kWYPickerGroupPropertyURL];
    [aCoder encodeObject:_assetPropertyURL forKey:kWYPickerAssetPropertyURL];
}

@end
