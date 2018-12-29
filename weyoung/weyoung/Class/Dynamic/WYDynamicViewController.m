//
//  WYDynamicViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYDynamicViewController.h"

@implementation WYDynamicViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setNavTitle:@"动态"];
    [self setNaviGationConfig];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)setNaviGationConfig
{
    self.titleLabel.font = [UIFont fontWithName:TextFontName_Medium size:24];
    self.titleLabel.mj_x = 20;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.leftButton.hidden = YES;
    [self.rightButton setImage:[UIImage imageNamed:@"navi_back_btn_right"] forState:UIControlStateNormal];
 
   
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self gotoHomePage];
    }];
 
}

-(void)gotoHomePage
{
    NSLog(@"[gx] goto hp");
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:1];
    }
}


@end
