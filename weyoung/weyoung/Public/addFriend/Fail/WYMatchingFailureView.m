//
//  WYMatchingFailureView.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYMatchingFailureView.h"
@interface WYMatchingFailureView ()

@property(nonatomic,strong)UIImageView * heartImageView;
@property(nonatomic,strong)UILabel     * infoLabel;

@end
@implementation WYMatchingFailureView

- (instancetype)init
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
        [self addSubview:self.heartImageView];
        [self addSubview:self.infoLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            @strongify(self);
            
            [self hide];
        }];
        
        [self addGestureRecognizer:tap];
   
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.heartImageView.frame = CGRectMake(KScreenWidth/2-30, 107+KNaviBarHeight, 60, 53.6);
    self.infoLabel.frame = CGRectMake(KScreenWidth/2-95, CGRectGetMaxY(self.heartImageView.frame)+15.3, 190, 40);
}
- (void)show
{
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self showAnimation];
    
}
-(void)hide
{
    if (self.delegate) {
        [self.delegate endChat];
    }
    [self removeFromSuperview];
}
- (void)showAnimation
{
    
    self.heartImageView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.infoLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.heartImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.infoLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}

-(UIImageView*)heartImageView
{
    if(!_heartImageView)
    {
        _heartImageView = [[UIImageView alloc]init];
        _heartImageView.image = [UIImage imageNamed:@"match_fail_heart"];
    }
    return _heartImageView;
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont fontWithName:TextFontName size:14];
        _infoLabel.numberOfLines = 2;
        _infoLabel.text = @"很遗憾\n没有匹配成功，相忘于江湖吧";
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}

@end
