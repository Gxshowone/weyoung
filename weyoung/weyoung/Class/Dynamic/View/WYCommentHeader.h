//
//  WYCommentHeader.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYDynamicModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WYCommentHeaderDelegate <NSObject>

-(void)moreDynamic:(WYDynamicModel*)model;
-(void)likeDynamic:(WYDynamicModel*)model;


@end
@interface WYCommentHeader : UIView

@property (nonatomic,weak) id<WYCommentHeaderDelegate> delegate;
@property(nonatomic,strong)WYDynamicModel * model;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *moreBtn;


@end

NS_ASSUME_NONNULL_END
