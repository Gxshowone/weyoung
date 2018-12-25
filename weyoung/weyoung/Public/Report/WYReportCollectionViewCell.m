//
//  WYReportCollectionViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYReportCollectionViewCell.h"
@interface WYReportCollectionViewCell()

@property(nonatomic,strong)UIView * selectView;
@property(nonatomic,strong)UILabel * titleLabel;

@end
@implementation WYReportCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.selectView];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(28, 0, 102, 30);
}

-(void)setTitle:(NSString*)title
{
    self.titleLabel.text = title;
}


-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.selectView.layer.borderColor = (selected)?[UIColor binaryColor:@"F4DB3B"].CGColor:[UIColor binaryColor:@"E8E8E8"].CGColor;
    self.titleLabel.textColor = (selected)?[UIColor binaryColor:@"333333"]:[UIColor binaryColor:@"999999"];
    
 
}
-(UIView*)selectView
{
    if (!_selectView) {
        _selectView = [[UIView alloc]init];
        _selectView.backgroundColor = [UIColor clearColor];
        _selectView.y = 6;
        _selectView.width = 18;
        _selectView.height = 18;
        _selectView.layer.cornerRadius = 9;
        _selectView.layer.borderWidth = 3;
        _selectView.layer.borderColor = [UIColor binaryColor:@"E8E8E8"].CGColor;
    }
    return _selectView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:TextFontName size:16];
        _titleLabel.textColor = [UIColor binaryColor:@"999999"];
    }
    return _titleLabel;
}


@end
