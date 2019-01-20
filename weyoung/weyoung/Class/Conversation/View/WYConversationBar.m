//
//  WYConversationBar.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYConversationBar.h"
#import "WYProgressView.h"
#import "WYMoreView.h"
@interface WYConversationBar ()

@property(nonatomic,strong)RCUserInfo * user;
@property(nonatomic,strong)WYMoreView * moreView;
@property(nonatomic,strong)WYProgressView * progressView;
@property(nonatomic,strong)UIButton * timerButton;
@property(nonatomic,strong)UIButton * moreButton;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,weak)NSTimer * countDownTimer;
@property(nonatomic,assign)NSInteger seconds;

@end

@implementation WYConversationBar
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backButton];
        [self addSubview:self.titleLabel];
        [self addSubview:self.timerButton];
        [self addSubview:self.moreButton];
        [self addSubview:self.progressView];
    
    }
    return self;
}



-(void)dealloc
{
    [self stopTimer];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.timerButton.frame = CGRectMake(KScreenWidth-120, 20+KNaviBarSafeBottomMargin, 70,50);
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
    [self.timerButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
    self.timerButton.userInteractionEnabled = NO;
    
    //更新进度条
    float total = 180.00;
    float current = [[NSNumber numberWithInteger:_seconds] floatValue];
    float progress =current/total;
    [self.progressView updateProgress:progress];
    
    if(_seconds ==0){
        [_countDownTimer invalidate];
        
        if(self.delegate)
        {
            [self.delegate stopConversation];
        }
    }
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.frame = CGRectMake(100,20+KNaviBarSafeBottomMargin,KScreenWidth-200, 44);
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:TextFontName size:16];
        _titleLabel.adjustsFontSizeToFitWidth =YES;
        _titleLabel.minimumScaleFactor = 0.4;
    }
    return _titleLabel;
}

-(UIButton*)timerButton
{
    if (!_timerButton) {
        _timerButton = [[UIButton alloc]init];
        [_timerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _timerButton.titleLabel.font = [UIFont fontWithName:TextFontName_Medium size:16];
        _timerButton.titleLabel.textAlignment = NSTextAlignmentRight;
        
        @weakify(self);
        [[_timerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.isFriend==NO) {
                return ;
            }
            
        }];
    }
    return _timerButton;
}


-(UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.titleLabel.font = [UIFont fontWithName:TextFontName size:16.0];
        [_backButton setFrame:CGRectMake(0, 20+KNaviBarSafeBottomMargin, 48, 50)];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_backButton setImage:[UIImage imageNamed:@"navi_back_btn"] forState:UIControlStateNormal];
    
    }
    return _backButton;
}



-(UIButton*)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setFrame:CGRectMake(KScreenWidth-48,20+KNaviBarSafeBottomMargin,48,50)];
        _moreButton.titleLabel.font = [UIFont fontWithName:TextFontName_Medium size:16.0];
        [_moreButton setTitleColor:[UIColor binaryColor:@"6060FC"] forState:UIControlStateNormal];
        _moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_moreButton setImage:[UIImage imageNamed:@"navi_more_btn"] forState:UIControlStateNormal];
        @weakify(self);
        [[_moreButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.moreView show];
            self.moreView.user = self.user;
        }];
    }
    
    return _moreButton;
}

-(WYProgressView*)progressView
{
    if (!_progressView) {
        _progressView = [[WYProgressView alloc]init];
        _progressView.frame = CGRectMake(0, KNaviBarHeight, KScreenWidth, 3);
    }
    return _progressView;
}

-(WYMoreView*)moreView
{
    if (!_moreView) {
        
        _moreView = [[WYMoreView alloc]initWithSuperView:self.superview
                                             animationTravel:0.3
                                                  viewHeight:160+KTabbarSafeBottomMargin];
        _moreView.type =  WYMoreViewType_Conversation;
      
    }
    return _moreView;
}

-(void)updateTitle:(NSString*)title
{
    self.titleLabel.text = title;
    
}

-(void)setIsFriend:(BOOL)isFriend
{
    _isFriend = isFriend;
    
   // self.moreView.isFriend =isFriend;
    
    if (!isFriend) {
        
        [self startTimer];
    }else
    {
        [self.timerButton setTitle:@"解除好友" forState:UIControlStateNormal];
    }
}

-(void)setMoreUser:(RCUserInfo*)user
{
    _user = user;
}
@end
