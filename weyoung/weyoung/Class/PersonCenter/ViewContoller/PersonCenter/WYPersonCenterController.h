//
//  WYPersonCenterController.h
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYMainViewControllerDelegate.h"

@interface WYPersonCenterController : WYBaseViewController

@property(nonatomic,weak)id<WYMainViewControllerDelegate>delegate;

-(void)getUserInfo;

@end

