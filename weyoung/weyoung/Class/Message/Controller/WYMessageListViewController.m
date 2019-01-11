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
@interface WYMessageListViewController ()<UITableViewDelegate,UITableViewDataSource>

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isClick = YES;
  
}

-(void)setConversationType
{
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
}

-(CGFloat)rcConversationListTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
 
    WYConversationViewController *conversationVC = [[WYConversationViewController alloc]init];
    conversationVC.conversationType = ConversationType_PRIVATE;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
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



-(void)viewDidLayoutSubviews

{
    [super viewDidLayoutSubviews];
    self.navBar.frame = CGRectMake(0, 0, KScreenWidth, KNaviBarHeight);
    self.conversationListTableView.frame = CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight);
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
