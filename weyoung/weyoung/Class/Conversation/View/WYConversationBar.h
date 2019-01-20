//
//  WYConversationBar.h
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYConversationBarDelegate <NSObject>

-(void)stopConversation; //时间到了停止会话；

@end
@interface WYConversationBar : UIView

@property (nonatomic,weak) id<WYConversationBarDelegate> delegate;

@property(nonatomic,strong)UIButton * backButton;
@property(nonatomic,assign)BOOL isFriend;

-(void)updateTitle:(NSString*)title;
-(void)startTimer;
-(void)stopTimer;
-(void)setMoreUser:(RCUserInfo*)user;

@end

NS_ASSUME_NONNULL_END
