//
//  WYMainViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/26.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYMainViewController.h"
#import "WYDynamicViewController.h"
#import "WYHomePageViewController.h"
#import "WYPersonCenterController.h"
#import "WYConversationViewController.h"
#import "WYSettingViewController.h"
#import "WYEditViewController.h"
#import "WYFriendViewController.h"


@interface WYMainViewController ()<UIScrollViewDelegate,WYMainViewControllerDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;

@end

@implementation WYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initUI];
}


-(void)initUI
{
    
    [self.view addSubview:self.scrollView];
    [self addChildControllers];
}

-(void)addChildControllers
{
    
    WYDynamicViewController * dyVc = [[WYDynamicViewController alloc] init];
    dyVc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    dyVc.delegate = self;
    
    WYHomePageViewController * hpVc = [[WYHomePageViewController alloc] init];
    hpVc.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight);
    hpVc.delegate = self;
    
    WYPersonCenterController * perVc = [[WYPersonCenterController alloc]init];
    perVc.view.frame = CGRectMake(KScreenWidth*2, 0, KScreenWidth, KScreenHeight);
    perVc.delegate = self;
    [self.scrollView addSubview:dyVc.view];
    [self.scrollView addSubview:hpVc.view];
    [self.scrollView addSubview:perVc.view];
    [self.scrollView setContentOffset:CGPointMake(KScreenWidth, 0)];

    
    
}

#pragma mark delelgate

-(void)scrollToIndex:(NSInteger)index
{
 
    CGFloat x = index * KScreenWidth;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

-(void)conversation
{
    WYConversationViewController *conversationVC = [[WYConversationViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = @"2";
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
     
}
-(void)message
{
    
}

-(void)setting
{
    WYSettingViewController * settingVc = [[WYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
-(void)edit
{
    WYEditViewController * editVc = [[WYEditViewController alloc] init];
    [self.navigationController pushViewController:editVc animated:YES];
}

-(void)friendList
{
    WYFriendViewController * friendVc = [[WYFriendViewController alloc] init];
    [self.navigationController pushViewController:friendVc animated:YES];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
}


-(UIScrollView*)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled=  YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentSize = CGSizeMake(KScreenWidth*3,KScreenHeight-KNaviBarHeight-KTabBarHeight);
    }
    return _scrollView;
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
