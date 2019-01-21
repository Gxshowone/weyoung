//
//  WYDataBaseManager.m
//  weyoung
//
//  Created by 巩鑫 on 2019/1/20.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYDataBaseManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
@interface WYDataBaseManager ()

@property(nonatomic, strong) FMDatabaseQueue *dbQueue;

@end

@implementation WYDataBaseManager

static NSString *const userTableName = @"USERTABLE";
static NSString *const groupTableName = @"GROUPTABLEV2";
static NSString *const friendTableName = @"FRIENDSTABLE";
static NSString *const blackTableName = @"BLACKTABLE";
static NSString *const groupMemberTableName = @"GROUPMEMBERTABLE";

+ (WYDataBaseManager *)shareInstance {
    static WYDataBaseManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        [instance dbQueue];
    });
    return instance;
}

- (void)moveFile:(NSString *)fileName fromPath:(NSString *)fromPath toPath:(NSString *)toPath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:toPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
    }
    NSString *srcPath = [fromPath stringByAppendingPathComponent:fileName];
    NSString *dstPath = [toPath stringByAppendingPathComponent:fileName];
    [[NSFileManager defaultManager] moveItemAtPath:srcPath toPath:dstPath error:nil];
}

/**
 苹果审核时，要求打开itunes sharing功能的app在Document目录下不能放置用户处理不了的文件
 2.8.9之前的版本数据库保存在Document目录
 从2.8.9之前的版本升级的时候需要把数据库从Document目录移动到Library/Application Support目录
 */
- (void)moveDBFile {
    NSString *const rongIMDemoDBString = @"RongIMDemoDB";
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask,
                                                                 YES)[0] stringByAppendingPathComponent:@"RongCloud"];
    NSArray<NSString *> *subPaths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentPath error:nil];
    [subPaths enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj hasPrefix:rongIMDemoDBString]) {
            [self moveFile:obj fromPath:documentPath toPath:libraryPath];
        }
    }];
}

- (FMDatabaseQueue *)dbQueue {
    if ([RCIMClient sharedRCIMClient].currentUserInfo.userId == nil) {
        return nil;
    }
    
    if (!_dbQueue) {
        [self moveDBFile];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        NSString *const roungCloud = @"RongCloud";
        NSString *library = [[paths objectAtIndex:0] stringByAppendingPathComponent:roungCloud];
        NSString *dbPath = [library
                            stringByAppendingPathComponent:[NSString
                                                            stringWithFormat:@"RongIMDemoDB%@",
                                                            [RCIMClient sharedRCIMClient].currentUserInfo.userId]];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        if (_dbQueue) {
            [self createUserTableIfNeed];
        }
    }
    return _dbQueue;
}

