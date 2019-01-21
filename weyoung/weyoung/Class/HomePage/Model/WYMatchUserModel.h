//
//  WYMatchUserModel.h
//  weyoung
//
//  Created by 巩鑫 on 2019/1/20.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYMatchUserModel : NSObject

@property(nonatomic,copy)NSString * birthday;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * header_url;
@property(nonatomic,copy)NSString * lastlogin_ip;
@property(nonatomic,copy)NSString * lastlogin_time;
@property(nonatomic,copy)NSString * nick_name;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * register_status;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * zone_num;

@end

NS_ASSUME_NONNULL_END
