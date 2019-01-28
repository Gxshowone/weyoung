//
//  WYApplyView.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYApplyView.h"
#import <AudioToolbox/AudioToolbox.h>
@interface WYApplyView ()

@property(nonatomic,strong)UILabel     * timeLabel;
@property(nonatomic,strong)UILabel     * addLabel;
@property(nonatomic,strong)UIImageView * matchImageView;
@property(nonatomic,strong)UILabel     * infoLabel;
@property(nonatomic,weak)NSTimer * countDownTimer;
@property(nonatomic,assign)NSInteger seconds;

@property(nonatomic,assign)BOOL request;

@end
@implementation WYApplyView


- (instancetype)init
{
    if (self == [super init]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
 
        [self addSubview:self.timeLabel];
        [self addSubview:self.addLabel];
        [self addSubview:self.matchImageView];
        [self addSubview:self.infoLabel];
        
    }
    
    return self;
}

-(void)applyFriend
{
    _request = YES;

    [self.matchImageView stopAnimating];
    self.matchImageView.image = [UIImage imageNamed:@"match_loading_0"];
    
    NSString * to_uid  = self.userInfo.userId;
    NSDictionary * dict = @{@"interface":@"Friend@addFriend",@"to_uid":to_uid};
    WYHttpRequest *request = [[WYHttpRequest alloc]init];
    [request requestWithPragma:dict showLoading:NO];
    request.successBlock = ^(id  _Nonnull response) {
        
        [self applySusscessAnimation];
        [self applySusscess];
 
    };
    
    request.failureDataBlock = ^(id  _Nonnull error) {
        
        [self.matchImageView stopAnimating];
        
        [self hide];
        
        
        if(self.delegate)
        {
            [self.delegate addFriendFail];
        }
   
        self->_request = NO;
        UIImpactFeedbackGenerator*impactLight = [[UIImpactFeedbackGenerator alloc]initWithStyle:UIImpactFeedbackStyleMedium];
        [impactLight impactOccurred];
    };

}

-(void)applySusscessAnimation
{
    NSMutableArray * asa = [NSMutableArray array];
    
    for (int i = 0; i < 29; i ++) {
        
        NSString * asn = [NSString stringWithFormat:@"match_sussces_%d",i];
        UIImage  * asi = [UIImage imageNamed:asn];
        [asa addObject:asi];
    }
    
    self.matchImageView.animationImages = asa;
    self.matchImageView.animationDuration = 2.0;
    self.matchImageView.animationRepeatCount = 1;
    [self.matchImageView startAnimating];
    
}


-(void)applySusscess
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        
        [self hide];
        
        if(self.delegate)
        {
            [self.delegate addFriendSussces];
        }
        
        self->_request = NO;
    });
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.timeLabel.frame = CGRectMake(KScreenWidth/2-38, 95+KNaviBarHeight, 76, 76);
    self.addLabel.frame = CGRectMake(KScreenWidth/2-95,CGRectGetMaxY(self.timeLabel.frame)+33, 190, 40);
    self.matchImageView.frame = CGRectMake(KScreenWidth/2-75,KScreenHeight/2+25,150, 150);
    self.infoLabel.frame = CGRectMake(KScreenWidth/2-66,KScreenHeight-KTabbarSafeBottomMargin-138,132,20);
    
    
}
- (void)show
{
    _request =  NO;
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self showAnimation];
    [self startTimer];
    
}
-(void)hide
{
    _request = NO;
    [self stopTimer];
    [self removeFromSuperview];
}
- (void)showAnimation
{
    
    self.timeLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.addLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.matchImageView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    self.infoLabel.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.timeLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.addLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.matchImageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
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

-(UIImageView*)matchImageView
{
    if (!_matchImageView) {
        _matchImageView = [[UIImageView alloc]init];
        NSMutableArray * ma = [NSMutableArray array];
        
        for (int i = 0; i < 32; i ++) {
            
            NSString * mn = [NSString stringWithFormat:@"match_loading_%d",i];
            UIImage  * mi = [UIImage imageNamed:mn];
            [ma addObject:mi];
        }
        
        _matchImageView.animationImages = ma;
        _matchImageView.animationDuration = 2.0;
        _matchImageView.animationRepeatCount = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            @strongify(self);
            
            if (self->_request==YES) {
                return ;
            }
            [self applyFriend];
        }];
        
        _matchImageView.userInteractionEnabled = YES;
        [_matchImageView addGestureRecognizer:tap];
        [self.matchImageView startAnimating];
        
        
    }
    return _matchImageView;
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
    

    if(_seconds ==0){
        [_countDownTimer invalidate];
        
        if (_request==NO) {
            [self hide];
            [self.delegate addFriendFail];
        }
    }
}


-(void)setUserInfo:(RCUserInfo *)userInfo
{
    _userInfo = userInfo;
}

@end
