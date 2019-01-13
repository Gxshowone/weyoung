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
#import "WYMessageListViewController.h"
#import "WYCommentController.h"
@interface WYMainViewController ()<UIScrollViewDelegate,WYMainViewControllerDelegate>
{
    WYDynamicViewController * dyVc;
    WYHomePageViewController * hpVc;
    WYPersonCenterController * perVc;
}

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
    
    dyVc = [[WYDynamicViewController alloc] init];
    dyVc.view.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    dyVc.delegate = self;
    
    hpVc = [[WYHomePageViewController alloc] init];
    hpVc.view.frame = CGRectMake(KScreenWidth, 0, KScreenWidth, KScreenHeight);
    hpVc.delegate = self;
    
    perVc = [[WYPersonCenterController alloc]init];
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

-(void)conversation:(WYUserModel*)model
{
    
    WYConversationViewController *conversationVC = [[WYConversationViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = @"100016";
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
     
}
-(void)message
{
    WYMessageListViewController * messageVc = [[WYMessageListViewController alloc]init];
    [self.navigationController pushViewController:messageVc animated:YES];
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

-(void)gotoComment:(WYDynamicModel*)model
{
    WYCommentController * commentVc = [[WYCommentController alloc]init];
    commentVc.model = model;
    [self.navigationController pushViewController:commentVc animated:YES];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.scrollView.frame = self.view.bounds;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat cx = scrollView.contentOffset.x;
    if (cx == KScreenWidth *2 ) {
        
        [perVc getUserInfo];
    }
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
