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
#import "WYMYDynamicModel.h"
@interface WYPersonCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)WYPersonCenterHeaderView * headerView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIButton * messageButton;
@property(nonatomic,strong)UIView       * pointView;
@property(nonatomic,assign)int page;


@end
@implementation WYPersonCenterController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"个人中心"];
    [self setNavigationConfig];
    [self.view addSubview:self.tableView];
    [self addNotification];
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
    self.headerView.frame =CGRectMake(0, 0, KScreenWidth, 231);
}

-(void)addNotification
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:WYComposeSusscess object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        WYDynamicModel * model = (WYDynamicModel *)[x object];
        
        [self.dataArray insertObject:model atIndex:0];
        [self.tableView reloadData];
        
    }];
    
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


-(void)requestDataWithType:(int)type
{
    
    //停止loading
    [self hideNoNetWorkView];
    [self hideNoDataView];
    
    NSString * pageStr = [NSString stringWithFormat:@"%d",_page];
    NSDictionary * dict=@{@"page":pageStr,@"interface":@"Dynamic@getDynamicList",@"is_mine":@"1"};
    
    
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
                    NSLog(@"dynamic");
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
        _tableView.tableHeaderView = self.headerView;
        
        __weak __typeof(self) weakSelf = self;
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf retryToGetData];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreData];
            
        }];
        
        
        [_tableView.mj_header beginRefreshing];
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
