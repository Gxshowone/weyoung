//
//  WYFriendModel.h
//  weyoung
//
//  Created by 巩鑫 on 2019/1/14.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYFriendModel : NSObject

@property(nonatomic,copy)NSString * uid;
@property(nonatomic,copy)NSString * nick_name;
@property(nonatomic,copy)NSString * header_url;
@property(nonatomic,copy)NSString * gender;
@property(nonatomic,copy)NSString * birthday;


@end

NS_ASSUME_NONNULL_END
