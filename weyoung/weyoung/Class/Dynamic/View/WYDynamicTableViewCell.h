//
//  WYDynamicTableViewCell.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYDynamicModel.h"
NS_ASSUME_NONNULL_BEGIN


@protocol WYDynamicTableViewCellDelegate <NSObject>

-(void)moreDynamic:(WYDynamicModel*)model;
-(void)likeDynamic:(WYDynamicModel*)model;
-(void)gotoOtherCenter:(WYDynamicModel*)model;

@end

@interface WYDynamicTableViewCell : UITableViewCell

@property (nonatomic,weak) id<WYDynamicTableViewCellDelegate> delegate;

@property(nonatomic,strong)WYDynamicModel * model;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
