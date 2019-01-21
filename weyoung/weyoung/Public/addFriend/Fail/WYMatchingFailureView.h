//
//  WYMatchingFailureView.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYMatchingFailureViewDelegate <NSObject>

-(void)endChat;

@end

@interface WYMatchingFailureView : UIView

@property (nonatomic,weak) id<WYMatchingFailureViewDelegate> delegate;

- (void)show;

@end

NS_ASSUME_NONNULL_END
