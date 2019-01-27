//
//  WYPasswordChangeViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPasswordChangeViewController.h"
#import "WYPasswordInputView.h"
#import "WYInfoViewController.h"
#import "WYGradientButton.h"
#import "NSString+Validation.h"
@interface WYPasswordChangeViewController ()


@property(nonatomic,strong)UILabel     * inputLabel;
@property(nonatomic,strong)UILabel     * passwordLabel;
@property(nonatomic,strong)WYPasswordInputView * inputView;
@property(nonatomic,strong)WYGradientButton    * nextButton;


@end

@implementation WYPasswordChangeViewController


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
    self.inputView.frame = CGRectMake(27.5, KNaviBarHeight+196, KScreenWidth-55, 50);
    self.nextButton.frame = CGRectMake(KScreenWidth/2-40, KScreenHeight-KTabbarSafeBottomMargin-95-80, 80, 80);
    self.nextButton.style = WYGradientButtonCircle;
}


-(UILabel*)inputLabel
{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]init];
        _inputLabel.text = @"更改密码";
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

-(WYGradientButton*)nextButton
{
    if (!_nextButton) {
        _nextButton = [WYGradientButton buttonWithType:UIButtonTypeCustom];
        
        @weakify(self);
        [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            
            if ([[self.inputView inputText] isValidPassword] ) {
                
                [self changePassword];
                
            }else
                
            {
                if (IsStrEmpty([self.inputView inputText])) {
                    [self.view makeToast:@"请设置密码" duration:3.0 position:CSToastPositionTop];
                    UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleMedium];
                    [impactLight impactOccurred];
                }else
                {
                    [self.view makeToast:@"密码格式不正确" duration:3.0 position:CSToastPositionTop];
                    UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleMedium];
                    [impactLight impactOccurred];
                }
            }
            
        }];
    }
    return _nextButton;
}



-(void)changePassword
{

    NSDictionary * dict = @{@"phone":self.phone,@"zone_num":@"86",@"interface":@"Login@forgetPassword",@"step":@"2",@"password":[self.inputView inputText],@"code":self.code};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
      
        [self.view makeToast:@"修改成功"];
    
        __weak typeof(self)weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        });
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
         [self.view makeToast:@"修改失败"];
    };
}

-(void)gotoInfoViewController:(NSString*)uid
{
    WYInfoViewController * infoVc = [[WYInfoViewController alloc]init];
    infoVc.uid = uid;
    infoVc.phone = self.phone;
    [self.navigationController pushViewController:infoVc animated:YES];
}


@end
