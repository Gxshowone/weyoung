//
//  WYSignView.m
//  weyoung
//
//  Created by gongxin on 2019/1/15.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYSignView.h"
#import "NSString+Extension.h"
@interface WYSignView ()

@property(nonatomic,strong)UIImageView * bgImageView;
@property(nonatomic,strong)UIImageView * grassView;
@property(nonatomic,strong)UILabel * dayLabel;
@property(nonatomic,strong)UILabel * weekLabel;
@property(nonatomic,strong)UILabel * monthLabel;
@property(nonatomic,strong)UILabel * infoLabel;
@property(nonatomic,strong)UIButton * signButton;
@property(nonatomic,strong)LOTAnimationView * childAnimation;
@end
@implementation WYSignView

-(id)init{

    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        
        [self addSubview:self.bgImageView];
        [self addSubview:self.childAnimation];
        [self addSubview:self.dayLabel];
        [self addSubview:self.weekLabel];
        [self addSubview:self.monthLabel];
        [self addSubview:self.infoLabel];
        [self addSubview:self.signButton];
        [self addSubview:self.grassView];
        [self.childAnimation play];
        [self initData];

    }
    return self;
}

-(void)initData
{
    self.infoLabel.text = @"孤独本身没什么不好，让它不好的，是害怕孤独，今天很重要，今天的你也很重要";
    NSString * time = [NSString getNowTimeTimestamp];
    NSString * month =[NSString timeToMonth:time];
    NSString * year = [NSString timeToYear:time];
    NSString * my = [NSString stringWithFormat:@"%@%@",[NSString exchangeToEngMonth:month],year];
    self.monthLabel.text= my;
    self.dayLabel.text = [NSString timeToDay:time];
    self.weekLabel.text = [NSString weekdayStringFromDate:[NSDate date]];
//
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.frame= self.bounds;
    self.childAnimation.frame = self.bounds;
    self.dayLabel.frame = CGRectMake(25, KNaviBarHeight+7, 53, 62);
    self.weekLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame)+8.5, KNaviBarHeight+23, 42, 20);
    self.monthLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame)+4.5, CGRectGetMaxY(self.weekLabel.frame), 50, 14);
    self.infoLabel.frame = CGRectMake(25, 127+KNaviBarHeight, KScreenWidth-50, 84);
    self.signButton.frame = CGRectMake(KScreenWidth/2-75, CGRectGetMaxY(self.infoLabel.frame), 150, 40);
    self.grassView.frame =  CGRectMake(0, KScreenHeight-125, 211, 125);
    
}

-(UILabel*)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont fontWithName:TextFontName_Light size:44];
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
    
}

-(UILabel*)weekLabel
{
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc]init];
        _weekLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _weekLabel.textColor = [UIColor whiteColor];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weekLabel;
    
}

-(UILabel*)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.font = [UIFont fontWithName:TextFontName size:10];
        _monthLabel.textColor = [UIColor whiteColor];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
    
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.numberOfLines= 2;
    }
    return _infoLabel;
    
}

-(UIButton*)signButton
{
    if (!_signButton) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signButton.layer.masksToBounds = YES;
        _signButton.layer.borderWidth = 0.5;
        _signButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _signButton.layer.cornerRadius = 20;
        [_signButton setTitle:@"晚安签到" forState:UIControlStateNormal];
        _signButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        [_signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self);
        [[_signButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
        
            [self remoteSign];
            self.signButton.userInteractionEnabled = NO;
            NSString * fname = (KScreenHeight<812)?@"first_walk":@"first_walk_x";
            NSString *filePath = [[NSBundle mainBundle] pathForResource:fname ofType:@"json"];
            NSArray *components = [filePath componentsSeparatedByString:@"/"];
            NSString * name = [components lastObject];
            [self.childAnimation setAnimation:name];
            [self.childAnimation play];
            [self backToHomePage];
        }];
    }
    return _signButton;
    
}

-(void)remoteSign
{

    NSDictionary * dict = @{@"interface":@"User@signIn"};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
    };
    
}

-(void)backToHomePage
{
    __weak typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        weakSelf.signButton.userInteractionEnabled = YES;
        if (weakSelf.delegate) {
            [weakSelf.delegate signHide];
        }
        [weakSelf removeFromSuperview];
    
    });
    
   
}

-(UIImageView*)bgImageView
{
    if (!_bgImageView) {
        _bgImageView= [[UIImageView alloc]init];
        NSString * iname = (IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES)?@"home_sign_bg_iphonex":@"home_sign_bg";
        _bgImageView.image = [UIImage imageNamed:iname];
        
    }
    return _bgImageView;
}

-(UIImageView*)grassView
{
    if(!_grassView)
    {
        _grassView = [[UIImageView alloc]init];
        _grassView.image = [UIImage imageNamed:@"home_sign_grass"];
    }
    return _grassView;
}

-(LOTAnimationView *)childAnimation
{
    if (!_childAnimation) {
        
        NSString * fname = (KScreenHeight<812)?@"first_wait":@"first_wait_x";
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fname ofType:@"json"];
        NSArray *components = [filePath componentsSeparatedByString:@"/"];
        NSString * name = [components lastObject];
        _childAnimation = [LOTAnimationView animationNamed:name];
        _childAnimation.contentMode = UIViewContentModeScaleAspectFit;
        _childAnimation.loopAnimation = YES;
      
    }
    return _childAnimation;
}


@end
