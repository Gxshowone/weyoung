//
//  WYCommentCell.h
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class WYCommentModel;
@class WYCommentCell;

typedef void(^TapCommentBlock)(WYCommentCell *cell,WYCommentModel *model);

@interface WYCommentCell : UITableViewCell

@property(nonatomic,strong)WYCommentModel * model;

///点击某个人名字的block回调
@property(nonatomic ,copy)TapCommentBlock tapCommentBlock;

@end

NS_ASSUME_NONNULL_END
