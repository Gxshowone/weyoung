//
//  WYCommentHeader.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCommentHeader.h"
#import "WYCopyLabel.h"
#import "WYJPPView.h"
#import "NSString+Extension.h"
@interface WYCommentHeader ()<CAAnimationDelegate>
@property(nonatomic,strong)UIView *sepLine;
@property(nonatomic,strong)UIImageView *avatarIV;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *timeStampLabel;
@property(nonatomic,strong)UILabel *friendLabel;
@property(nonatomic,strong)WYCopyLabel *messageTextLabel;
@property(nonatomic,assign)BOOL isExpandNow;
@property(nonatomic,assign)NSInteger headerSection;
@property(nonatomic,strong)WYJPPView *jggView;
@property(nonatomic,strong)UILabel * addLabel;
@property(nonatomic,strong)UILabel * commentLabel;

@end
@implementation WYCommentHeader

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.avatarIV];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.timeStampLabel];
        [self addSubview:self.friendLabel];
        [self addSubview:self.likeBtn];
        [self addSubview:self.moreBtn];
        [self addSubview:self.messageTextLabel];
        [self addSubview:self.jggView];
        [self addSubview:self.sepLine];
        [self addSubview:self.addLabel];
        [self addSubview:self.commentLabel];
    }
    return self;
}

-(void)setModel:(WYDynamicModel *)model
{
    _model = model;
    
    [self.avatarIV yy_setImageWithURL:[NSURL URLWithString:model.header_url] options:0];
    self.userNameLabel.text = [NSString stringWithFormat:@"%@",model.nick_name];
    
    NSString * time = [NSString timeIntervaltoString:model.create_time];
    self.timeStampLabel.text = [NSString inputTimeStr:time withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSString * image = [NSString stringWithFormat:@"%@",model.image];
    self.jggView.dataSource = @[image];

    self.messageTextLabel.attributedText = model.attributedText;
    self.messageTextLabel.frame = model.textLayout.frameLayout;
    
    ///解决图片复用问题
    [self.jggView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.jggView.dataSource = @[model.image];
    self.jggView.frame = model.jggLayout.frameLayout;
    
    self.sepLine.frame = CGRectMake(20, CGRectGetMaxY(self.jggView.frame)+20, KScreenWidth-20, 1);
    self.commentLabel.frame = CGRectMake(20,CGRectGetMaxY(self.sepLine.frame), KScreenWidth-40, 60);
   
    self.friendLabel.hidden = ([[WYSession sharedSession].friendArray containsObject:model.uid])?NO:YES;
    
    NSMutableArray * likeArray = [[WYSession sharedSession].likeArray mutableCopy];
    [self setIsLike:[likeArray containsObject:model.d_id]];
    
}

-(void)setIsLike:(BOOL)isLike
{
    _isLike = isLike;
    
    NSString * likeIN = (isLike==NO)?@"dynamic_like_btn":@"dynamic_like_select_btn";
    [self.likeBtn setImage:[UIImage imageNamed:likeIN] forState:UIControlStateNormal];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarIV.frame = CGRectMake(20, 17.4, 32, 32);
    self.userNameLabel.frame = CGRectMake(67, 12.3, 120, 27);
    self.timeStampLabel.frame = CGRectMake(67, 31.4, 100, 27);
    self.friendLabel.frame = CGRectMake(CGRectGetMaxX(self.userNameLabel.frame)+5, 18, 30, 14);
    self.likeBtn.frame = CGRectMake(KScreenWidth-88, 0, 44, 44);
    self.moreBtn.frame = CGRectMake(KScreenWidth-44, 0, 44, 44);
    self.sepLine.frame = CGRectMake(20, self.height-60, KScreenWidth-20, 1);
    self.commentLabel.frame = CGRectMake(20,CGRectGetMaxY(self.sepLine.frame), KScreenWidth-40, 60);
}


- (void)addZanAnimation
{
    //关键帧动画
    //用动画完成放大的效果
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //需要给他设置一个关键帧的值,这个值就是变化过程
    //values是一个数组
    animation.values=@[@(0.5),@(1.0),@(1.5)];
    //设置动画的时长
    animation.duration=0.2;
    //加到button上
    [self.likeBtn.layer addAnimation:animation forKey:@"animation"];
    
    NSString * likeIN = @"dynamic_like_select_btn";
    [self.likeBtn setImage:[UIImage imageNamed:likeIN] forState:UIControlStateNormal];
    
    self.likeBtn.alpha = 1;
    CAKeyframeAnimation *animation2=[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //需要给他设置一个关键帧的值,这个值就是变化过程
    //values是一个数组
    animation2.values=@[@(0.4),@(0.6),@(1.0),@(1.4)];
    //设置动画的时长
    animation2.duration=0.4;
    animation2.delegate = self;
    //加到button上
    [self.likeBtn.layer addAnimation:animation2 forKey:@"animation"];
    
    
    
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    //clearMemory
    //结束事件
    
    self.addLabel.alpha = 0;
    
}

-(UIImageView*)avatarIV
{
    if (!_avatarIV) {
        _avatarIV = [[UIImageView alloc]init];
        _avatarIV.layer.cornerRadius = 16;
        _avatarIV.layer.masksToBounds = YES;
        _avatarIV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            @strongify(self);
            if (self.delegate) {
                [self.delegate gotoOtherCenter:self.model];
            }
        }];
        [_avatarIV addGestureRecognizer:tap];

    }
    return _avatarIV;
}

-(UILabel*)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        _userNameLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _userNameLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _userNameLabel;
}

