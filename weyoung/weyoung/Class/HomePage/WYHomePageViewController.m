//
//  WYHomePageViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHomePageViewController.h"
#import "WYPersonCenterController.h"
@interface WYHomePageViewController ()

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
}

-(void)setNavigationConfig
{
 
    [self.leftButton setImage:[UIImage imageNamed:@"navi_dynamic_btn"] forState:UIControlStateNormal];
    
    [self.rightButton setImage:[UIImage imageNamed:@"navi_dynamic_btn"] forState:UIControlStateNormal];
    
    @weakify(self);
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        
        [self.navigationController pushViewController:[[WYPersonCenterController alloc]init] animated:YES];
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
