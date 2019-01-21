//
//  WYUserInfo.h
//  weyoung
//
//  Created by 巩鑫 on 2019/1/20.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMLib/RCUserInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYUserInfo :  NSObject<NSCoding>

/*!
 用户ID
 */
@property(nonatomic, copy) NSString *userId;

/*!
 用户名称
 */
@property(nonatomic, copy) NSString *name;

/*!
 用户头像的URL
 */
@property(nonatomic, copy) NSString *portraitUri;

@property(nonatomic,copy)NSString * brithday;

@property(nonatomic, strong) NSString *status;

@property(nonatomic, strong) NSString *updatedAt;


@end

NS_ASSUME_NONNULL_END
