//
//  WYGradientButton.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYGradientButton.h"

@implementation WYGradientButton


-(void)setStyle:(WYGradientButtonStyle)style
{
    _style = style;
    
    CAGradientLayer*gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor binaryColor: @"B83AF3"].CGColor, (__bridge id)[UIColor binaryColor:@"6950FB"].CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
   
    switch (style) {
        case WYGradientButtonCircle:
        {
            self.layer.cornerRadius = 40;
            [self setImage:[UIImage imageNamed:@"login_next_btn"] forState:UIControlStateNormal];

            [self bringSubviewToFront:self.imageView];
        }
            break;
            case WYGradientButtonRectangle:
        {
            self.layer.cornerRadius = 26.94;

        }
            break;
        default:
            break;
    }
    
    self.layer.masksToBounds = YES;

    
}

@end
