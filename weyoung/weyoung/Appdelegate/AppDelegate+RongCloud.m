//
//  AppDelegate+RongCloud.m
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "AppDelegate+RongCloud.h"
#import "WYSystemMessage.h"
#import "WYDataBaseManager.h"
@implementation AppDelegate (RongCloud)

-(void)registerRongCloud:(NSDictionary  *)launchOptions
{
    [[RCIM sharedRCIM] initWithAppKey:@"sfci50a7s3f7i"];
    [[RCIM sharedRCIM] setGlobalNavigationBarTintColor:[UIColor binaryColor:@"000000"]];
    [[RCIMClient sharedRCIMClient] recordLaunchOptionsEvent:launchOptions];
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    [RCIM sharedRCIM].receiveMessageDelegate = self;
    [[RCIM sharedRCIM] registerMessageType:[RCTextMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[RCImageMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[RCVoiceMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[WYSystemMessage class]];
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    [RCIM sharedRCIM].globalMessageAvatarStyle = RC_USER_AVATAR_CYCLE;
    [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE;
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
    [[WYSession sharedSession] connectRc];
}


/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left;
{
    BOOL isConvMsg = NO;
    
    if ([message.content isMemberOfClass:[RCTextMessage class]]) {
        RCTextMessage *testMessage = (RCTextMessage *)message.content;
        NSLog(@"消息内容：%@", testMessage.content);
 
    }else if([message.targetId isEqualToString:@"000000"])
    {
       
        [[NSNotificationCenter defaultCenter] postNotificationName:WYSYSTEMMESSAGEUPDATE object:message];
        
    }

    NSString *objectName = message.objectName;
   
    [[NSNotificationCenter defaultCenter]postNotificationName:WYUnreadMessageUpdate object:nil];
   
}

-(BOOL)isValiedRCMessage:(RCMessage *)message
{
    if (message && [message isKindOfClass:[RCMessage class]]) {
        
        if ([message.content isMemberOfClass:[RCTextMessage class]]
            || [message.content isMemberOfClass:[RCVoiceMessage class]]
            || [message.content isMemberOfClass:[RCRichContentMessage class]]
            || [message.content isMemberOfClass:[RCRecallNotificationMessage class]]
            || [message.content isMemberOfClass:[RCLocationMessage class]]
            || [message.content isMemberOfClass:[RCImageMessage class]]
            || [message.content isMemberOfClass:[RCVoiceMessage class]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion {
    NSLog(@"getUserInfoWithUserId ----- %@", userId);
    RCUserInfo *user = [RCUserInfo new];
    if (userId == nil || [userId length] == 0) {
        user.userId = userId;
        user.portraitUri = @"";
        user.name = @"";
        completion(user);
        return;
    }
  
    RCUserInfo * userCache = [[WYDataBaseManager shareInstance] getUserByUserId:userId];
    completion(userCache);
    
    return;
}

@end
