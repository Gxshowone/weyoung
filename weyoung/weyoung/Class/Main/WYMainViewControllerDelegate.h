//
//  WYMainViewControllerDelegate.h
//  weyoung
//
//  Created by gongxin on 2018/12/26.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYMainViewControllerDelegate <NSObject>

-(void)scrollToIndex:(NSInteger)index;

-(void)conversation; //进入会话页面

-(void)message; //进入消息列表页面

-(void)setting; //设置页面

-(void)edit;//个人资料编辑页面

-(void)friendList;//朋友列表

@end

NS_ASSUME_NONNULL_END