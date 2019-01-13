//
//  WYCommentController.m
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCommentController.h"
#import "WYCommentToolBar.h"
#import "WYCommentCell.h"
#import "WYCommentHeader.h"
#import "WYCommentModel.h"
@interface WYCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)WYCommentHeader * headerView;
@property(nonatomic,strong)WYCommentToolBar * toolBar;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
//是否正在切换键盘
@property (nonatomic ,assign, getter=isChangingKeyboard) BOOL ChangingKeyboard;

@property(nonatomic,assign)int page;


@end

@interface WYCommentController ()

@end

@implementation WYCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"详情"];
    [self initUI];
    [self addNotification];
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
  
}

-(void)addNotification
{
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏：工具条（toolbar）随着键盘移动
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    //需要判断是否自定义切换的键盘
    if (self.isChangingKeyboard) {
        self.ChangingKeyboard = NO;
        return;
    }
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;//回复之前的位置
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, KNaviBarHeight, KScreenWidth, KTabBarHeight-KNaviBarHeight-KTabbarSafeBottomMargin-58);
    self.toolBar.frame = CGRectMake(0, KScreenHeight-KTabbarSafeBottomMargin-58, KScreenWidth, 58+KTabbarSafeBottomMargin);
    
}



-(void)requestDataWithType:(int)type
{
    
    //停止loading
    [self hideNoNetWorkView];
    [self hideNoDataView];
    
    NSString * pageStr = [NSString stringWithFormat:@"%d",_page];
    NSDictionary * dict=@{@"page":pageStr,@"interface":@"Dynamic@getCommentList",@"d_id":self.model.d_id,@"type":@"1"};
    
    
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        NSArray * array  = (NSArray*)response;
        NSMutableArray * modelArray = [WYCommentModel mj_objectArrayWithKeyValuesArray:array];
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
        [self nodata];
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
    
    _page = 0;
    
    [self requestDataWithType:1];
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadMoreData];
        
    }];
}


-(void)loadMoreData
{
    _page ++;
    [self requestDataWithType:2];
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
    static NSString * cellid = @"WYCommentCell";
    
    WYCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[WYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}

-(WYCommentHeader*)headerView
{
    if (!_headerView) {
        _headerView = [[WYCommentHeader alloc]init];
    }
    return _headerView;
}

-(UITableView*)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,KNaviBarHeight,KScreenWidth,KScreenHeight-KNaviBarHeight-KTabbarSafeBottomMargin-58) style:UITableViewStyleGrouped];
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.tableHeaderView = self.headerView;
        
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

-(WYCommentToolBar*)toolBar
{
    if (!_toolBar) {
        _toolBar = [[WYCommentToolBar alloc]init];
    }
    return _toolBar;
}

-(void)setModel:(WYDynamicModel *)model
{
    _model = model;
    
    self.headerView.model = model;

    [self.tableView.mj_header beginRefreshing];
}

@end
