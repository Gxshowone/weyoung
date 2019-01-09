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
#import "WYInputViewController.h"
#import "WYGradientButton.h"
#import "NSString+Validation.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WYInfoViewController.h"
@interface WYLoginViewController ()

@property(nonatomic,strong)CAEmitterLayer *emitterLayer;
@property(nonatomic,strong)UIImageView * logoImageView;
@property(nonatomic,strong)WYPhoneInputView * phoneInputView;
@property(nonatomic,strong)UILabel * infoLabel;
@property(nonatomic,strong)UIButton * clauseButton;
@property(nonatomic,strong)WYGradientButton * loginButton;

@end

@implementation WYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer:self.emitterLayer];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.phoneInputView];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.clauseButton];
    [self.view addSubview:self.loginButton];
    [self animation];
    self.leftButton.hidden = YES;
 
}



-(CAEmitterLayer *)emitterLayer
{
    UIImage * image = [self imageWithColor:[UIColor whiteColor]];
    CAEmitterCell *subCell = [self cellWithImage:image];
    subCell.name = @"white";
    
    _emitterLayer = [CAEmitterLayer layer];
    _emitterLayer.emitterPosition = self.view.center;
    _emitterLayer.emitterSize    = self.view.bounds.size;
    _emitterLayer.emitterMode    = kCAEmitterLayerVolume;
    _emitterLayer.emitterShape    = kCAEmitterLayerSphere;
    _emitterLayer.renderMode        = kCAEmitterLayerOldestFirst;
    _emitterLayer.emitterCells = @[subCell];
    return _emitterLayer;
}

-(UIImage*)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0,1,1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(CAEmitterCell *)cellWithImage:(UIImage*)image
{
    
    CAEmitterCell * cell = [CAEmitterCell emitterCell];

    
    cell.name = @"heart";
    cell.contents = (__bridge id _Nullable)image.CGImage;
    
    // 缩放比例
    cell.scale      = 0.6;
    cell.scaleRange = 0.6;
    // 每秒产生的数量
    cell.birthRate  = 10;
    cell.lifetime   = 30;
    // 每秒变透明的速度
    //    snowCell.alphaSpeed = -0.7;
    //    snowCell.redSpeed = 0.1;
    // 秒速
    cell.velocity      = 50;
    cell.velocityRange = 200;
    cell.yAcceleration = 9.8;
    cell.xAcceleration = 0.0;
    //掉落的角度范围
    cell.emissionRange  = M_PI;
    
    cell.scaleSpeed        = -0.05;
    ////    cell.alphaSpeed        = -0.3;
    cell.spin            = 2 * M_PI;
    cell.spinRange        = 2 * M_PI;
    
    return cell;
}

-(void)animation
{
    
    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.blue.birthRate"];
    burst.fromValue        = [NSNumber numberWithFloat:30];
    burst.toValue            = [NSNumber numberWithFloat:  0.0];
    burst.duration        = 0.5;
    burst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CABasicAnimation *starBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.star.birthRate"];
    starBurst.fromValue        = [NSNumber numberWithFloat:30];
    starBurst.toValue            = [NSNumber numberWithFloat:  0.0];
    starBurst.duration        = 0.5;
    starBurst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[burst];
    
    [self.emitterLayer addAnimation:group forKey:@"heartsBurst"];
}


-(void)checkUser
{
    NSDictionary * dict = @{@"phone":[self.phoneInputView inputText],@"zone_num":@"86",@"interface":@"Login@checkUser"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        NSInteger  register_status = [[response valueForKey:@"register_status"] integerValue];
        NSString * uid = [NSString stringWithFormat:@"%@",[response valueForKey:@"uid"]];
        switch (register_status) {
            case 0:
            {
                [self sendCode];
                [self gotoCodeViewController];
            }
                break;
                case 1:
            {
                [self gotoInfoViewController:uid];
                
            }
                break;
                case 2:
            {
                [self gotoInputViewController];
            }
                break;
            default:
                break;
        }
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
   
    
}

-(void)sendCode
{
    NSDictionary * dict = @{@"phone":[self.phoneInputView inputText],@"zone_num":@"86",@"interface":@"Login@register",@"step":@"1"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
}

-(void)gotoCodeViewController
{
    WYCodeViewController * codeVc = [[WYCodeViewController alloc]init];
    codeVc.phone = [self.phoneInputView inputText];
    codeVc.type = WYCodeTypeReg;
    [self.navigationController pushViewController:codeVc animated:YES];
    
}

-(void)gotoInfoViewController:(NSString*)uid
{
    WYInfoViewController * infoVc = [[WYInfoViewController alloc]init];
    infoVc.uid = uid;
    infoVc.phone = [self.phoneInputView inputText];
    [self.navigationController pushViewController:infoVc animated:YES];
}

-(void)gotoInputViewController
{
    WYInputViewController * inputVc = [WYInputViewController new];
    inputVc.phone =[self.phoneInputView inputText];
    [self.navigationController pushViewController:inputVc animated:YES];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.logoImageView.frame = CGRectMake(KScreenWidth/2-20/5, 23+KNaviBarHeight, 41, 87);
    self.phoneInputView.frame = CGRectMake(27.5,KNaviBarHeight+196, KScreenWidth-55, 50);
    self.infoLabel.frame = CGRectMake((KScreenWidth -287)/2, CGRectGetMaxY(self.phoneInputView.frame)+15, 172, 20);
    self.clauseButton.frame = CGRectMake(CGRectGetMaxX(self.infoLabel.frame)+3, CGRectGetMaxY(self.phoneInputView.frame)+3,115, 44);
    self.loginButton.frame = CGRectMake(KScreenWidth/2-40, KScreenHeight-KTabbarSafeBottomMargin-95-80, 80, 80);
    self.loginButton.style = WYGradientButtonCircle;
}


-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
        _logoImageView.image = [UIImage imageNamed:@"login_logo"];
    }
    return _logoImageView;
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
    
        }];
    }
    return _clauseButton;
}



-(WYGradientButton*)loginButton
{
    if (!_loginButton) {
        _loginButton = [WYGradientButton buttonWithType:UIButtonTypeCustom];
        @weakify(self);
        [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"[gx] login click");
            if ([[self.phoneInputView inputText] isValidPhone]) {
                
                [self checkUser];
                
            }else
                
            {
                if ([[self.phoneInputView inputText] isEmpty]) {
                    [self.view makeToast:@"请输入手机号" duration:3.0 position:CSToastPositionTop];
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }else
                {
                    [self.view makeToast:@"手机号格式不正确" duration:3.0 position:CSToastPositionTop];
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                }
            }
            
            
        }];
    }
    return _loginButton;
}



@end
