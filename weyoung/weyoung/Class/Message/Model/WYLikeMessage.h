//
//  WYLikeMessage.h
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYLikeMessage : NSObject

@property(nonatomic,copy)NSString * c_id;
@property(nonatomic,copy)NSString * create_time;
@property(nonatomic,copy)NSString * d_id;
@property(nonatomic,copy)NSString * header_url;
@property(nonatomic,copy)NSString * nick_name;
@property(nonatomic,copy)NSString * uid;

@end

NS_ASSUME_NONNULL_END
