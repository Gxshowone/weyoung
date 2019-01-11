//
//  WYBaseViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYBaseViewController.h"

@interface WYBaseViewController ()

@end

@implementation WYBaseViewController

+ (instancetype)viewController{
    
    return [[self alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self preferredStatusBarStyle];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;

    self.view.backgroundColor = [UIColor binaryColor:@"000000"];
    
    [self.view addSubview:self.customNavigationBar];
    
    
}

#pragma mark - dealloc

- (void)dealloc
{
    
}

#pragma mark - Interface

#pragma mark - Event response
-(void)showBackButton:(BOOL)show{
    self.leftButton.hidden = !show;
    
    if(show){
        [self.leftButton setImage:[UIImage imageNamed:@"nav_back_normal"] forState:UIControlStateNormal];
        
        [self.leftButton addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [self.leftButton setImage:nil forState:UIControlStateNormal];
        [self.leftButton removeTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

#pragma mark - Private method
//设置title
-(void)setNavTitle:(NSString *)title
{
    self.titleLabel.text = title;
}


-(void)backEvent{
    if (self.isPresent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if(_isPopToRoot==YES)
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(void)setBackImageViewWithName:(NSString *)imgName
{
    self.backGroundImageView.image = [UIImage imageNamed:imgName];
    [self.view insertSubview:self.backGroundImageView atIndex:0];
}

- (void)creatUserInterface
{
    
}
-(void)operationData
{
    
}
- (void)setNavigationBarHide:(BOOL)isHide
{
    if(isHide){
        [self.customNavigationBar removeFromSuperview];
    }else{
        [self.view addSubview:self.customNavigationBar];
    }
}


#pragma mark - NoDataView method
/**
 *  显示无数据视图
 */

-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString noDataImage:(NSString*)imageName imageViewFrame:(CGRect)rect
{
    if (!_noDataView) {
        _noDataView =  [[WYNoDataView alloc] init];
        _noDataView.delegate = self;
    }
    [_noDataView showNoDataView:superView noDataString:noDataString noDataImage:imageName imageViewFrame:rect];
}


- (void)hideNoDataView
{
    [_noDataView hide];
}


#pragma mark -noNetWorkView method
-(void)showNoNetWorkViewWithimageName:(NSString*)imageName{
    [self showNoNetWorkViewInView:self.view imageName:imageName];
}

- (void)showNoNetWorkView:(WYNoNetWorkViewStyle)style imageName:(NSString*)imageName{
    return [self showNoNetWorkViewInView:self.view frame:self.view.bounds style:style imageName:imageName];
}

- (void)showNoNetWorkViewWithFrame:(CGRect)frame imageName:(NSString*)imageName{
    [self showNoNetWorkViewInView:self.view frame:frame imageName:imageName];
}

-(void)showNoNetWorkViewInView:(UIView *)view imageName:(NSString*)imageName{
    [self showNoNetWorkViewInView:view frame:CGRectMake(0, 64, KScreenWidth, KScreenHeight-64) imageName:imageName];
}

- (void)showNoNetWorkViewInView:(UIView *)view frame:(CGRect)frame imageName:(NSString*)imageName{
    WYNoNetWorkViewStyle style = WYNoNetWorkViewStyle_No_NetWork;
    AFNetworkReachabilityStatus networkStatus = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if(networkStatus == AFNetworkReachabilityStatusReachableViaWiFi || networkStatus == AFNetworkReachabilityStatusReachableViaWWAN){
        //加载失败
        style = WYNoNetWorkViewStyle_Load_Fail;
    }
    [self showNoNetWorkViewInView:view frame:frame style:style imageName:imageName];
}

- (void)showNoNetWorkViewInView:(UIView *)view frame:(CGRect)frame style:(WYNoNetWorkViewStyle)style imageName:(NSString *)imageName{
    if (!_noNetWorkView) {
        _noNetWorkView = [[WYNoNetView alloc] init];
        _noNetWorkView.delegate = self;
    }
    _noNetWorkView.frame = frame;
    [_noNetWorkView showInView:view style:style imageName:imageName];
}

-(void)hideNoNetWorkView
{
    [_noNetWorkView hide];
}
-(void)stopAiv
{
    [_noNetWorkView stopAiv];
}

#pragma mark - Getters and Setters
-(UIImageView*)customNavigationBar
{
    if (!_customNavigationBar) {
        _customNavigationBar = [[UIImageView alloc]init];
        _customNavigationBar.frame = CGRectMake(0, 0,KScreenWidth,KNaviBarHeight);
        _customNavigationBar.userInteractionEnabled = YES;
        [_customNavigationBar setImage:[UIImage imageNamed:@"navigation_bar"]];
        [_customNavigationBar addSubview:self.rightButton];
        [_customNavigationBar addSubview:self.leftButton];
        [_customNavigationBar addSubview:self.titleLabel];
        
        
    }
    return _customNavigationBar;
}


-(WYButton*)leftButton
{
    if (!_leftButton) {
        _leftButton = [WYButton buttonWithType:UIButtonTypeCustom];
        _leftButton.titleLabel.font = [UIFont fontWithName:TextFontName size:16.0];
        [_leftButton setFrame:CGRectMake(0, 20+KNaviBarSafeBottomMargin, 48, 50)];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_leftButton setImage:[UIImage imageNamed:@"navi_back_btn"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
       
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }
    return _leftButton;
}

-(WYButton*)rightButton
{
    if (!_rightButton) {
        _rightButton = [WYButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setFrame:CGRectMake(KScreenWidth-48,20+KNaviBarSafeBottomMargin,48,50)];
        _rightButton.titleLabel.font = [UIFont fontWithName:TextFontName_Medium size:16.0];
        [_rightButton setTitleColor:[UIColor binaryColor:@"6060FC"] forState:UIControlStateNormal];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
   
    }
    
    return _rightButton;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(100, KNaviBarSafeBottomMargin+20,KScreenWidth-200, 44);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:TextFontName size:16];
        _titleLabel.adjustsFontSizeToFitWidth =YES;
        _titleLabel.minimumScaleFactor = 0.4;
    }
    return _titleLabel;
}

-(UIImageView*)backGroundImageView
{
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        
    }
    return _backGroundImageView;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