//创建用户存储表
- (void)createUserTableIfNeed {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if (![self isTableOK:userTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE USERTABLE (id integer PRIMARY "
            @"KEY autoincrement, userid text,name text, "
            @"portraitUri text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL = @"CREATE unique INDEX idx_userid ON USERTABLE(userid);";
            [db executeUpdate:createIndexSQL];
        }
        
        if (![self isTableOK:groupTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE GROUPTABLEV2 (id integer PRIMARY KEY autoincrement, "
            @"groupId text,name text, portraitUri text,inNumber text,maxNumber "
            @"text ,introduce text ,creatorId text,creatorTime text, isJoin "
            @"text, isDismiss text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL = @"CREATE unique INDEX idx_groupid ON GROUPTABLEV2(groupId);";
            [db executeUpdate:createIndexSQL];
        }
        
        if (![self isTableOK:friendTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE FRIENDSTABLE (id integer "
            @"PRIMARY KEY autoincrement, userid "
            @"text,name text, portraitUri text, status "
            @"text, updatedAt text, brithday text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL = @"CREATE unique INDEX idx_friendsId ON FRIENDSTABLE(userid);";
            [db executeUpdate:createIndexSQL];
        } else if (![self isColumnExist:@"brithday" inTable:friendTableName withDB:db]) {
            [db executeUpdate:@"ALTER TABLE FRIENDSTABLE ADD COLUMN brithday text"];
        }
        
        if (![self isTableOK:blackTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE BLACKTABLE (id integer PRIMARY "
            @"KEY autoincrement, userid text,name text, "
            @"portraitUri text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL = @"CREATE unique INDEX idx_blackId ON BLACKTABLE(userid);";
            [db executeUpdate:createIndexSQL];
        }
        
        if (![self isTableOK:groupMemberTableName withDB:db]) {
            NSString *createTableSQL = @"CREATE TABLE GROUPMEMBERTABLE (id integer "
            @"PRIMARY KEY autoincrement, groupid text, "
            @"userid text,name text, portraitUri text)";
            [db executeUpdate:createTableSQL];
            NSString *createIndexSQL = @"CREATE unique INDEX idx_groupmemberId ON "
            @"GROUPMEMBERTABLE(groupid,userid);";
            [db executeUpdate:createIndexSQL];
        }
    }];
}

- (void)closeDBForDisconnect {
    self.dbQueue = nil;
}

//存储用户信息
- (void)insertUserToDB:(RCUserInfo *)user {
    NSString *insertSql = @"REPLACE INTO USERTABLE (userid, name, portraitUri) VALUES (?, ?, ?)";
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql, user.userId, user.name, user.portraitUri];
    }];
}

//存储用户列表信息
- (void)insertUserListToDB:(NSMutableArray *)userList complete:(void (^)(BOOL))result {
    
    if (userList == nil || [userList count] < 1)
        return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for (RCUserInfo *user in userList) {
                NSString *insertSql = @"REPLACE INTO USERTABLE (userid, name, portraitUri) VALUES (?, ?, ?)";
                if (user.portraitUri.length <= 0) {
                     user.portraitUri =@"";
                }
                [db executeUpdate:insertSql, user.userId, user.name, user.portraitUri];
            }
        }];
        result(YES);
    });
}

//插入黑名单列表
- (void)insertBlackListToDB:(RCUserInfo *)user {
    NSString *insertSql = @"REPLACE INTO BLACKTABLE (userid, name, portraitUri) VALUES (?, ?, ?)";
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql, user.userId, user.name, user.portraitUri];
    }];
}

- (void)insertBlackListUsersToDB:(NSMutableArray *)userList complete:(void (^)(BOOL))result {
    
    if (userList == nil || [userList count] < 1)
        return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for (RCUserInfo *user in userList) {
                NSString *insertSql = @"REPLACE INTO BLACKTABLE (userid, name, portraitUri) VALUES (?, ?, ?)";
                [db executeUpdate:insertSql, user.userId, user.name, user.portraitUri];
            }
        }];
        result(YES);
    });
}

//获取黑名单列表
- (NSArray *)getBlackList {
    NSMutableArray *allBlackList = [NSMutableArray new];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM BLACKTABLE"];
        while ([rs next]) {
            RCUserInfo *model;
            model = [[RCUserInfo alloc] init];
            model.userId = [rs stringForColumn:@"userid"];
            model.name = [rs stringForColumn:@"name"];
            model.portraitUri = [rs stringForColumn:@"portraitUri"];
            [allBlackList addObject:model];
        }
        [rs close];
    }];
    return allBlackList;
}

//移除黑名单
- (void)removeBlackList:(NSString *)userId {
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM BLACKTABLE WHERE userid=%@", userId];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

//清空黑名单缓存数据
- (void)clearBlackListData {
    NSString *deleteSql = @"DELETE FROM BLACKTABLE";
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

//从表中获取用户信息
- (RCUserInfo *)getUserByUserId:(NSString *)userId {
    __block RCUserInfo *model = nil;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM USERTABLE where userid = ?", userId];
        while ([rs next]) {
            model = [[RCUserInfo alloc] init];
            model.userId = [rs stringForColumn:@"userid"];
            model.name = [rs stringForColumn:@"name"];
            model.portraitUri = [rs stringForColumn:@"portraitUri"];
        }
        [rs close];
    }];
    return model;
}

//从表中获取所有用户信息
- (NSArray *)getAllUserInfo {
    NSMutableArray *allUsers = [NSMutableArray new];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM USERTABLE"];
        while ([rs next]) {
            RCUserInfo *model;
            model = [[RCUserInfo alloc] init];
            model.userId = [rs stringForColumn:@"userid"];
            model.name = [rs stringForColumn:@"name"];
            model.portraitUri = [rs stringForColumn:@"portraitUri"];
            [allUsers addObject:model];
        }
        [rs close];
    }];
    return allUsers;
}


