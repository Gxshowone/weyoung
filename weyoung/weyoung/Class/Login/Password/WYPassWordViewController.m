//
//  WYPassWordViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPassWordViewController.h"
#import "WYPasswordInputView.h"
#import "WYInfoViewController.h"
@interface WYPassWordViewController ()

@property(nonatomic,strong)UILabel     * inputLabel;
@property(nonatomic,strong)UILabel     * passwordLabel;
@property(nonatomic,strong)WYPasswordInputView * inputView;
@property(nonatomic,strong)UIButton    * nextButton;

@end

@implementation WYPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.inputLabel];
    [self.view addSubview:self.passwordLabel];
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.nextButton];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.inputLabel.frame = CGRectMake(KScreenWidth/2-61.5, KNaviBarHeight+66, 123, 33);
    self.passwordLabel.frame = CGRectMake(KScreenWidth/2-118, CGRectGetMaxY(self.inputLabel.frame)+10,236, 20);
    self.inputView.frame = CGRectMake(27.5, 260, KScreenWidth-55, 50);
    self.nextButton.frame = CGRectMake(KScreenWidth/2-40, KScreenHeight-KTabbarSafeBottomMargin-95-80, 80, 80);
    
}


-(UILabel*)inputLabel
{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]init];
        _inputLabel.text = @"设置密码";
        _inputLabel.font = [UIFont fontWithName:TextFontName_Light size:24];
        _inputLabel.textAlignment = NSTextAlignmentCenter;
        _inputLabel.textColor = [UIColor binaryColor:@"FFFFFF"];
    }
    return _inputLabel;
}

-(UILabel*)passwordLabel
{
    if (!_passwordLabel) {
        _passwordLabel = [[UILabel alloc]init];
        _passwordLabel.text = @"密码由6-20位字母数字或符号组成";
        _passwordLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _passwordLabel.textAlignment = NSTextAlignmentCenter;
        _passwordLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
    }
    return _passwordLabel;
}


-(WYPasswordInputView *)inputView
{
    if(!_inputView){
        _inputView = [[WYPasswordInputView alloc]init];
        
    }
    return _inputView;
}

-(UIButton*)nextButton
{
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"[gx] login click");
            
            [self.navigationController pushViewController:[[WYInfoViewController alloc]init] animated:YES];
            
        }];
    }
    return _nextButton;
}


@end
