//
//  WYSession.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYSession.h"
#import "WYMainViewController.h"

static NSString *const kSessionPassWord       = @"kSessionPassWord";
static NSString *const kSessionPhone          = @"kSessionPhone";
static NSString *const kSessionToken          = @"kSessionToken";
static NSString *const kSessionUid            = @"kSessionUid";
static NSString *const kSessionNickName       = @"kSessionNickName";
static NSString *const kSessionAvatar         = @"kSessionAvatar";
static NSString *const kSessionSex            = @"kSessionSex";
static NSString *const kSessionBirthday       = @"kSessionBirthday";
static NSString *const kSessionRegon          = @"kSessionRegon";
static NSString *const kSessionLatitude       = @"kSessionLatitude";
static NSString *const kSessionLongitude      = @"kSessionLongitude";
static NSString *const kSessionCountryCode    = @"kSessionCountryCode";
static NSString *const kSessionCity           = @"kSessionCity";
static NSString *const kSessionChannel        = @"kSessionChannel";
static NSString *const kSessionTimeDifference = @"kSessionTimeDifference";
static NSString *const kSessionRcToken = @"kSessionRcToken";

static NSString *const kSessionDynamicCount = @"kSessionDynamicCount";
static NSString *const kSessionFriendCount = @"kSessionFriendCount";


static WYSession *sharedManager=nil;

@interface WYSession ()<RCIMConnectionStatusDelegate>

@property (nonatomic, assign) NSUInteger retryCount;
@property (nonatomic, copy) NSData *deviceToken;
@property (nonatomic, assign) BOOL bRegisterDeviceToken;    //是否已经注册deviceToken

@end

@implementation WYSession
+ (WYSession *)sharedSession{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WYSession alloc] init];
        
    });
    
    return sharedManager;
}

-(void)updateUser:(NSDictionary*)dict
{
    self.dynamic_count  = [[dict valueForKey:@"dynamic_count"] integerValue];
    self.friend_count  = [[dict valueForKey:@"friend_count"] integerValue];
    self.phone = [dict valueForKey:@"phone"];
    self.token = [dict valueForKey:@"token"];
    self.rc_token = [dict valueForKey:@"rc_token"];
    self.uid  =  [dict valueForKey:@"uid"];
    self.nickname = [dict valueForKey:@"nick_name"];
    self.birthday  = [dict valueForKey:@"birthday"];
    self.avatar  = [dict valueForKey:@"header_url"];
    self.rc_token = [dict valueForKey:@"rc_token"];
    self.timeDifference = [[dict valueForKey:@"lastlogin_time"] integerValue];
    
}

-(void)loginUser:(NSDictionary*)dict
           phone:(NSString*)phone
{
 
    self.phone = phone;
    self.token = [dict valueForKey:@"token"];
    self.rc_token = [dict valueForKey:@"rc_token"];
    self.uid  =  [dict valueForKey:@"uid"];
    self.nickname = [dict valueForKey:@"nick_name"];
    self.birthday  = [dict valueForKey:@"birthday"];
    self.avatar  = [dict valueForKey:@"header_url"];
    self.rc_token = [dict valueForKey:@"rc_token"];
    self.timeDifference = [[dict valueForKey:@"lastlogin_time"] integerValue];
    
    [self updateRootController];

    [self connectRc];
}


-(void)connectRc
{
    
    [[RCIM sharedRCIM] connectWithToken:self.rc_token  success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        RCUserInfo *_currentUserInfo = [[RCUserInfo alloc] initWithUserId:userId name:self.nickname portrait:self.avatar];
        [RCIM sharedRCIM].currentUserInfo = _currentUserInfo;
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
        
          [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
          [self retryConnect];
        
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"登陆token错误");
    }];
}

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
{
    switch (status) {
        case ConnectionStatus_Connected:    //  连接成功
        {
            NSLog(@"[gx] 链接成功");
        }
            break;
        case ConnectionStatus_Connecting:   //  连接中
        {
          NSLog(@"[gx] 链接中");
        }
            break;
        case ConnectionStatus_Unconnected:  //  连接失败或未连接
        {
           NSLog(@"[gx] 链接失败");
        }
            break;
        case ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT:   //  当前用户在其他设备上登录，此设备被踢下线
        {
             NSLog(@"[gx] 被踢下线");
        }
            break;
        default:
            break;
    }
}

-(void)retryConnect
{
    
    if (self.retryCount > 3) {
        NSLog(@"融云登录失败达到3次");
        return;
    }
    
    _retryCount++;
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self connectRc];
    });
}

- (void)setDeviceToken:(NSData *)deviceToken
{
    if (self.bRegisterDeviceToken) {
        return;
    }
    
    if ([self bConnected]&&deviceToken!=nil) {
        NSString *token = [deviceToken description];
        token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        [[RCIMClient sharedRCIMClient] setDeviceToken:token];
        self.bRegisterDeviceToken = YES;
    }else{
        _deviceToken = deviceToken;
    }
}

-(void)updateRootController
{
    WYMainViewController * mainVC = [WYMainViewController new];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
}

