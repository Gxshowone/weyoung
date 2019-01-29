//
//  WYConversationViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/21.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYConversationViewController.h"
#import "WYConversationBar.h"
#import <IQKeyboardManager.h>
#import "WYApplyView.h"
#import "WYDataBaseManager.h"

#import "WYMatchingSusscesView.h"
#import "WYMatchingFailureView.h"
#import "WYConversationAnimation.h"
#define kInputBarHeight 49.5

@interface WYConversationViewController ()<WYConversationBarDelegate,WYApplyViewDelegate,WYMatchingFailureViewDelegate,UIViewControllerTransitioningDelegate>

//手势过渡转场
@property (nonatomic, strong) WYConversationAnimation * transition;
@property(nonatomic,strong)WYConversationBar * navigationBar;
@property(nonatomic,strong)WYApplyView * applyView;
@property(nonatomic,strong)WYMatchingSusscesView* susscesView;
@property(nonatomic,strong)WYMatchingFailureView* failView;

@end

@implementation WYConversationViewController

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
   [self.navigationBar updateTitle:self.userName];
}


-(void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.conversationMessageCollectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.navigationBar];
    
}

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell

                   atIndexPath:(NSIndexPath *)indexPath

{

    
//    if ([cell isMemberOfClass:[RCTextMessageCell class]]) {
//        
//        RCTextMessageCell *textCell=(RCTextMessageCell *)cell;
//        
//        //      自定义气泡图片的适配
//        
//        UIImage *image=textCell.bubbleBackgroundView.image;
//        
//        textCell.bubbleBackgroundView.image=[textCell.bubbleBackgroundView.image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.8,image.size.height * 0.2, image.size.width * 0.2)];
//        
//        //      更改字体的颜色
//        
//        textCell.textLabel.textColor=[UIColor whiteColor];
//        
//    }
    
}

-(void)addFriendSussces
{
    [self.susscesView show];

    NSMutableArray * array = [NSMutableArray array];
    [array addObjectsFromArray:[WYSession sharedSession].friendArray];
    if ([array containsObject:self.user.userId]==NO) {
        [array addObject:self.user.userId];
    }
    [WYSession sharedSession].friendArray = array;
 
}

-(void)addFriendFail
{
    [self.failView show];
}

-(void)endChat
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)stopConversation
{
    RCUserInfo * user = [[WYDataBaseManager shareInstance] getUserByUserId:self.targetId];
    self.applyView.userInfo = user;
    [self.applyView show];
}

-(WYConversationBar*)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[WYConversationBar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KNaviBarHeight)];
        _navigationBar.delegate = self;
         @weakify(self);
        [[_navigationBar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }
    return _navigationBar;
}

-(WYApplyView*)applyView
{
    if (!_applyView) {
        _applyView = [[WYApplyView alloc]init];
        _applyView.delegate = self;
    }
    return _applyView;
}

-(WYMatchingSusscesView*)susscesView
{
    if (!_susscesView) {
        _susscesView = [[WYMatchingSusscesView alloc]init];
        
    }
    return _susscesView;
}

-(WYMatchingFailureView*)failView
{
    if (!_failView) {
        _failView = [[WYMatchingFailureView alloc]init];
        _failView.delegate = self;
    }
    return _failView;
}

-(void)setIsFriend:(BOOL)isFriend
{
    _isFriend = isFriend;
    self.navigationBar.isFriend = isFriend;
}


-(void)setUser:(RCUserInfo *)user
{
    _user = user;
    [self.navigationBar setMoreUser:user];
}

#pragma mark -- UINavigationControllerDelegate

//返回处理push/pop动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        self.transition.transitionType = WYLTransitionOneTypePush;
        return self.transition;
    }else if (operation == UINavigationControllerOperationPop){
        self.transition.transitionType = WYLTransitionOneTypePop;
    }
    return self.transition;
}

//返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    return nil;
}

- (WYConversationAnimation *)transition{
    
    if (_transition == nil) {
        _transition = [[WYConversationAnimation alloc] init];
        self.transitioningDelegate = self;
    }
    return _transition;
}


- (void)viewDidDisappear:(BOOL)animated{
    self.navigationController.delegate = nil;
}

@end
