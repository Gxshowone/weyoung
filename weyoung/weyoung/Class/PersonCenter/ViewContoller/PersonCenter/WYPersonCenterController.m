//
//  WYPersonCenterController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPersonCenterController.h"
#import "WYSettingViewController.h"
#import "WYPersonCenterHeaderView.h"
#import "WYEditViewController.h"
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
    [self registerGesture];
    [self.view addSubview:self.tableView];
 
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.messageButton.frame = CGRectMake(KScreenWidth-100, 20, 48,50);
}

-(void)registerGesture
{
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf disMiss];
        }
    }];
}

-(void)disMiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)setNavigationConfig
{
    
    @weakify(self);
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        [self disMiss];
    }];

    [self.rightButton setImage:[UIImage imageNamed:@"navi_setting_btn"] forState:UIControlStateNormal];
   
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        
         WYSettingViewController * settingVc = [[WYSettingViewController alloc]init];
        [self.navigationController pushViewController:settingVc animated:YES];
    }];
    
    [self.customNavigationBar addSubview:self.messageButton];
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
    
    static NSString * cellid = @"cellid";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
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
                    WYEditViewController * editVc = [[WYEditViewController alloc]init];
                    [self.navigationController pushViewController:editVc animated:YES];
                }
                    break;
                    case 1:
                {
                    
                }
                    break;
                    case 2:
                {
                    
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
