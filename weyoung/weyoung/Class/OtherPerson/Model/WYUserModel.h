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
@property(nonatomic,copy)NSString * nickname;
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * birthday;

@end

NS_ASSUME_NONNULL_END
