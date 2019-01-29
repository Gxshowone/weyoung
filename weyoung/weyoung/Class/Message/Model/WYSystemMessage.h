//
//  WYSystemMessage.h
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

/*!
 文本消息的类型名
 */
#define SystemMessageTypeIdentifier @"WYSYSTEMMESSAGE"


@interface WYSystemMessage : RCMessageContent

/*!
 文本消息的内容
 */
@property(nonatomic, strong) NSString *content;

+ (instancetype)messageWithContent:(NSString *)content;


@end

