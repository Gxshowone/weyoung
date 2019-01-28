//
//  WYCommentController.h
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYBaseViewController.h"
#import "WYDynamicModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYCommentController : WYBaseViewController

@property (nonatomic ,strong) WYDynamicModel * model;

@property (nonatomic,strong)NSString * d_id;

@end

NS_ASSUME_NONNULL_END
