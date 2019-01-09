//
//  WYHomePageViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHomePageViewController.h"

#define kPulseAnimation @"kPulseAnimation"


@interface WYHomePageViewController ()

@property(nonatomic,strong)CAEmitterLayer *emitterLayer;

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
    [self initUI];
    
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
   
}

-(void)initUI
{
    [self.view.layer addSublayer:self.emitterLayer];
    [self animation];
    [self playChildren];
    [self playQuanQuan];
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"child"ofType:@"json"];
    NSArray *components = [filePath componentsSeparatedByString:@"/"];
    NSString * name = [components lastObject];
    LOTAnimationView * childAnimation = [LOTAnimationView animationNamed:name];
    childAnimation.contentMode = UIViewContentModeScaleAspectFit;
    childAnimation.frame = self.view.bounds;
    [self.view addSubview:childAnimation];
    childAnimation.loopAnimation = YES;
    [childAnimation play];
}



-(void)playQuanQuan
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"guagnquan"ofType:@"json"];
    NSArray *components = [filePath componentsSeparatedByString:@"/"];
    NSString * name = [components lastObject];
    LOTAnimationView * laAnimation = [LOTAnimationView animationNamed:name];
    laAnimation.contentMode = UIViewContentModeScaleAspectFit;
    laAnimation.frame = self.view.bounds;
    [self.view addSubview:laAnimation];
    laAnimation.loopAnimation = YES;
    [laAnimation play];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    @weakify(self);
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"tap");
        @strongify(self);
       // [laAnimation play];
//        if(self.delegate&&[self.delegate respondsToSelector:@selector(conversation)])
//        {
//            [self.delegate conversation];
//        }
    }];
    
    laAnimation.userInteractionEnabled = YES;
    [laAnimation addGestureRecognizer:tap];
   
    
}





@end
