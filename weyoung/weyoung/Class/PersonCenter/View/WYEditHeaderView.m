//
//  WYEditHeaderView.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYEditHeaderView.h"

@interface WYEditHeaderView()

@property(nonatomic,strong)UIButton * avatarButton;
@property(nonatomic,strong)UILabel  * alertLabel;

@end
@implementation WYEditHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.avatarButton];
        [self addSubview:self.alertLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarButton.frame = CGRectMake(KScreenWidth/2-45, 16, 90, 90);
    self.alertLabel.frame = CGRectMake(KScreenWidth/2-44, CGRectGetMaxY(self.avatarButton.frame)+10.8, 88, 26);
    
}


-(UIButton*)avatarButton
{
    if (!_avatarButton) {
        _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_avatarButton setImage:[UIImage imageNamed:@"login_pic_btn"] forState:UIControlStateNormal];
        
        @weakify(self);
        [[_avatarButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
       
            
        }];
    }
    return _avatarButton;
}

-(UILabel*)alertLabel
{
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc]init];
        _alertLabel.text = @"点击更换头像";
        _alertLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.font = [UIFont fontWithName:TextFontName size:14];
    }
    return _alertLabel;
}


@end
