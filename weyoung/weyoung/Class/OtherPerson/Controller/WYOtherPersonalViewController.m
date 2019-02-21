

//
//  WYOtherPersonalViewController.m
//  weyoung
//
//  Created by gongxin on 2019/1/28.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYOtherPersonalViewController.h"
#import "WYOtherPersonHeader.h"
#import "WYMyDynamicTableViewCell.h"
#import "WYMYDynamicModel.h"
#import "WYUserModel.h"
#import "WYMoreView.h"
@interface WYOtherPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)WYOtherPersonHeader * headerView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int page;
@property(nonatomic,strong)WYMoreView * moreView;

@end

@implementation WYOtherPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    self.headerView.frame =CGRectMake(0, 0, KScreenWidth, 231);
}


-(void)setNavigationConfig
{
    
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];

  
}

-(void)getUserInfo:(NSString*)userId
{
    NSDictionary * dict = @{@"interface":@"User@getUserInfo",@"check_uid":userId};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        WYUserModel * user = [WYUserModel mj_objectWithKeyValues:response];
        self.headerView.model = user;
    
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}


-(void)requestDataWithType:(int)type
{
    
    //停止loading
    [self hideNoNetWorkView];
    [self hideNoDataView];
    
    NSString * pageStr = [NSString stringWithFormat:@"%d",_page];
    NSDictionary * dict=@{@"page":pageStr,@"interface":@"Dynamic@getDynamicList",@"check_uid":_uid};
    
    
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        NSArray * array  = (NSArray*)response;
        NSMutableArray * modelArray = [WYMYDynamicModel mj_objectArrayWithKeyValuesArray:array];
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


-(void)loadMoreData
{
    _page ++;
    [self requestDataWithType:2];
}


#pragma mark - TabelView delegate 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    WYMYDynamicModel * model = self.dataArray[indexPath.row];
    return model.rowHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(nullable UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    static NSString * cellid = @"WYMyDynamicTableViewCell";
    
    WYMyDynamicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[WYMyDynamicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.model = self.dataArray[indexPath.row];

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.moreView show];
}


-(WYOtherPersonHeader*)headerView
{
    if (!_headerView) {
        _headerView = [[WYOtherPersonHeader alloc]init];
    
    }
    return _headerView;
}

-(WYMoreView*)moreView
{
    if (!_moreView) {
        
        _moreView = [[WYMoreView alloc]initWithSuperView:self.view.superview
                                         animationTravel:0.3
                                              viewHeight:160];
        _moreView.type =  WYMoreViewType_Dynamic;
        
    }
    return _moreView;
}

-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
        
        __weak __typeof(self) weakSelf = self;
        
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakSelf retryToGetData];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreData];
            
        }];
        
    }
    return _tableView;
}


-(void)setUid:(NSString *)uid
{
    _uid = uid;
    
    [self getUserInfo:uid];
    [self retryToGetData];
}

@end
