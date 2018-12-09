//
//  WYAboutHeaderView.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYAboutHeaderView.h"
@interface WYAboutHeaderView()

@property(nonatomic,strong)UIImageView * logoImageView;
@property(nonatomic,strong)UILabel  * versionLabel;

@end
@implementation WYAboutHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.logoImageView];
        [self addSubview:self.versionLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.logoImageView.frame = CGRectZero;
    self.versionLabel.frame = CGRectMake(KScreenWidth/2-23.5, CGRectGetMaxY(self.logoImageView.frame), 47, 27);
}

-(UIImageView*)logoImageView
{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
    }
    return _logoImageView;
}

-(UILabel*)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc]init];
        _versionLabel.text = @"v1.0.0";
        _versionLabel.font = [UIFont fontWithName:TextFontName size:16];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
    }
    return _versionLabel;
}

@end
