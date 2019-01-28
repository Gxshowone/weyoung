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
#import "WYMoreView.h"
#import "NSString+Extension.h"
#import <IQKeyboardManager.h>
#import "WYOtherPersonalViewController.h"
@interface WYCommentController ()<UITableViewDelegate,UITableViewDataSource,WYCommentToolBarDelegate,WYCommentHeaderDelegate>


@property(nonatomic,strong)WYMoreView * moreView;
@property(nonatomic,strong)WYCommentHeader * headerView;
@property(nonatomic,strong)WYCommentToolBar * toolBar;
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
//是否正在切换键盘
@property (nonatomic ,assign, getter=isChangingKeyboard) BOOL ChangingKeyboard;

@property(nonatomic,assign)int page;

@property(nonatomic,strong)WYCommentModel * selectModel;
@property(nonatomic,assign)BOOL commonMaster;

@end

@interface WYCommentController ()

@end

@implementation WYCommentController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavTitle:@"详情"];
    [self initUI];
    [self addNotification];
    
    self.commonMaster = YES;
}

-(void)initUI
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
    
    @weakify(self);
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    self.tableView.frame = CGRectMake(0, KNaviBarHeight, KScreenWidth, KScreenHeight-KNaviBarHeight-KTabbarSafeBottomMargin-58);
    self.toolBar.frame = CGRectMake(0, KScreenHeight-KTabbarSafeBottomMargin-58, KScreenWidth, 58+KTabbarSafeBottomMargin);
  
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

    self.headerView.userInteractionEnabled = YES;
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
 
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;//回复之前的位置
        self.commonMaster = YES;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    
    self.headerView.userInteractionEnabled = NO;
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
   //     [self nodata];
        [self nomoredata:modelArray];
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
          [self stopLoadData];
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
    WYCommentModel * model = self.dataArray[indexPath.row];
    return model.rowHeight;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    static NSString * cellid = @"WYCommentCell";
    
    WYCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[WYCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    

    cell.model = self.dataArray[indexPath.row];
    
    @weakify(self);
    cell.tapCommentBlock = ^(WYCommentCell * _Nonnull cell, WYCommentModel * _Nonnull model) {
        @strongify(self);
        WYOtherPersonalViewController * otherVC = [[WYOtherPersonalViewController alloc]init];
        otherVC.uid = model.uid;
        [self.navigationController pushViewController:otherVC animated:YES];
    };
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectModel = self.dataArray[indexPath.row];
    [self.toolBar beginEdit];
    self.commonMaster = NO;
}

-(void)gotoOtherCenter:(WYDynamicModel*)model
{
    WYOtherPersonalViewController * otherVC = [[WYOtherPersonalViewController alloc]init];
    otherVC.uid = model.uid;
    [self.navigationController pushViewController:otherVC animated:YES];
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

-(void)sendCommon:(NSString*)text
{
    BOOL needC_uid = (self.commonMaster==NO&&[self.selectModel.uid isEqualToString:[WYSession sharedSession].uid]==NO)?YES:NO;
    NSDictionary * dict = (needC_uid)?@{@"interface":@"Dynamic@doComment",@"d_id":self.model.d_id,@"type":@"1",@"comment":text,@"c_uid":self.selectModel.uid}:@{@"interface":@"Dynamic@doComment",@"d_id":self.model.d_id,@"type":@"1",@"comment":text};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
    
        [self.toolBar stopEdit];
        
        
        WYCommentModel * model = [[WYCommentModel alloc]init];
        model.c_header_url = (needC_uid)?self.selectModel.header_url:@"";
        model.c_uid = (needC_uid)?self.selectModel.uid:@"";
        model.c_nick_name = (needC_uid)?self.selectModel.nick_name:@"";
        model.nick_name = [WYSession sharedSession].nickname;
        model.c_id = @"";
        model.comment = text;
        model.create_time = [NSString getNowTimeTimestamp];
        model.d_id = @"";
        model.uid = [WYSession sharedSession].uid;
        model.header_url = [WYSession sharedSession].avatar;
        
        [self.dataArray insertObject:model atIndex:0];
        [self.tableView reloadData];
        [self.tableView scrollsToTop];

    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
        
    };
}


-(WYCommentHeader*)headerView
{
    if (!_headerView) {
        _headerView = [[WYCommentHeader alloc]init];
        _headerView.delegate= self;
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
        _toolBar.delegate = self;
    }
    return _toolBar;
}

-(void)setModel:(WYDynamicModel *)model
{
    _model = model;
    
    self.headerView.model = model;
    self.headerView.height = model.rowHeight+60;
    [self retryToGetData];
    
}

-(void)setD_id:(NSString *)d_id
{
    _d_id = d_id;
    NSDictionary * dict =@{@"interface":@"Dynamic@getDynamicDetail",@"d_id":d_id};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
     
        WYDynamicModel * model = [WYDynamicModel mj_objectWithKeyValues:response];
        self.model = model;
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
   
    };
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
