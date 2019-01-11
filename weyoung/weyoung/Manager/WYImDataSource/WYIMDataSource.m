//
//  WYIMDataSource.m
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYIMDataSource.h"

@implementation WYIMDataSource


+ (WYIMDataSource *)shareInstance {
    static WYIMDataSource *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

@end
