//
//  WYExcessiveView.m
//  weyoung
//
//  Created by gongxin on 2019/1/15.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYExcessiveView.h"
@interface WYExcessiveView ()

@property(nonatomic,strong)CAEmitterLayer *emitterLayer;
@property(nonatomic,strong)UIImageView * moonView;
@end

@implementation WYExcessiveView

-(id)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [self.layer addSublayer:self.emitterLayer];
        [self addSubview:self.moonView];
        [self animation];
    }
    return self;
}

-(CAEmitterLayer *)emitterLayer
{
    UIImage * image = [self imageWithColor:[UIColor whiteColor]];
    CAEmitterCell *subCell = [self cellWithImage:image];
    subCell.name = @"white";
    
    _emitterLayer = [CAEmitterLayer layer];
    _emitterLayer.emitterPosition = self.center;
    _emitterLayer.emitterSize    = self.bounds.size;
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
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.moonView.center = self.center;
    self.moonView.width = 194;
    self.moonView.height =305;
}

-(UIImageView*)moonView
{
    if (!_moonView) {
        _moonView= [[UIImageView alloc]init];
        NSMutableArray * ar = [NSMutableArray array];
        for (int i = 0; i < 24; i ++) {
            
            NSString * mn = [NSString stringWithFormat:@"home_excessive_moon_%d",i];
            UIImage  * mi = [UIImage imageNamed:mn];
            [ar addObject:mi];
        }
        
        _moonView.animationImages =ar;
        _moonView.animationDuration = 2.0;
        _moonView.animationRepeatCount = 0;
        [_moonView startAnimating];
        
    }
    return _moonView;
}

@end
