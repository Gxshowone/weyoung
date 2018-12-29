//
//  WYDynamicViewController.h
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYBaseViewController.h"
#import "WYMainViewControllerDelegate.h"

@interface WYDynamicViewController : WYBaseViewController

@property(nonatomic,weak)id<WYMainViewControllerDelegate>delegate;


@end

