//
//  WYMessageNaviBar.m
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYMessageNaviBar.h"
@interface WYMessageNaviBar ()

@property(nonatomic,strong)UILabel * titleLabel;

@end
@implementation WYMessageNaviBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.backButton];
        [self addSubview:self.titleLabel];
    }
    return self;
}

-(void)dealloc
{
  
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(100,20+KNaviBarSafeBottomMargin,KScreenWidth-200, 44);
    self.backButton.frame = CGRectMake(0, 20+KNaviBarSafeBottomMargin, 48, 50);
}



-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:TextFontName size:16];
        _titleLabel.adjustsFontSizeToFitWidth =YES;
        _titleLabel.minimumScaleFactor = 0.4;
        _titleLabel.text = @"消息";
    }
    return _titleLabel;
}


-(UIButton*)backButton
{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.titleLabel.font = [UIFont fontWithName:TextFontName size:16.0];
        _backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_backButton setImage:[UIImage imageNamed:@"navi_back_btn"] forState:UIControlStateNormal];
    
    }
    return _backButton;
}

@end
