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

@end
@implementation WYPersonCenterController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"个人中心"];
    [self setNavigationConfig];
    [self.view addSubview:self.tableView];
 
}



-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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
}

-(void)gotoHomePage
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:1];
    }
   
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
            
        }];
    }
    return _messageButton;
}


@end
