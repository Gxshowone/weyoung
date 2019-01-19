//
//  WYCommentToolBar.h
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol WYCommentToolBarDelegate <NSObject>

-(void)sendCommon:(NSString*)text;


@end
@interface WYCommentToolBar : UIView

@property (nonatomic,weak) id<WYCommentToolBarDelegate> delegate;

-(void)beginEdit;

-(void)stopEdit;

@end

NS_ASSUME_NONNULL_END
