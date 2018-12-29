//
//  WYConversationBar.h
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYConversationBar : UIView

@property(nonatomic,strong)UIButton * backButton;

-(void)updateTitle:(NSString*)title;
-(void)startTimer;
-(void)stopTimer;

@end

NS_ASSUME_NONNULL_END
