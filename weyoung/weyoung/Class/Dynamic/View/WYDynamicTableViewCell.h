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

@interface WYDynamicTableViewCell : UITableViewCell

@property(nonatomic,strong)WYDynamicModel * model;
@property(nonatomic,strong)UIButton *likeBtn;
@property(nonatomic,strong)UIButton *moreBtn;

@end

NS_ASSUME_NONNULL_END
