//
//  WYSettingViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYSettingViewController.h"
#import "WYPasswordChangeViewController.h"
#import "WYBlackListViewController.h"
#import "WYFeedBackViewController.h"
#import "WYAboutViewController.h"
#import "WYEvaluateViewController.h"

@interface WYSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray * titleArray;


@end
@implementation WYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self initData];
}

-(void)initData
{
    self.titleArray = @[@"更改密码",@"黑名单",@"关于未央",@"问题反馈",@"五星好评",@"退出登录"];
    [self.tableView reloadData];
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
    
    return [self.titleArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
   
    static NSString * cellid = @"cellid";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text =self.titleArray[indexPath.row];
    cell.textLabel.textColor =(indexPath.row==5)?[UIColor binaryColor:@"DCDEEA"]:[UIColor binaryColor:@"DCDEEA"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.x = 20;
    cell.accessoryType =(indexPath.row==5)?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[WYPasswordChangeViewController new] animated:YES];
        }
            break;
            case 1:
        {
              [self.navigationController pushViewController:[WYBlackListViewController new] animated:YES];
        }
            break;
            case 2:
        {
              [self.navigationController pushViewController:[WYAboutViewController new] animated:YES];
        }
            break;
            case 3:
        {
              [self.navigationController pushViewController:[WYFeedBackViewController new] animated:YES];
        }
            break;
            case 4:
        {
              [self.navigationController pushViewController:[WYEvaluateViewController new] animated:YES];
        }
            break;
            case 5:
        {
            
        }
            break;
        default:
            break;
    }
}



-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight-KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


@end
