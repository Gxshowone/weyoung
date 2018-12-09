//
//  WYEditTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYEditTableViewCell.h"
@interface WYEditTableViewCell()

@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * contentLabel;

@end
@implementation WYEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

-(void)setTitle:(NSString*)text
{
    self.titleLabel.text = text;
}
-(void)setContent:(NSString*)text
{
    self.contentLabel.text = text;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(20, 15, 26, 17);
    self.contentLabel.frame = CGRectMake(20, 33.5,200, 22);
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:TextFontName size:12];
    }
    return _titleLabel;
}

-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor binaryColor:@"DCDEEA"];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        
    }
    return _contentLabel;
}


@end
