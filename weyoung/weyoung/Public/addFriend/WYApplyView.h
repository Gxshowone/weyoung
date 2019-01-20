//
//  WYApplyView.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYApplyViewDelegate;


@interface WYApplyView : UIView


@property (nonatomic,weak) id<WYApplyViewDelegate> delegate;

@property(nonatomic,strong)RCUserInfo * userInfo;

- (void)show;

@end

@protocol WYApplyViewDelegate <NSObject>



-(void)addFriendSussces;

-(void)addFriendFail;

@end

NS_ASSUME_NONNULL_END
