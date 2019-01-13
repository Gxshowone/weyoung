//
//  WYComposeToolBar.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYComposeToolBar.h"
@interface WYComposeToolBar()
@property (nonatomic,strong) UILabel  * countLabel;

@end

@implementation WYComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.photoButton];
        [self addSubview:self.countLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photoButton.frame = CGRectMake(10, 3, 44, 44);
    self.countLabel.frame = CGRectMake(KScreenWidth-80, 16, 60, 18);
    
   
}

-(void)updateCount:(NSString*)count
{
    self.countLabel.text = [NSString stringWithFormat:@"%@/220",count];
}

-(UIButton*)photoButton
{
    if (!_photoButton) {
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoButton setImage:[UIImage imageNamed:@"dynamic_photo_btn"] forState:UIControlStateNormal];

    }
    return _photoButton;
}

-(UILabel*)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.text = @"0/220";
        _countLabel.font = [UIFont fontWithName:TextFontName size:12];
        _countLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}


@end
