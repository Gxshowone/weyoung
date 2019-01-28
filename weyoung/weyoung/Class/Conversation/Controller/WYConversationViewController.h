//
//  WYConversationViewController.h
//  weyoung
//
//  Created by gongxin on 2018/12/21.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface WYConversationViewController : RCConversationViewController<UINavigationControllerDelegate>

@property(nonatomic,strong)NSString * birthday;
@property(nonatomic,strong)RCUserInfo * user;
@property(nonatomic,assign)BOOL isFriend;

@end

NS_ASSUME_NONNULL_END
