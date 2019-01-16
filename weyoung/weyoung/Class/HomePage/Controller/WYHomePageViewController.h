//
//  WYHomePageViewController.h
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYBaseViewController.h"
#import "WYMainViewControllerDelegate.h"

@interface WYHomePageViewController : WYBaseViewController

@property(nonatomic,weak)id<WYMainViewControllerDelegate>delegate;

-(void)childWalk;


@end
