//
//  WYLoginViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYLoginViewController.h"
#import "WYPhoneInputView.h"
#import "WYCodeViewController.h"
@interface WYLoginViewController ()

@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UIImageView * logoImageView;
@property(nonatomic,strong)WYPhoneInputView * phoneInputView;
@property(nonatomic,strong)UILabel * infoLabel;
@property(nonatomic,strong)UIButton * clauseButton;
@property(nonatomic,strong)UIButton * loginButton;

@end

@implementation WYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.phoneInputView];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.clauseButton];
    [self.view addSubview:self.loginButton];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _bgImageView.frame = self.view.bounds;
    _phoneInputView.frame = CGRectMake(27.5, 260, KScreenWidth-55, 50);
    _infoLabel.frame = CGRectMake((KScreenWidth -287)/2, CGRectGetMaxX(self.phoneInputView.frame)+15, 172, 20);
    _clauseButton.frame = CGRectMake(CGRectGetMaxX(self.infoLabel.frame)+3, CGRectGetMaxX(self.phoneInputView.frame)+3,115, 44);
    _loginButton.frame = CGRectMake(KScreenWidth/2-40, KScreenHeight-KTabbarSafeBottomMargin-95-80, 80, 80);
    
}

-(UIImageView *)bgImageView
{
    if(!_bgImageView)
    {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.backgroundColor = [UIColor blackColor];
    }
    return _bgImageView;
}

-(WYPhoneInputView *)phoneInputView
{
    if(!_phoneInputView){
        _phoneInputView = [[WYPhoneInputView alloc]init];
        
    }
    return _phoneInputView;
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.text = @"登录即表示你已阅读并同意";
        _infoLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
        _infoLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}

-(UIButton*)clauseButton
{
    if (!_clauseButton) {
        _clauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clauseButton setTitle:@"《未央用户协议》" forState:UIControlStateNormal];
        [_clauseButton setTitleColor:[UIColor binaryColor:@"FFFFFF"] forState:UIControlStateNormal];
        _clauseButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        
        
        @weakify(self);
        [[_clauseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"[gx] _clauseButton click");
        }];
    }
    return _clauseButton;
}



-(UIButton*)loginButton
{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"[gx] login click");
            
            [self.navigationController pushViewController:[[WYCodeViewController alloc]init] animated:YES];
            
        }];
    }
    return _loginButton;
}

@end