-(UILabel*)friendLabel
{
    if (!_friendLabel) {
        _friendLabel = [[UILabel alloc]init];
        _friendLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        _friendLabel.layer.cornerRadius = 4;
        _friendLabel.layer.masksToBounds = YES;
        _friendLabel.text = @"朋友";
        _friendLabel.font = [UIFont fontWithName:TextFontName_Medium size:9];
        _friendLabel.textColor = [UIColor blackColor];
        _friendLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _friendLabel;
}

-(UILabel*)timeStampLabel
{
    if (!_timeStampLabel) {
        _timeStampLabel = [[UILabel alloc]init];
        _timeStampLabel.font = [UIFont fontWithName:TextFontName_Light size:10];
        _timeStampLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        _timeStampLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeStampLabel;
}


-(UIButton*)moreBtn
{
    if (!_moreBtn) {
        _moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"dynamic_more_btn"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            
            if (self.delegate) {
                [self.delegate moreDynamic:self.model];
            }
            
        }];
    }
    return _moreBtn;
}

-(UIButton*)likeBtn
{
    if (!_likeBtn) {
        _likeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
        @weakify(self);
        [[_likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            if (self.isLike==YES) {
                return ;
            }
            
            [self addZanAnimation];
            
            
            NSMutableArray * array = [NSMutableArray array];
            [array addObjectsFromArray:[WYSession sharedSession].likeArray];
            if ([array containsObject:self.model.d_id]==NO) {
                [array addObject:self.model.d_id];
            }
            [WYSession sharedSession].likeArray = array;
            
            self.isLike = YES;
            
            if (self.delegate) {
                [self.delegate likeDynamic:self.model];
            }
        }];
    }
    return _likeBtn;
}

-(WYCopyLabel*)messageTextLabel
{
    if(!_messageTextLabel)
    {
        _messageTextLabel = [[WYCopyLabel alloc]init];
    }
    return _messageTextLabel;
}

-(WYJPPView*)jggView
{
    if (!_jggView) {
        _jggView = [[WYJPPView alloc]init];
    }
    return _jggView;
}

-(UIView*)sepLine
{
    if (!_sepLine) {
        _sepLine = [[UIView alloc]init];
        _sepLine.backgroundColor = [[UIColor binaryColor:@"ffffff"] colorWithAlphaComponent:0.1];
    }
    return _sepLine;
}


-(UILabel*)commentLabel
{
    if (!_commentLabel) {
       
        _commentLabel = [[UILabel alloc]init];
        _commentLabel.text = @"评论";
        _commentLabel.textColor = [UIColor whiteColor];
        _commentLabel.font = [UIFont fontWithName:TextFontName size:18];
    
    }
    return _commentLabel;
}

@end
