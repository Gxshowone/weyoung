//
//  WYCommentCell.m
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCommentCell.h"

#import "WYCopyLabel.h"
@interface WYCommentCell ()

@property(nonatomic,strong)UIImageView *avatarIV;
@property(nonatomic,strong)UILabel *userNameLabel;
@property(nonatomic,strong)UILabel *timeStampLabel;
@property (nonatomic, strong)WYCopyLabel *contentLabel;

@end
@implementation WYCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.avatarIV];
        [self.contentView addSubview:self.contentLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapComment:)];
        [self.contentLabel  addGestureRecognizer:tap];
        
    }
    return self;
}

-(void)tapComment:(UITapGestureRecognizer *)tap{
    if (self.tapCommentBlock) {
        self.tapCommentBlock(self, self.model);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarIV.frame = CGRectMake(20, 17.4, 32, 32);
    self.userNameLabel.frame = CGRectMake(67, 12.3, 120, 27);
    self.timeStampLabel.frame = CGRectMake(KScreenWidth-120, 14.5, 100, 27);
    self.contentLabel.frame = CGRectMake(68, 42.5, KScreenWidth-88, 54);
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


-(UILabel*)timeStampLabel
{
    if (!_timeStampLabel) {
        _timeStampLabel = [[UILabel alloc]init];
        _timeStampLabel.font = [UIFont fontWithName:TextFontName_Light size:10];
        _timeStampLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        _timeStampLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeStampLabel;
}


-(WYCopyLabel*)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel= [[WYCopyLabel alloc]init];
    }
    return _contentLabel;
}
@end
