//
//  WYPersonCenterController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPersonCenterController.h"
#import "WYPersonCenterHeaderView.h"
#import "WYMyDynamicTableViewCell.h"
@interface WYPersonCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)WYPersonCenterHeaderView * headerView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIButton * messageButton;
@property(nonatomic,strong)UIView       * pointView;

@end
@implementation WYPersonCenterController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"个人中心"];
    [self setNavigationConfig];
    [self.view addSubview:self.tableView];
 
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.pointView.frame = CGRectMake(KScreenWidth-70, 30+KNaviBarSafeBottomMargin, 9, 9);
    self.messageButton.frame = CGRectMake(KScreenWidth-100, 20+KNaviBarSafeBottomMargin, 48,50);
}


-(void)setNavigationConfig
{
    
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [self gotoHomePage];
    }];

    [self.rightButton setImage:[UIImage imageNamed:@"navi_setting_btn"] forState:UIControlStateNormal];
   
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x)
       {
        
        if(self.delegate&&[self.delegate respondsToSelector:@selector(setting)])
        {
            [self.delegate setting];
        }
     
    }];
    
    [self.customNavigationBar addSubview:self.messageButton];
    [self.customNavigationBar addSubview:self.pointView];
    
    int totalUnreadCount = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    self.pointView.hidden = (totalUnreadCount==0)?YES:NO;
    
}

-(void)gotoHomePage
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:1];
    }
   
}

-(void)getUserInfo
{
    NSDictionary * dict = @{@"interface":@"User@getUserInfo"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        WYSession * session = [WYSession sharedSession];
        [session updateUser:response];

        [self.headerView reload];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}


#pragma mark - TabelView delegate 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.dataArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  
    return 231;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString * cellid = @"WYMyDynamicTableViewCell";
    
    WYMyDynamicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[WYMyDynamicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
  
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(WYPersonCenterHeaderView*)headerView
{
    if (!_headerView) {
        _headerView = [[WYPersonCenterHeaderView alloc]init];
        
         @weakify(self);
        _headerView.block = ^(NSInteger index) {
            @strongify(self);
            switch (index) {
                case 0:
                {
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(edit)])
                    {
                        [self.delegate edit];
                    }
                }
                    break;
                    case 1:
                {
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(friendList)])
                    {
                        [self.delegate friendList];
                    }
                }
                    break;
                    case 2:
                {
                    if(self.delegate&&[self.delegate respondsToSelector:@selector(friendList)])
                    {
                        [self.delegate friendList];
                    }
                }
                    break;
                default:
                    break;
            }
            
            
        };
     
        
    }
    return _headerView;
}



-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

-(UIButton*)messageButton
{
    if (!_messageButton) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageButton setImage:[UIImage imageNamed:@"navi_message_btn"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_messageButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"[gx] goto message");
             if(self.delegate)
             {
                 [self.delegate message];
             }
            
        }];
    }
    return _messageButton;
}

-(UIView*)pointView
{
    if (!_pointView) {
        _pointView = [[UIView alloc]init];
        _pointView.backgroundColor = [UIColor binaryColor:@"F64F6E"];
        _pointView.layer.cornerRadius = 4.5;
        _pointView.layer.masksToBounds = YES;
        
    }
    return _pointView;
}

@end
