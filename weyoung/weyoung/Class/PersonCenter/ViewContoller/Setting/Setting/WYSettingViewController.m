//
//  WYSettingViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYSettingViewController.h"
#import "WYCodeViewController.h"
#import "WYBlackListViewController.h"
#import "WYFeedBackViewController.h"
#import "WYAboutViewController.h"
#import "WYEvaluateViewController.h"
#import <StoreKit/StoreKit.h>
#import "WYLoginViewController.h"
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
    [self setNavTitle:@"设置"];
}


-(void)initData
{
    self.titleArray = @[@"更改密码",@"黑名单",@"关于未央",@"问题反馈",@"五星好评",@"退出登录"];
    [self.tableView reloadData];
}

#pragma mark - TabelView delegate 代理

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(nullable UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(nullable UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

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
    cell.textLabel.textColor =(indexPath.row==5)?[UIColor binaryColor:@"6060FC"]:[UIColor binaryColor:@"DCDEEA"];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.x = 20;
    cell.accessoryType =(indexPath.row==5)?UITableViewCellAccessoryNone:UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont fontWithName:TextFontName_Light size:16];

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            
            NSString * phone = [WYSession sharedSession].phone;
            NSDictionary * dict = @{@"phone":phone,@"zone_num":@"86",@"interface":@"Login@forgetPassword",@"step":@"1"};
            WYHttpRequest *request = [[WYHttpRequest alloc]init];
            [request requestWithPragma:dict showLoading:NO];
            request.successBlock = ^(id  _Nonnull response) {
                
                WYCodeViewController * codeVc = [[WYCodeViewController alloc]init];
                codeVc.phone = phone;
                codeVc.type = WYCodeTypeChange;
                [self.navigationController pushViewController:codeVc animated:YES];
            };
            
            request.failureDataBlock = ^(id  _Nonnull error) {
                
            };
        
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
             [SKStoreReviewController requestReview];
        }
            break;
            case 5:
        {
            
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"记得回来看我哦～" preferredStyle:UIAlertControllerStyleAlert];
            //解决ipad 上面的崩溃
            alert.popoverPresentationController.sourceView = self.view;
            alert.popoverPresentationController.sourceRect = CGRectMake(0,0,1.0,1.0);
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消"
                                                             style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                           }];
            
            UIAlertAction *logOut = [UIAlertAction actionWithTitle:@"确定"
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               
                                                               [[WYSession sharedSession] removeUserInfo];
                                                               [[WYSession sharedSession] disconnectRc];
                                                               
                                                               WYLoginViewController * loginVC = [WYLoginViewController new];
                                                               UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
                                                               [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                                                               
                                                           }];
            
            [alert addAction:cancel];
            [alert addAction:logOut];
            [self presentViewController:alert animated:YES completion:nil];
        
            
        }
            break;
        default:
            break;
    }
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