//存储好友信息
- (void)insertFriendToDB:(WYUserInfo *)friendInfo{
    NSString *insertSql = @"REPLACE INTO FRIENDSTABLE (userid, name, "
    @"portraitUri, status, updatedAt, brithday) VALUES (?, ?, ?, ?, "
    @"?, ?)";
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql, friendInfo.userId, friendInfo.name, friendInfo.portraitUri, friendInfo.status,
         friendInfo.updatedAt, friendInfo.brithday];
    }];
}

- (void)insertFriendListToDB:(NSMutableArray *)FriendList complete:(void (^)(BOOL))result {
    
    if (FriendList == nil || [FriendList count] < 1)
        return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for (WYUserInfo  *friendInfo  in FriendList) {
                NSString *insertSql = @"REPLACE INTO FRIENDSTABLE (userid, name, "
                @"portraitUri, status, updatedAt, brithday) VALUES (?, ?, ?, ?, "
                @"?, ?)";
                [db executeUpdate:insertSql, friendInfo.userId, friendInfo.name, friendInfo.portraitUri,
                 friendInfo.status, friendInfo.updatedAt, friendInfo.brithday];
            }
        }];
        result(YES);
    });
}

//从表中获取所有好友信息 //RCUserInfo
- (NSArray *)getAllFriends {
    NSMutableArray *allUsers = [NSMutableArray new];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM FRIENDSTABLE"];
        while ([rs next]) {
            //            RCUserInfo *model;
            WYUserInfo  *model;
            model = [[WYUserInfo  alloc] init];
            model.userId = [rs stringForColumn:@"userid"];
            model.name = [rs stringForColumn:@"name"];
            model.portraitUri = [rs stringForColumn:@"portraitUri"];
            model.status = [rs stringForColumn:@"status"];
            model.updatedAt = [rs stringForColumn:@"updatedAt"];
            model.brithday = [rs stringForColumn:@"brithday"];
            [allUsers addObject:model];
        }
        [rs close];
    }];
    return allUsers;
}

//从表中获取某个好友的信息
- (WYUserInfo  *)getFriendInfo:(NSString *)friendId {
    __block WYUserInfo  *friendInfo;
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM FRIENDSTABLE WHERE userid=?", friendId];
        while ([rs next]) {
            friendInfo = [WYUserInfo  new];
            friendInfo.userId = [rs stringForColumn:@"userid"];
            friendInfo.name = [rs stringForColumn:@"name"];
            friendInfo.portraitUri = [rs stringForColumn:@"portraitUri"];
            friendInfo.status = [rs stringForColumn:@"status"];
            friendInfo.updatedAt = [rs stringForColumn:@"updatedAt"];
            friendInfo.brithday = [rs stringForColumn:@"brithday"];
        }
        [rs close];
    }];
    return friendInfo;
}

//清空群组缓存数据
- (void)clearGroupsData {
    NSString *deleteSql = @"DELETE FROM GROUPTABLEV2";
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

//清空好友缓存数据
- (void)clearFriendsData {
    NSString *deleteSql = @"DELETE FROM FRIENDSTABLE";
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

- (void)deleteFriendFromDB:(NSString *)userId {
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM FRIENDSTABLE WHERE userid=%@", userId];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:deleteSql];
    }];
}

- (BOOL)isTableOK:(NSString *)tableName withDB:(FMDatabase *)db {
    BOOL isOK = NO;
    
    FMResultSet *rs = [db executeQuery:@"select count(*) as 'count' from sqlite_master where "
                       @"type ='table' and name = ?",
                       tableName];
    while ([rs next]) {
        NSInteger count = [rs intForColumn:@"count"];
        
        if (0 == count) {
            isOK = NO;
        } else {
            isOK = YES;
        }
    }
    [rs close];
    
    return isOK;
}

- (BOOL)isColumnExist:(NSString *)columnName inTable:(NSString *)tableName withDB:(FMDatabase *)db {
    BOOL isExist = NO;
    
    NSString *columnQurerySql = [NSString stringWithFormat:@"SELECT %@ from %@", columnName, tableName];
    FMResultSet *rs = [db executeQuery:columnQurerySql];
    if ([rs next]) {
        isExist = YES;
    } else {
        isExist = NO;
    }
    [rs close];
    
    return isExist;
}

@end