#pragma mark set


-(void)setPassWord:(NSString *)passWord
{
    [self setValue:passWord forKey:kSessionPassWord];
}

-(void)setPhone:(NSString *)phone
{
    [self setValue:phone forKey:kSessionPhone];
}

-(void)setToken:(NSString *)token
{
    [self setValue:token forKey:kSessionToken];
}
-(void)setUid:(NSString *)uid
{
    [self setValue:uid forKey:kSessionUid];
    
}
-(void)setAvatar:(NSString *)avatar
{
    [self setValue:avatar forKey:kSessionAvatar];
}

-(void)setSex:(NSString *)sex
{
    [self setValue:sex forKey:kSessionSex];
}
-(void)setNickname:(NSString *)nickname
{
    [self setValue:nickname forKey:kSessionNickName];
}

-(void)setBirthday:(NSString *)birthday
{
    [self setValue:birthday forKey:kSessionBirthday];
}

-(void)setRegon:(NSString *)regon
{
    [self setValue:regon forKey:kSessionRegon];
}

-(void)setLatitude:(NSString *)latitude
{
    [self setValue:latitude forKey:kSessionLatitude];
}

-(void)setLongitude:(NSString *)longitude
{
    [self setValue:longitude forKey:kSessionLongitude];
}

-(void)setCountryCode:(NSString *)countryCode
{
    [self setValue:countryCode forKey:kSessionCountryCode];
}

-(void)setCity:(NSString *)city
{
    [self setValue:city forKey:kSessionCity];
}

-(void)setChannel:(NSString *)channel
{
    [self setValue:channel forKey:kSessionChannel];
}

-(void)setTimeDifference:(NSInteger)timeDifference
{
    [self setIntegerValue:timeDifference forkey:kSessionTimeDifference];
}

-(void)setRc_token:(NSString *)rc_token
{
    [self setValue:rc_token forKey:kSessionRcToken];
}

-(void)setDynamic_count:(NSInteger)dynamic_count
{
    [self setIntegerValue:dynamic_count forkey:kSessionDynamicCount];
}

-(void)setFriend_count:(NSInteger)friend_count
{
    [self setIntegerValue:friend_count forkey:kSessionFriendCount];
}

#pragma mark get



-(NSString*)passWord
{
    return [self getValueForKey:kSessionPassWord];
}


-(NSString*)phone
{
    return [self getValueForKey:kSessionPhone];
}

-(NSString*)token
{
    
    return [self getValueForKey:kSessionToken];
}

-(NSString*)uid
{
    return [self getValueForKey:kSessionUid];
}

-(NSString*)nickname
{
    return [self getValueForKey:kSessionNickName];
}

-(NSString*)avatar
{
    return [self getValueForKey:kSessionAvatar];
}
-(NSString*)birthday
{
    return [self getValueForKey:kSessionBirthday];
}
-(NSString*)sex
{
    return [self getValueForKey:kSessionSex];
}

-(NSString*)regon
{
    return [self getValueForKey:kSessionRegon];
}

-(NSString*)latitude
{
    return [self getValueForKey:kSessionLatitude];
}

-(NSString*)longitude
{
    return [self getValueForKey:kSessionLongitude];
}

-(NSString*)countryCode
{
    return [self getValueForKey:kSessionCountryCode];
}

-(NSString*)city
{
    return [self getValueForKey:kSessionCity];
}


-(NSString*)channel
{
    return [self getValueForKey:kSessionChannel];
}



-(NSInteger)timeDifference
{
    return [self getIntegerValue:kSessionTimeDifference];
}

-(NSString*)rc_token
{
    return [self getValueForKey:kSessionRcToken];
}

-(NSInteger)dynamic_count
{
    return [self getIntegerValue:kSessionDynamicCount];
}

-(NSInteger)friend_count
{
    return [self getIntegerValue:kSessionFriendCount];
}

#pragma mark - islogin
- (BOOL)isLogin{
    
    if(IsStrEmpty(self.token)){
        
        return NO;
    }
    return YES;
}

#pragma mark -
- (void)setValue:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)getValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

-(void)setIntegerValue:(NSInteger)value forkey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger)getIntegerValue:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

-(void)setFloatValue:(float)value forkey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (float)getFloatValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] floatForKey:key];
}
-(void)setBoolValue:(BOOL)value forkey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)getBoolValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

- (void)removeObjectForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)removeUserInfo
{
    [self removeObjectForKey:kSessionPhone];
    [self removeObjectForKey:kSessionUid];
    [self removeObjectForKey:kSessionToken];
    [self removeObjectForKey:kSessionAvatar];
    [self removeObjectForKey:kSessionNickName];
    [self removeObjectForKey:kSessionSex];
    
    [[RCIM sharedRCIM] disconnect];
    
}

-(void)disconnectRc
{
    [[RCIM sharedRCIM] disconnect];
    
}

-(BOOL)bConnected
{
    RCConnectionStatus status = [[RCIMClient sharedRCIMClient] getConnectionStatus];
    return (ConnectionStatus_Connected == status);
}

@end
