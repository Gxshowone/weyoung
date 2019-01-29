//
//  WYMessageListViewController.m
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYMessageListViewController.h"
#import "WYMessageNaviBar.h"
#import "WYConversationViewController.h"
#import "WYMessageHeaderView.h"
#import "WYChatListTableViewCell.h"

#import "WYCommentViewController.h"
#import "WYLikeViewController.h"

#import "WYDataBaseManager.h"
#import "WYSystemViewController.h"
@interface WYMessageListViewController ()<UITableViewDelegate,UITableViewDataSource,WYMessageHeaderViewDelegate>

@property(nonatomic,strong)WYMessageHeaderView * headerView;
@property(nonatomic,strong)WYMessageNaviBar * navBar;
@property(nonatomic, assign) BOOL isClick;

@end

@implementation WYMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.navBar];
    
    [self setConversationType];
    [self customUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isClick = YES;
  
}

-(void)customUI
{
    self.conversationListTableView.backgroundColor = [UIColor clearColor];
    self.conversationListTableView.tableHeaderView = self.headerView;
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.emptyConversationView.alpha = 0.0;
}

-(void)setConversationType
{
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
 
}

-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    
    WYUserInfo * friend = [[WYDataBaseManager shareInstance] getFriendInfo:model.targetId];
    if (IsStrEmpty(friend.userId)) {
        [self.conversationListTableView makeToast:@"您们还不是好友"];
        return;
    }
    
    
    RCUserInfo  * userinfo = [[WYDataBaseManager shareInstance] getUserByUserId:model.targetId];
    WYConversationViewController *_conversationVC = [[WYConversationViewController alloc] init];
    _conversationVC.user = userinfo;
    _conversationVC.conversationType = ConversationType_PRIVATE;
    _conversationVC.targetId = model.targetId;
    _conversationVC.userName = userinfo.name;
    
    //  _conversationVC.locatedMessageSentTime = model.time;
    int unreadCount = [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PRIVATE targetId:model.targetId];
    _conversationVC.unReadMessage = unreadCount;
    _conversationVC.enableNewComingMessageIcon = YES; //开启消息提醒
    _conversationVC.enableUnreadMessageIcon = YES;
    //如果是单聊，不显示发送方昵称
    _conversationVC.displayUserNameInCell = NO;
    _conversationVC.isFriend = YES;
    [self.navigationController pushViewController:_conversationVC animated:YES];
    

}

//左滑删除
- (void)rcConversationListTableView:(UITableView *)tableView
                 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                  forRowAtIndexPath:(NSIndexPath *)indexPath {
    //可以从数据库删除数据
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_SYSTEM targetId:model.targetId];
    [self.conversationListDataSource removeObjectAtIndex:indexPath.row];
    [self.conversationListTableView reloadData];
}

- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    ((RCConversationCell *)cell).contentView.backgroundColor = [UIColor blackColor];
    ((RCConversationCell *)cell).conversationTitle.textColor = [UIColor whiteColor];
    ((RCConversationCell *)cell).messageContentLabel.textColor  =[[UIColor whiteColor] colorWithAlphaComponent:0.5];
     ((RCConversationCell *)cell).messageCreatedTimeLabel.textColor  =[[UIColor whiteColor] colorWithAlphaComponent:0.5];
    ((RCConversationCell *)cell).selectionStyle = UITableViewCellSelectionStyleNone;
    
}
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //缓存数据
            RCUserInfo * userInfo = [[RCUserInfo alloc] initWithUserId:@"10000" name:@"未央" portrait:@"http://thyrsi.com/t6/664/1548751873x2890191655.png"];
            
            [[WYDataBaseManager shareInstance] insertUserToDB:userInfo];
        
            
            WYSystemViewController *_conversationVC = [[WYSystemViewController alloc] init];
            _conversationVC.conversationType = ConversationType_SYSTEM;
        
            _conversationVC.targetId = @"10000";
            _conversationVC.userName = @"未央";
            int unreadCount = [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_SYSTEM targetId:@"10000"];
            _conversationVC.unReadMessage = unreadCount;
            _conversationVC.enableNewComingMessageIcon = YES; //开启消息提醒
            _conversationVC.enableUnreadMessageIcon = YES;
            //如果是单聊，不显示发送方昵称
            _conversationVC.displayUserNameInCell = NO;
            [self.navigationController pushViewController:_conversationVC animated:YES];

        }
            break;
            case 1:
        {
            [self.navigationController pushViewController:[WYCommentViewController new] animated:YES];
        }
            break;
            case 2:
        {
             [self.navigationController pushViewController:[WYLikeViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)viewDidLayoutSubviews

{
    [super viewDidLayoutSubviews];
    self.navBar.frame = CGRectMake(0, 0, KScreenWidth, KNaviBarHeight);
    self.headerView.frame = CGRectMake(0, 0, KScreenWidth, 270);
    self.conversationListTableView.frame = CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight);
}


-(WYMessageHeaderView*)headerView
{
    if(!_headerView)
    {
        _headerView = [[WYMessageHeaderView alloc]init];
        _headerView.prtocal = self;
    }
    return _headerView;
}

-(WYMessageNaviBar*)navBar
{
    if (!_navBar) {
        _navBar = [[WYMessageNaviBar alloc]init];
        
        @weakify(self);
        [[_navBar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }
    
    return _navBar;

}


@end
