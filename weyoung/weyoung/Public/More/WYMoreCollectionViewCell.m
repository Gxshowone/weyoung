//
//  WYMoreCollectionViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYMoreCollectionViewCell.h"
@interface WYMoreCollectionViewCell()

@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * titleLabel;

@end
@implementation WYMoreCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(4, 0, 40, 40);
    self.titleLabel.frame = CGRectMake(0, 40, 50, 20);
}

-(UIImageView*)imageView
{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

-(UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = [UIColor binaryColor:@"999999"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


-(void)setTitle:(NSString*)title
{
    self.titleLabel.text = title;
}
-(void)setImageName:(NSString*)imageName
{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}

@end
