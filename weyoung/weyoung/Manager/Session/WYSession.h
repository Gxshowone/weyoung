//
//  WYSession.h
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYSession : NSObject


+ (WYSession *)sharedSession;

/**
 登陆成功时的服务器时间 */
@property (nonatomic,assign) int64_t loginServerTime;

/** 客户端确认的位置信息 例: china */
@property (nonatomic, copy) NSString *regon;

/** 当前纬度，注意 NaN 表示没有获取到*/
@property (nonatomic, copy) NSString * latitude;
/** 当前经度，注意 NaN 表示没有获取到*/
@property (nonatomic,copy) NSString * longitude;

/** 国家编码 */
@property (nonatomic,copy) NSString * countryCode;
/** 前城市名称*/
@property (nonatomic,copy) NSString* city;

/** 渠道号 */
@property(nonatomic,copy)NSString * channel;

/** 当前时间与本地时间的时间差 */
@property(nonatomic, assign)NSInteger timeDifference;

@property(nonatomic, assign)NSInteger dynamic_count;
@property(nonatomic, assign)NSInteger friend_count;

//用户密码
@property(nonatomic,copy)NSString * passWord;

//用户手机号
@property(nonatomic,copy)NSString * phone;

//用户token
@property(nonatomic,copy)NSString * token;

//用户id
@property(nonatomic,copy)NSString * uid;

//用户昵称
@property(nonatomic,copy)NSString * nickname;

//用户头像
@property(nonatomic,copy)NSString * avatar;

//用户昵称
@property(nonatomic,copy)NSString * sex;

//用户生日
@property(nonatomic,copy)NSString * birthday;

//容云token
@property(nonatomic,copy)NSString * rc_token;

-(void)loginUser:(NSDictionary*)dict
           phone:(NSString*)phone;

-(void)updateUser:(NSDictionary*)dict;

-(void)connectRc;

-(void)removeUserInfo;
-(void)disconnectRc;
-(BOOL)isLogin;




@end

NS_ASSUME_NONNULL_END
