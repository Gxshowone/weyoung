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



static WYSession *sharedManager=nil;
@implementation WYSession
+ (WYSession *)sharedSession{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WYSession alloc] init];
        
    });
    
    return sharedManager;
}


-(void)loginUser:(NSDictionary*)dict
{

    self.token = [dict valueForKey:@"token"];
    self.rc_token = [dict valueForKey:@"rc_token"];
    self.uid  =  [dict valueForKey:@"uid"];
    self.nickname = [dict valueForKey:@"nick_name"];
    self.birthday  = [dict valueForKey:@"birthday"];
    self.avatar  = [dict valueForKey:@"header_url"];
    self.rc_token = [dict valueForKey:@"rc_token"];
    self.timeDifference = [[dict valueForKey:@"lastlogin_time"] integerValue];
    
    [self connectRcWithToken:self.rc_token];
    
    [self updateRootController];
}


-(void)connectRcWithToken:(NSString*)rctoken
{
    [[RCIM sharedRCIM] connectWithToken:rctoken  success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
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


@end
