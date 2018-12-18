//
//  WYHomePageViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHomePageViewController.h"
#import "WYDynamicViewController.h"
#import "WYPersonCenterController.h"
@interface WYHomePageViewController ()

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
    [self registerGesture];
}

-(void)setNavigationConfig
{
    [self setNavTitle:@"Explore"];
 
    [self.leftButton setImage:[UIImage imageNamed:@"navi_dynamic_btn"] forState:UIControlStateNormal];
  
    [self.rightButton yy_setImageWithURL:[NSURL URLWithString:@"http://mmbiz.qpic.cn/mmbiz/PwIlO51l7wuFyoFwAXfqPNETWCibjNACIt6ydN7vw8LeIwT7IjyG3eeribmK4rhibecvNKiaT2qeJRIWXLuKYPiaqtQ/0"] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    
    @weakify(self);
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        [self gotoDynamic];
    }];

    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        [self gotoPersonCenter];
    }];
    
}

-(void)registerGesture
{
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf gotoDynamic];
        } else if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
            [weakSelf gotoPersonCenter];
        }
    }];
}

//
- (void)gotoDynamic{
    
    // 强引用leftVC，不用每次创建新的,也可以每次在这里创建leftVC，抽屉收起的时候会释放掉
    [self cw_showDefaultDrawerViewController:[[WYDynamicViewController alloc]init]];
 
}

-(void)gotoPersonCenter
{
    WYPersonCenterController *vc = [[WYPersonCenterController alloc] init];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight; // 从右边滑出
    conf.finishPercent = 0.2f;
    conf.showAnimDuration = 0.2;
    conf.HiddenAnimDuration = 0.2;
    conf.distance = KScreenWidth;
    conf.maskAlpha = 0.1;
    [self cw_showDrawerViewController:nav animationType:CWDrawerAnimationTypeDefault configuration:conf];
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
