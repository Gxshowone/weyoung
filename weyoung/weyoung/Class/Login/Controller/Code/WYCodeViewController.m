//
//  WYCodeViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYCodeViewController.h"
#import "WLUnitField.h"
#import "WYPassWordViewController.h"
@interface WYCodeViewController ()<WLUnitFieldDelegate>

@property(nonatomic,strong)UILabel     * inputLabel;
@property(nonatomic,strong)UILabel     * phoneLabel;
@property(nonatomic,strong)WLUnitField * unitField;
@property(nonatomic,strong)UIButton    * sendButton;


@end

@implementation WYCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.inputLabel];
    [self.view addSubview:self.phoneLabel];
    [self.view addSubview:self.unitField];
    [self.view addSubview:self.sendButton];
    [self startTime];
}

-(void)startTime{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.sendButton setTitle:@"重新发送" forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = YES;
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2ds后重新发送", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.sendButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                self.sendButton.userInteractionEnabled = NO;
         
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.inputLabel.frame = CGRectMake(KScreenWidth/2-61.5, KNaviBarHeight+66, 123, 33);
    self.phoneLabel.frame = CGRectMake(KScreenWidth/2-87, CGRectGetMaxY(self.inputLabel.frame)+10,174, 20);
    
    CGFloat uw = KScreenWidth-135;
    self.unitField.frame = CGRectMake(KScreenWidth/2-uw/2, CGRectGetMaxY(self.phoneLabel.frame)+50,uw, 55);
    
    CGFloat sy = KScreenHeight - KTabbarSafeBottomMargin- 278;
    self.sendButton.frame = CGRectMake(KScreenWidth/2-50,sy,100,44);
    
    
}


-(void)unitFieldEditingChanged:(WLUnitField *)sender
{
    if (sender.text.length == 4) {
        [self.navigationController pushViewController:[WYPassWordViewController new] animated:YES];
    }
}

-(UILabel*)inputLabel
{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]init];
        _inputLabel.text = @"输入验证码";
        _inputLabel.font = [UIFont fontWithName:TextFontName_Light size:24];
        _inputLabel.textAlignment = NSTextAlignmentCenter;
        _inputLabel.textColor = [UIColor binaryColor:@"FFFFFF"];
    }
    return _inputLabel;
}

-(UILabel*)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        _phoneLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
    }
    return _phoneLabel;
}

-(WLUnitField*)unitField
{
    if (!_unitField) {
        _unitField = [[WLUnitField alloc]initWithInputUnitCount:4];
        _unitField.unitSpace = 20;
        _unitField.borderRadius = 8;
        _unitField.textColor = [UIColor binaryColor:@"FFFFFF"];
        _unitField.tintColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.3];
        _unitField.trackTintColor = [UIColor binaryColor:@"6060FC"];
        _unitField.cursorColor = [UIColor binaryColor:@"6060FC"];
        [_unitField sizeToFit];
        [_unitField addTarget:self action:@selector(unitFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        [_unitField becomeFirstResponder];
        
    }
    return _unitField;

}

-(UIButton*)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
      
        [_sendButton setTitleColor:[[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        
        @weakify(self);
        [[_sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
        
        }];
    }
    return _sendButton;
}

-(void)setPhone:(NSString *)phone
{
    _phone = phone;
    
    self.phoneLabel.text =  [NSString stringWithFormat:@"已发送至+86%@",phone];
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
