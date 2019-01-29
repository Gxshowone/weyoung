//
//  WYCommentViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/27.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYCommentViewController.h"
#import "WYCommentTableViewCell.h"
#import "WYCommonMessage.h"
#import "WYCommentController.h"
@interface WYCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int page;

@end

@implementation WYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setNavTitle:@"评论"];
    [self.view addSubview:self.tableView];
    
}

-(void)requestDataWithType:(int)type
{
    
    //停止loading
    [self hideNoNetWorkView];
    [self hideNoDataView];
    
    NSDictionary * dict=@{@"interface":@"Dynamic@getMineCommentList",@"type":@"1"};

    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        NSArray * array  = (NSArray*)response;
        NSMutableArray * modelArray = [WYCommonMessage mj_objectArrayWithKeyValuesArray:array];
        if (type == 1) {
            
            //首先要清空id 数组 和数据源数组
            self.dataArray = [NSMutableArray arrayWithArray:modelArray];
            
        }else if(type == 2){
            
            NSMutableArray * Array = [[NSMutableArray alloc] init];
            [Array addObjectsFromArray:self.dataArray];
            [Array addObjectsFromArray:modelArray];
            self.dataArray = Array;
            
        }
        
        [self stopLoadData];
       // [self nodata];
        [self nomoredata:modelArray];
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
    
    
}
-(void)nodata
{
    if ([self.dataArray count]==0) {
        
        CGRect rect  = CGRectMake(KScreenWidth/2-52, 121, 104, 80);
        [self showNoDataView:self.view noDataString:@"暂无数据" noDataImage:@"default_nodata" imageViewFrame:rect];
        
        [_noDataView setContentViewFrame:CGRectMake(0, 108, KScreenWidth, KScreenHeight-108-54)];
    }
    
}

-(void)nomoredata:(NSMutableArray*)array
{
    if ([array count]==0) {
        
        self.tableView.mj_footer = nil;
    }
    
}

-(void)nonet
{
    
    [self showNoNetWorkViewWithimageName:@"default_nonetwork"];
}

-(void)stopLoadData
{
    
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
    
}

//重新加载请求
-(void)retryToGetData
{
    
    _page = 1;
    [self requestDataWithType:1];
    
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
    static NSString * cellid = @"WYCommentTableViewCell";
    
    WYCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[WYCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WYCommonMessage * model = self.dataArray[indexPath.row];
    WYCommentController * commentVc = [[WYCommentController alloc]init];
    commentVc.d_id = model.d_id;
    [self.navigationController pushViewController:commentVc animated:YES];
}

-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,KNaviBarHeight,KScreenWidth,KScreenHeight-KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        
        __weak __typeof(self) weakSelf = self;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf retryToGetData];
        }];
 
        [_tableView.mj_header beginRefreshing];
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
