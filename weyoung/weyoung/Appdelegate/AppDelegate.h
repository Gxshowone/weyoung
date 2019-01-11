//
//  AppDelegate.h
//  weyoung
//
//  Created by gongxin on 2018/12/6.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,RCConnectionStatusChangeDelegate, RCIMClientReceiveMessageDelegate, RCTypingStatusDelegate,RCIMConnectionStatusDelegate,RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

