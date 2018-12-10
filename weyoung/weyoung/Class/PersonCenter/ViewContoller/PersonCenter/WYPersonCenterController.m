//
//  WYPersonCenterController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPersonCenterController.h"

#import "WYSettingViewController.h"
@implementation WYPersonCenterController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
}

-(void)setNavigationConfig
{
    

    [self.rightButton setImage:[UIImage imageNamed:@"navi_setting_btn"] forState:UIControlStateNormal];
    
    @weakify(self);
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        
        [self.navigationController pushViewController:[[WYSettingViewController alloc]init] animated:YES];
        
    }];
}

@end
