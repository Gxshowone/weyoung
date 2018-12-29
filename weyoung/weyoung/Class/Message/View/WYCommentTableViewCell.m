//
//  WYCommentTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/27.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYCommentTableViewCell.h"
@interface WYCommentTableViewCell()

@property(nonatomic,strong)UIImageView * avatarImageView;
@property(nonatomic,strong)UILabel     * nickLabel;
@property(nonatomic,strong)UILabel     * contentLabel;
@property(nonatomic,strong)UILabel     * timeLabel;
@property(nonatomic,strong)UIImageView * photoImageView;
@property(nonatomic,strong)UILabel     * themeLabel;

@end

@implementation WYCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.themeLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avatarImageView.frame = CGRectMake(20, 17.5, 32, 32);
    self.nickLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+16,21, 150, 27);
    self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+16, CGRectGetMaxY(self.nickLabel.frame)+1, 150, 27);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+16, CGRectGetMaxY(self.contentLabel.frame)+4, 150, 27);
    
    self.photoImageView.frame = CGRectMake(KScreenWidth-64, 3, 44, 44);
    self.themeLabel.frame = CGRectMake(KScreenWidth-64, 3, 44, 44);
}

-(UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
    }
    return _avatarImageView;
}

-(UILabel*)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc]init];
        _nickLabel.textAlignment = NSTextAlignmentLeft;
        _nickLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _nickLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _nickLabel;
}

-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _contentLabel.textColor = [UIColor whiteColor];
    }
    return _contentLabel;
}

-(UILabel*)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.4];
        _timeLabel.font = [UIFont fontWithName:TextFontName_Light size:10];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

-(UIImageView*)photoImageView
{
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc]init];
        _photoImageView.layer.cornerRadius = 4;
        _photoImageView.layer.masksToBounds = YES;
        
    }
    return _photoImageView;
}

-(UILabel*)themeLabel
{
    if (!_themeLabel) {
        _themeLabel = [[UILabel alloc]init];
        _themeLabel.layer.cornerRadius = 4;
        _themeLabel.layer.masksToBounds = YES;
        _themeLabel.backgroundColor = [UIColor binaryColor:@"333333"];
        _themeLabel.textColor =[UIColor binaryColor:@"FFFFFF"];
        _themeLabel.font = [UIFont fontWithName:TextFontName_Light size:8];
    }
    return _themeLabel;
}

@end
