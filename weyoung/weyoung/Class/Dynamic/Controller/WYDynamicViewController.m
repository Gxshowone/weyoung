//
//  WYDynamicViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYDynamicViewController.h"
#import "WYDynamicTableViewCell.h"
#import "WYDynamicModel.h"
#import "WYComposeViewController.h"
#import "WYMoreView.h"
#import <YYCache/YYCache.h>

static NSString * const cacheKey = @"WYALLDynamicList";

@interface WYDynamicViewController ()<UITableViewDelegate,UITableViewDataSource,WYDynamicTableViewCellDelegate>
{
    YYCache *cache ;
}
@property(nonatomic,strong)WYMoreView * moreView;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)UIButton * sendButton;
@property(nonatomic,assign)int page;

@end
@implementation WYDynamicViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setNavTitle:@"动态"];
    [self setNaviGationConfig];
    [self initUI];
    [self addNotification];
    [self initData];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.sendButton.frame = CGRectMake(KScreenWidth-15.3-55, KScreenHeight-KTabbarSafeBottomMargin-16.7-55, 55, 55);
}

-(void)setNaviGationConfig
{
    self.titleLabel.font = [UIFont fontWithName:TextFontName_Medium size:24];
    self.titleLabel.mj_x = 20;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.leftButton.hidden = YES;
    [self.rightButton setImage:[UIImage imageNamed:@"navi_back_btn_right"] forState:UIControlStateNormal];
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self gotoHomePage];
    }];
 
}

-(void)addNotification
{
    @weakify(self);
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:WYComposeSusscess object:nil] subscribeNext:^(id x) {
        @strongify(self);
        
        WYDynamicModel * model = (WYDynamicModel *)[x object];
        
        [self.dataArray insertObject:model atIndex:0];
        [self.tableView reloadData];
        [self.tableView scrollsToTop];
        
    }];
    
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sendButton];
}
-(void)initData
{

   [self.tableView.mj_header beginRefreshing];
    
}
-(void)gotoHomePage
{
    NSLog(@"[gx] goto hp");
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:1];
    }
}


-(void)requestDataWithType:(int)type
{
    
    //停止loading
    [self hideNoNetWorkView];
    [self hideNoDataView];
    
    NSString * pageStr = [NSString stringWithFormat:@"%d",_page];
    NSDictionary * dict=@{@"page":pageStr,@"interface":@"Dynamic@getDynamicList",@"is_mine":@"0"};

    
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
      
        NSArray * array  = (NSArray*)response;
        NSMutableArray * modelArray = [WYDynamicModel mj_objectArrayWithKeyValuesArray:array];
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
      //  [self nodata];
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
    
 //  [self->cache setObject:self.dataArray forKey:cacheKey];

    
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
    WYDynamicModel * model = self.dataArray[indexPath.row];
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
    static NSString * cellid = @"WYDynamicTableViewCell";
    
    WYDynamicTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[WYDynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.model = self.dataArray[indexPath.row];
    cell.delegate = self;
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"[gx] goto chat");
    
    WYDynamicModel * model  = self.dataArray[indexPath.row];
    if (self.delegate) {
        [self.delegate gotoComment:model];
    }
 
}

-(void)moreDynamic:(WYDynamicModel*)model

{
    [self.moreView show];
}
-(void)likeDynamic:(WYDynamicModel*)model
{
    
    NSDictionary * dict = @{@"interface":@"Dynamic@doComment" ,@"d_id":model.d_id,@"type":@"2"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
   
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
      
    };
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
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf loadMoreData];
            
        }];
        
        

    }
    return _tableView;
}

-(UIButton*)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setImage:[UIImage imageNamed:@"dynamic_send_btn"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            WYComposeViewController *compose = [[WYComposeViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:compose];
            [self presentViewController:nav animated:YES completion:nil];
            
        }];
    }
    return _sendButton;
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


@end
