//
//  WYConversationAnimation.h
//  weyoung
//
//  Created by gongxin on 2019/1/28.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, WYLTransitionOneType) {
    WYLTransitionOneTypePush=0,
    WYLTransitionOneTypePop,
};
NS_ASSUME_NONNULL_BEGIN

@interface WYConversationAnimation : NSObject<UIViewControllerAnimatedTransitioning>

//动画转场类型
@property (nonatomic,assign) WYLTransitionOneType transitionType;

@end

NS_ASSUME_NONNULL_END
