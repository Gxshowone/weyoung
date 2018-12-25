//
//  WYProgressView.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYProgressView.h"
@interface WYProgressView ()

@property(nonatomic,strong)CAGradientLayer* gradientLayer;

@end
@implementation WYProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor binaryColor:@"21272E"];
        [self.layer addSublayer:self.gradientLayer];
    }
    
    return self;
}



-(void)updateProgress:(float)progress
{
    self.gradientLayer.frame = CGRectMake(0, 0, self.width*progress, 3);
}

-(CAGradientLayer*)gradientLayer
{
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor binaryColor: @"6950FB"].CGColor, (__bridge id)[UIColor binaryColor:@"34A9FF"].CGColor];
        _gradientLayer.locations = @[@0.0, @1.0];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1, 0);
        _gradientLayer.frame = self.bounds;
    }
    return _gradientLayer;
}




@end
