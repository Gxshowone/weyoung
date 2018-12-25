//
//  AppDelegate.m
//  weyoung
//
//  Created by gongxin on 2018/12/6.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RongCloud.h"
#import "AppDelegate+KeyboardManager.h"


#import "WYLoginViewController.h"
#import "WYHomePageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
   
    //注册容云
    [self registerRongCloud];
    
    //键盘管理器
    [self registerKeyboardManager];
   
 
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
      UINavigationController * rootNav   = [[UINavigationController alloc] initWithRootViewController:[[WYHomePageViewController alloc]init]];
    _window.rootViewController = rootNav;
    [_window makeKeyAndVisible];

    [self setNavigationBarConfig];
    
    return YES;
}


-(void)setNavigationBarConfig
{
    //统一导航条样式
    UIFont *font = [UIFont systemFontOfSize:16.f];
    NSDictionary *textAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : [UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
