//
//  WYApplyView.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYApplyView.h"
#import "WYPanImageView.h"
@interface WYApplyView ()

@property(nonatomic,strong)UILabel     * timeLabel;
@property(nonatomic,strong)UILabel     * addLabel;
@property(nonatomic,strong)WYPanImageView * blueImageView;
@property(nonatomic,strong)WYPanImageView * redImageView;
@property(nonatomic,strong)UILabel     * infoLabel;
@property(nonatomic,weak)NSTimer * countDownTimer;
@property(nonatomic,assign)NSInteger seconds;

@end
@implementation WYApplyView


- (instancetype)init
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
 
        [self addSubview:self.timeLabel];
        [self addSubview:self.addLabel];
        [self addSubview:self.blueImageView];
        [self addSubview:self.redImageView];
        [self addSubview:self.infoLabel];
        
    }
    
    return self;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.timeLabel.frame = CGRectMake(KScreenWidth/2-38, 95+KNaviBarHeight, 76, 76);
    self.addLabel.frame = CGRectMake(KScreenWidth/2-95,CGRectGetMaxY(self.timeLabel.frame)+33, 190, 40);
    self.blueImageView.frame = CGRectMake(KScreenWidth/2-95,CGRectGetMaxY(self.addLabel.frame)+49.1,100, 100);
    self.redImageView.frame = CGRectMake(KScreenWidth/2-130,CGRectGetMaxY(self.addLabel.frame)+114, 100, 100);
    self.infoLabel.frame = CGRectMake(KScreenWidth/2+30,KScreenHeight-KTabbarSafeBottomMargin-138,132,20);
}
- (void)show
{
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self showAnimation];
    [self startTimer];
    
}
-(void)hide
{
    [self stopTimer];
    [self removeFromSuperview];
}
- (void)showAnimation
{
    
    self.timeLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.addLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.blueImageView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.redImageView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.infoLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.timeLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.addLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.blueImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.redImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.infoLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}


-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont fontWithName:TextFontName_Bold size:48];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.text = @"10s";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
    
}

-(UILabel*)addLabel
{
    if (!_addLabel) {
        _addLabel = [[UILabel alloc]init];
        _addLabel.textColor = [UIColor whiteColor];
        _addLabel.font = [UIFont fontWithName:TextFontName size:14];
        _addLabel.numberOfLines = 2;
        _addLabel.text = @"时间到了\n是否添加对方为好友继续聊天";
        _addLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addLabel;
}


-(WYPanImageView*)blueImageView
{
    if(!_blueImageView)
    {
        _blueImageView = [[WYPanImageView alloc]init];
        _blueImageView.image = [UIImage imageNamed:@"chat_apply_blue"];
    }
    return _blueImageView;
}


-(WYPanImageView*)redImageView
{
    if(!_redImageView)
    {
        _redImageView = [[WYPanImageView alloc]init];
        _redImageView.image = [UIImage imageNamed:@"chat_apply_red"];
    }
    return _redImageView;
}


-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _infoLabel.text = @"触碰之间，添加好友";
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
}

-(BOOL)isOverlap  //判断是否重叠
{
    return CGRectIntersectsRect(self.redImageView.frame, self.blueImageView.frame);
}


-(void)startTimer
{
    _seconds = 10;//180秒倒计时
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
    
}

-(void)stopTimer
{
    [_countDownTimer invalidate];
    _countDownTimer = nil;
}


-(void)timeFireMethod{
    _seconds--;
    NSString *strTime = [NSString stringWithFormat:@"%lds", (long)_seconds];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",strTime];
    self.timeLabel.userInteractionEnabled = NO;
    
    //更新进度条
    if(_seconds ==0){
        [_countDownTimer invalidate];
    }
}




@end
