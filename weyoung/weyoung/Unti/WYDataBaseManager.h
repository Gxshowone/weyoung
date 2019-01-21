//
//  WYDataBaseManager.h
//  weyoung
//
//  Created by 巩鑫 on 2019/1/20.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>
#import "WYUserInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYDataBaseManager : NSObject

+ (WYDataBaseManager *)shareInstance;

- (void)closeDBForDisconnect;

//存储用户信息
- (void)insertUserToDB:(RCUserInfo *)user;

- (void)insertUserListToDB:(NSMutableArray *)userList complete:(void (^)(BOOL))result;

//插入黑名单列表
- (void)insertBlackListToDB:(RCUserInfo *)user;

- (void)insertBlackListUsersToDB:(NSMutableArray *)userList complete:(void (^)(BOOL))result;

//获取黑名单列表
- (NSArray *)getBlackList;

//移除黑名单
- (void)removeBlackList:(NSString *)userId;

//清空黑名单缓存信息
- (void)clearBlackListData;

//从表中获取用户信息
- (RCUserInfo *)getUserByUserId:(NSString *)userId;

//从表中获取所有用户信息
- (NSArray *)getAllUserInfo;


//存储好友信息
- (void)insertFriendToDB:(WYUserInfo *)friendInfo;

- (void)insertFriendListToDB:(NSMutableArray *)FriendList complete:(void (^)(BOOL))result;

//清空表中的所有的群组信息
- (BOOL)clearGroupfromDB;

//清空群组缓存数据
- (void)clearGroupsData;

//清空好友缓存数据
- (void)clearFriendsData;

//从表中获取所有好友信息 //RCUserInfo
- (NSArray *)getAllFriends;

//从表中获取某个好友的信息
- (WYUserInfo *)getFriendInfo:(NSString *)friendId;

//删除好友信息
- (void)deleteFriendFromDB:(NSString *)userId;
    
@end

NS_ASSUME_NONNULL_END
