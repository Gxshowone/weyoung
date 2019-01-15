//
//  WYSignView.h
//  weyoung
//
//  Created by gongxin on 2019/1/15.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol WYSignViewDelegate <NSObject>

-(void)signHide;


@end
@interface WYSignView : UIView

@property (nonatomic,weak) id<WYSignViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
