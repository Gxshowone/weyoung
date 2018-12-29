//
//  WYButtonItem.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYButtonItem.h"

@interface WYButtonItem ()

@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UILabel *rightLabel;

@end
@implementation WYButtonItem

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(0, 0, self.width/2-2.5, self.height);
    self.rightLabel.frame = CGRectMake(self.width/2+2/5, 0, self.width/2-2/5, self.height);
    
}

- (instancetype)init;
{
    self = [super init];
    if (self) {
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        
    }
    return self;
}

-(void)setLeft:(NSString *)text
{
    self.leftLabel.text = text;
    
}

-(void)setRight:(NSString *)text
{
    self.rightLabel.text = text;
    
}

-(UILabel*)leftLabel
{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
        _leftLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _leftLabel.textAlignment = NSTextAlignmentRight;
        _leftLabel.userInteractionEnabled = YES;
    }
    return _leftLabel;
}
-(UILabel*)rightLabel
{
    if (!_rightLabel) {
        
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textColor = [UIColor binaryColor:@"FFFFFF"];
        _rightLabel.font = [UIFont fontWithName:TextFontName_Helvetica size:15];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.userInteractionEnabled = YES;
    }
    return _rightLabel;
}

@end
