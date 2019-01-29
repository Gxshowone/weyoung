

//
//  WYSystemViewController.m
//  weyoung
//
//  Created by gongxin on 2019/1/29.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYSystemViewController.h"
#import "WYSystemBar.h"
#import <IQKeyboardManager.h>
@interface WYSystemViewController ()

@property(nonatomic,strong)WYSystemBar * systemBar;
@end

@implementation WYSystemViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [self refreshTitle];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:WYUnreadMessageUpdate object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
}

- (void)refreshTitle {
    if (self.userName == nil) {
        return;
    }
    
    self.title = self.userName;
    [self.systemBar updateTitle:self.userName];
}


-(void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.conversationMessageCollectionView.backgroundColor = [UIColor blackColor];
    self.chatSessionInputBarControl.hidden = YES;
    [self.view addSubview:self.systemBar];
    
}

-(WYSystemBar*)systemBar
{
    if (!_systemBar) {
        _systemBar = [[WYSystemBar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KNaviBarHeight)];
        @weakify(self);
        [[_systemBar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }
    return _systemBar;
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
