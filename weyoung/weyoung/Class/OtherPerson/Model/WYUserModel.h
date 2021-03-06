//
//  WYUserModel.h
//  weyoung
//
//  Created by gongxin on 2019/1/28.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYUserModel : NSObject


@property(nonatomic, assign)NSInteger dynamic_count;
@property(nonatomic, assign)NSInteger friend_count;
@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * birthday;
@property(nonatomic,copy)NSString * header_url;
@property(nonatomic,copy)NSString * nick_name;
@end

NS_ASSUME_NONNULL_END
