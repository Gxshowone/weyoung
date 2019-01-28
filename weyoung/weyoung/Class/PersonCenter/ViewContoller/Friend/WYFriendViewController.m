//
//  WYFriendViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYFriendViewController.h"
#import "WYFriendTableViewCell.h"
#import "WYDataBaseManager.h"
#import "WYConversationViewController.h"
@interface WYFriendViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,assign)int page;

@end

@implementation WYFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"好友"];
    [self.view addSubview:self.tableView];
    [self getFriendList];
    
}



-(void)getFriendList
{
    
    NSDictionary * dict=@{@"interface":@"Friend@getFriendList"};
    
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        NSArray * array  = (NSArray*)response;
        NSMutableArray * friendList = [NSMutableArray array];
        
        for (NSDictionary * dict in array) {
            
            WYUserInfo * user = [[WYUserInfo alloc]init];
            user.userId =  [dict valueForKey:@"uid"];
            user.name   =  [dict valueForKey:@"nick_name"];
            user.portraitUri  = [dict valueForKey:@"header_url"];
            user.brithday  = [dict valueForKey:@"birthday"];
            user.updatedAt = @"";
            user.status    = @"0";
            [friendList addObject:user];
            
        }
        
        [self saveFriend:friendList];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}

-(void)saveFriend:(NSMutableArray*)firendList
{
    [[WYDataBaseManager shareInstance] insertFriendListToDB:firendList complete:^(BOOL result) {
        
    }];
    
    self.dataArray = firendList;
    [self.tableView reloadData];

}


#pragma mark - TabelView delegate 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 80;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(nullable UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(nullable UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString * cellid = @"WYFriendTableViewCell";
    
    WYFriendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[WYFriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"解除好友";
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    
    WYUserInfo * model = self.dataArray[indexPath.row];
    [self deleteUser:model];
    
    //删除数据，和删除动画
    NSInteger index = indexPath.row;
    [self.dataArray removeObjectAtIndex:index];
    
    [self.tableView reloadData];
}

-(void)deleteUser:(WYUserInfo*)model
{
    NSString * to_uid = [NSString stringWithFormat:@"%@",model.userId];
    [[WYDataBaseManager shareInstance] deleteFriendFromDB:to_uid];
    
    NSDictionary * dict=@{@"interface":@"Friend@delFriend",@"to_uid":to_uid};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {

    };

    request.failureDataBlock = ^(id  _Nonnull error) {

    };
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYUserInfo * user = self.dataArray[indexPath.row];
    
    RCUserInfo  * userinfo = [[RCUserInfo alloc]init];
    userinfo.userId  = user.userId;
    userinfo.portraitUri = user.portraitUri;
    userinfo.name = user.name;
    
    WYConversationViewController *_conversationVC = [[WYConversationViewController alloc] init];
    _conversationVC.conversationType = ConversationType_PRIVATE;
    _conversationVC.targetId = user.userId;
    _conversationVC.userName = user.name;
    _conversationVC.user  = userinfo;
    //  _conversationVC.locatedMessageSentTime = model.time;
    int unreadCount = [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PRIVATE targetId:user.userId];
    _conversationVC.unReadMessage = unreadCount;
    _conversationVC.enableNewComingMessageIcon = YES; //开启消息提醒
    _conversationVC.enableUnreadMessageIcon = YES;
    //如果是单聊，不显示发送方昵称
    _conversationVC.displayUserNameInCell = NO;
    _conversationVC.isFriend = YES;
    [self.navigationController pushViewController:_conversationVC animated:YES];
}

-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,KNaviBarHeight,KScreenWidth,KScreenHeight-KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
       
    }
    return _tableView;
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
