//
//  WYAboutViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYAboutViewController.h"
#import "WYAboutHeaderView.h"
#import "WYWebViewController.h"
@interface WYAboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WYAboutHeaderView * headerView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSArray     * titleArray;

@end

@implementation WYAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self initData];
}

-(void)initData
{
    [self setNavTitle:@"关于未央"];
    self.titleArray = @[@"隐私政策",@"服务条款"];
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


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 184;
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
    
    cell.textLabel.text =self.titleArray[indexPath.row];
    cell.textLabel.textColor =[UIColor binaryColor:@"DCDEEA"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.x = 20;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYWebViewController * webVc = [[WYWebViewController alloc]init];
    webVc.url = @"http://api.supe.tv/privacy.html";
    [self.navigationController pushViewController:webVc animated:YES];
}

-(WYAboutHeaderView*)headerView
{
    if (!_headerView) {
        _headerView = [[WYAboutHeaderView alloc]init];
        
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

@end
