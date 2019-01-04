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
@interface WYCommentHeader ()
@property(nonatomic,strong)UIView *sepLine;
@property(nonatomic,strong)UIImageView *avatarIV;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *timeStampLabel;
@property(nonatomic,strong)UILabel *friendLabel;
@property(nonatomic,strong)WYCopyLabel *messageTextLabel;
@property(nonatomic,assign)BOOL isExpandNow;
@property(nonatomic,assign)NSInteger headerSection;
@property(nonatomic,strong)WYJPPView *jggView;
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
    }
    return self;
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
    self.sepLine.frame = CGRectMake(20, self.height, KScreenWidth-20, 1);
}

-(UIImageView*)avatarIV
{
    if (!_avatarIV) {
        _avatarIV = [[UIImageView alloc]init];
        _avatarIV.layer.cornerRadius = 16;
        _avatarIV.layer.masksToBounds = YES;
        
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

-(UIButton*)likeBtn
{
    if (!_likeBtn) {
        _likeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        
    }
    return _likeBtn;
}

-(UIButton*)moreBtn
{
    if (!_moreBtn) {
        _moreBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"dynamic_more_btn"] forState:UIControlStateNormal];
    }
    return _moreBtn;
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
    }
    return _sepLine;
}


@end
