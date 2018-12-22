//
//  AppDelegate+RongCloud.m
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "AppDelegate+RongCloud.h"

@implementation AppDelegate (RongCloud)

-(void)registerRongCloud
{
    [[RCIM sharedRCIM] initWithAppKey:@"sfci50a7s3f7i"];
    
    [[RCIM sharedRCIM] setGlobalNavigationBarTintColor:[UIColor binaryColor:@"000000"]];
}
@end
