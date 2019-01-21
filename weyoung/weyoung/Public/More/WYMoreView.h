//
//  WYMoreView.h
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYElasticView.h"

typedef NS_ENUM(NSUInteger, WYMoreViewType) {
    
    WYMoreViewType_Dynamic         = 0, //
    WYMoreViewType_Conversation      = 1, //
    
};

NS_ASSUME_NONNULL_BEGIN

@interface WYMoreView : WYElasticView

@property(nonatomic,strong)RCUserInfo * user;

@property(nonatomic,assign)BOOL isFriend;

@property(nonatomic,assign)WYMoreViewType type;



@end

NS_ASSUME_NONNULL_END
