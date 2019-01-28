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
#define kInputBarHeight 49.5

@interface WYConversationViewController ()<WYConversationBarDelegate,WYApplyViewDelegate,WYMatchingFailureViewDelegate>

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
    
    WYUserInfo * user = [[WYUserInfo alloc]init];
    user.userId = self.user.userId;
    user.brithday = self.birthday;
    user.name = self.user.name;
    user.portraitUri = self.user.portraitUri;
    user.status = @"";
    user.updatedAt = @"";
    [[WYDataBaseManager shareInstance] insertFriendToDB:user];
    
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

@end
