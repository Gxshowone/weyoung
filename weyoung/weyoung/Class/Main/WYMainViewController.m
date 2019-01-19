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

#import "WYSignView.h"
#import "WYExcessiveView.h"
@interface WYMainViewController ()<UIScrollViewDelegate,WYMainViewControllerDelegate,WYSignViewDelegate>
{
    WYDynamicViewController * dyVc;
    WYHomePageViewController * hpVc;
    WYPersonCenterController * perVc;
}

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)WYSignView * signView;
@property(nonatomic,strong)WYExcessiveView * excessView;

@end

@implementation WYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [hpVc childWait];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.signView.frame = self.view.bounds;
    self.excessView.frame = self.view.bounds;
    self.scrollView.frame = self.view.bounds;
}

-(void)initUI
{
    
    [self.view addSubview:self.scrollView];
    [self addChildControllers];
    
    //判断是白天还是黑夜
//    if ([self isNight]) {
 //   [self.view addSubview:self.signView];
//    }else
//    {
//        [self.view addSubview:self.excessView];
//    }
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

-(void)signHide
{
    [hpVc childWalk];
}

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


- (NSDate *)getCustomDateWithHour:(NSInteger)hour

{
    //获取当前时间
    NSDate * destinationDateNow = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    currentComps = [currentCalendar components:unitFlags fromDate:destinationDateNow];
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
      return [resultCalendar dateFromComponents:resultComps];
    
}

-(BOOL)isNight
{
    NSDate * currentDate = [NSDate date];
    if ([currentDate compare:[self getCustomDateWithHour:2]] == NSOrderedDescending && [currentDate compare:[self getCustomDateWithHour:20]] == NSOrderedAscending)
        
    {
        return NO;
    }
    return YES;
    
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

-(WYSignView*)signView
{
    if (!_signView) {
        _signView = [[WYSignView alloc]init];
        _signView.delegate = self;
    }
    return _signView;
}

-(WYExcessiveView*)excessView
{
    if (!_excessView) {
        _excessView = [[WYExcessiveView alloc]init];
    }
    return _excessView;
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
