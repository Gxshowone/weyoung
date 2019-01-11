//
//  WYInputViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/19.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYInputViewController.h"
#import "WYGradientButton.h"
#import "WYCodeInputView.h"
#import "WYCodeViewController.h"
#import "NSString+Validation.h"
#import <AudioToolbox/AudioToolbox.h>
@interface WYInputViewController ()


@property(nonatomic,strong)UILabel     * inputLabel;
@property(nonatomic,strong)UIButton     * forgetButton;
@property(nonatomic,strong)WYGradientButton    * nextButton;
@property(nonatomic,strong)WYCodeInputView  * inputView;

@end

@implementation WYInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.inputLabel];
    [self.view addSubview:self.forgetButton];
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.nextButton];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.inputLabel.frame = CGRectMake(KScreenWidth/2-61.5, KNaviBarHeight+66, 123, 33);
    self.forgetButton.frame = CGRectMake(KScreenWidth/2-118, CGRectGetMaxY(self.inputLabel.frame),236, 40);
     self.inputView.frame = CGRectMake(27.5, KNaviBarHeight+196, KScreenWidth-55, 50);
    self.nextButton.frame = CGRectMake(KScreenWidth/2-40, KScreenHeight-KTabbarSafeBottomMargin-95-80, 80, 80);
    self.nextButton.style = WYGradientButtonCircle;
}


-(UILabel*)inputLabel
{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]init];
        _inputLabel.text = @"输入密码";
        _inputLabel.font = [UIFont fontWithName:TextFontName_Light size:24];
        _inputLabel.textAlignment = NSTextAlignmentCenter;
        _inputLabel.textColor = [UIColor binaryColor:@"FFFFFF"];
    }
    return _inputLabel;
}

-(WYCodeInputView*)inputView
{
    if (!_inputView) {
        _inputView = [[WYCodeInputView alloc]init];
        @weakify(self);
        [[_inputView.codeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self sendCode];
        }];
    }
    return _inputView;
}


-(UIButton*)forgetButton
{
    if (!_forgetButton) {
        _forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgetButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        [_forgetButton setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_forgetButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
        }];
    }
    return _forgetButton;
}


-(WYGradientButton*)nextButton
{
    if (!_nextButton) {
        _nextButton = [WYGradientButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            if ([[self.inputView inputText] isEmpty]) {
                [self.view makeToast:@"请输入密码" duration:3.0 position:CSToastPositionTop];
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }else
            {
                [self login];
            }
    
        }];
    }
    return _nextButton;
}

-(void)sendCode
{
    NSDictionary * dict = @{@"phone":self.phone,@"zone_num":@"86",@"interface":@"Login@login",@"type":@"2",@"step":@"1"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        WYCodeViewController * codeVc = [[WYCodeViewController alloc]init];
        codeVc.phone = self.phone;
        codeVc.type = WYCodeTypeLogin;
        [self.navigationController pushViewController:codeVc animated:YES];
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
       
    };
}


-(void)login
{
    NSDictionary * dict = @{@"phone":self.phone,@"zone_num":@"86",@"interface":@"Login@login",@"type":@"1",@"password":[self.inputView inputText]};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        WYSession * session = [WYSession sharedSession];
        [session loginUser:response phone:self.phone];
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
        [self.view makeToast:@"密码不正确" duration:3.0 position:CSToastPositionTop];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
    };
}



-(void)setPhone:(NSString *)phone
{
    _phone = phone;
}



@end
