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
#import "WYMainViewController.h"
#import <KSGuaidViewManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
   
    //注册容云
    [self registerRongCloud:launchOptions];
    
    //键盘管理器
    [self registerKeyboardManager];
    
    [self creatGuide];

    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    [self setRootController];
    
    [_window makeKeyAndVisible];

    [self setNavigationBarConfig];
    
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //注册推送，用于iOS8之前的系统
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    
    return YES;
}

-(void)creatGuide
{
  
    NSString * guideCache = [[NSUserDefaults standardUserDefaults] valueForKey:@"guideCache"];
    
    if (IsStrEmpty(guideCache)) {
        NSArray * normalArray =@[[UIImage imageNamed:@"guide_1"],[UIImage imageNamed:@"guide_2"],[UIImage imageNamed:@"guide_3"]];
        NSArray * xArray  = @[[UIImage imageNamed:@"guide_x_1"],[UIImage imageNamed:@"guide_x_2"],[UIImage imageNamed:@"guide_x_3"]];
        KSGuaidManager.images = (IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES)?xArray:normalArray;
        KSGuaidManager.shouldDismissWhenDragging = YES;
        [KSGuaidManager begin];
        [[NSUserDefaults standardUserDefaults] setValue:@"1.0.0" forKey:@"guideCache"];
    }
    
}

//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}


-(void)setRootController
{
    UINavigationController * rootNav;
    
    if ([[WYSession sharedSession] isLogin]) {
        
        rootNav   = [[UINavigationController alloc] initWithRootViewController:[[WYMainViewController alloc]init]];
        _window.rootViewController = rootNav;
    }else
        
    {
        rootNav   = [[UINavigationController alloc] initWithRootViewController:[[WYLoginViewController alloc]init]];
        _window.rootViewController = rootNav;
    }
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
