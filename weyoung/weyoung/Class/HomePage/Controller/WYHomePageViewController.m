//
//  WYHomePageViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHomePageViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#define kPulseAnimation @"kPulseAnimation"


@interface WYHomePageViewController ()

@property(nonatomic,strong)UIImageView * bgIV;
@property(nonatomic,strong)CAEmitterLayer *emitterLayer;
@property(nonatomic,strong)UIImageView * quanquan;

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
    [self initUI];
    [self addNotification];
    
}

-(void)addNotification
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WYNotifacationUserInfoChange object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
        
        [self.rightButton yy_setImageWithURL:[NSURL URLWithString:[WYSession sharedSession].avatar] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
        
    }];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bgIV.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    self.quanquan.frame = CGRectMake(KScreenWidth/2-36, KScreenHeight-KTabbarSafeBottomMargin-37-72, 72, 72);
}

-(void)initUI
{
   
    [self.view.layer addSublayer:self.emitterLayer];
    [self animation];
    [self.view addSubview:self.bgIV];
    [self playChildren];
    [self.view addSubview:self.quanquan];
    [self.view bringSubviewToFront:self.customNavigationBar];

}



-(void)setNavigationConfig
{
    self.leftButton.x = 10;
    self.rightButton.y = 29+KNaviBarSafeBottomMargin;
    self.rightButton.width = 30;
    self.rightButton.height = 30;
    self.rightButton.layer.cornerRadius = 15;
    self.rightButton.layer.masksToBounds = YES;
    
    [self setNavTitle:@"Explore"];
 
    [self.leftButton setImage:[UIImage imageNamed:@"navi_dynamic_btn"] forState:UIControlStateNormal];
  
    [self.rightButton yy_setImageWithURL:[NSURL URLWithString:[WYSession sharedSession].avatar] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    
 
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
     
        [self gotoDynamic];
    }];
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    
        [self gotoPersonCenter];
    }];
    
}

-(void)matchUser
{
    self.quanquan.userInteractionEnabled = NO;
    
    [self.quanquan startAnimating];
    
    NSDictionary * dict = @{@"interface":@"Match@doMatch"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        self.quanquan.userInteractionEnabled = YES;
        [self.quanquan stopAnimating];
        
        if ([response count]==0) {
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [self.view makeToast:@"怎么会没有人？"];
        }
        
//        if(self.delegate&&[self.delegate respondsToSelector:@selector(conversation:)])
//        {
//            [self.delegate conversation:nil];
//        }
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
        self.quanquan.userInteractionEnabled = YES;
        
        [self.quanquan stopAnimating];
        
    };
}

-(void)gotoDynamic
{
   
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:0];
    }
}



-(void)gotoPersonCenter
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:2];
    }
}

-(UIImageView*)bgIV
{
    if (!_bgIV) {
        _bgIV = [[UIImageView alloc]init];
        NSString * iname = (KScreenHeight<812)?@"home_bg":@"home_bg_x";
        _bgIV.image = [UIImage imageNamed:iname];
        _bgIV.contentMode = UIViewContentModeScaleToFill;
    }
    return _bgIV;
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

-(void)playChildren
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"second_wait"ofType:@"json"];
    NSArray *components = [filePath componentsSeparatedByString:@"/"];
    NSString * name = [components lastObject];
    LOTAnimationView * childAnimation = [LOTAnimationView animationNamed:name];
    childAnimation.contentMode = UIViewContentModeScaleAspectFit;
    childAnimation.frame = self.view.bounds;
    [self.view addSubview:childAnimation];
    childAnimation.loopAnimation = YES;
    [childAnimation play];
}


-(UIImageView*)quanquan
{
    if (!_quanquan) {
        _quanquan = [[UIImageView alloc]init];
        _quanquan.image = [UIImage imageNamed:@"home_quanquan_0"];
        
        NSMutableArray * qa = [NSMutableArray array];
        
        for (int i = 0; i < 24; i ++) {
            
            NSString * qn = [NSString stringWithFormat:@"home_quanquan_%d",i];
            UIImage  * qi = [UIImage imageNamed:qn];
            [qa addObject:qi];
        }
        
        _quanquan.animationImages = qa;
        _quanquan.animationDuration = 1.0;
        _quanquan.animationRepeatCount = 0;
      
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            @strongify(self);
            
            [self matchUser];

         
        }];
        
        _quanquan.userInteractionEnabled = YES;
        [_quanquan addGestureRecognizer:tap];
        
    
    }
    return _quanquan;
}




@end
