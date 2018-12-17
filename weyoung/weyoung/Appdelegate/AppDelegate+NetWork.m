//
//  AppDelegate+NetWork.m
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "AppDelegate+NetWork.h"

@implementation AppDelegate (NetWork)

- (void)NetworkMonitoring
{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.开启监听
    [manger startMonitoring];
    //3.监听网络状态的改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown = -1,
         AFNetworkReachabilityStatusNotReachable = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"此时没有网络");
                [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:@"请检查网络连接"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"移动网络");
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                
                break;
            default:
                break;
        }
    }];
    
 
}
@end
