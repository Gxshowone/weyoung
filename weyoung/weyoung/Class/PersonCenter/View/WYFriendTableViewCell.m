//
//  WYFriendTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYFriendTableViewCell.h"
@interface WYFriendTableViewCell()

@property(nonatomic,strong)UIImageView * avatarImageView;
@property(nonatomic,strong)UILabel     * nickLabel;
@property(nonatomic,strong)UILabel     * contentLabel;
@property(nonatomic,strong)UIButton    * chatButton;

@end
@implementation WYFriendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.chatButton];
    }
    return self;
}

-(void)setModel:(WYFriendModel *)model
{
    _model = model;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avatarImageView.frame = CGRectMake(20, 17.5, 45, 45);
    self.nickLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+15, 17.5, 150, 27);
    self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+15, CGRectGetMaxY(self.avatarImageView.frame)+1, 150, 27);
    self.chatButton.frame = CGRectMake(KScreenWidth-75, 27, 55, 26);
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
        _nickLabel.font = [UIFont fontWithName:TextFontName size:16];
        _nickLabel.textColor = [UIColor whiteColor];
    }
    return _nickLabel;
}

-(UILabel*)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:TextFontName size:16];
        _contentLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    }
    return _contentLabel;
}

-(UIButton*)chatButton
{
    if (!_chatButton) {
        _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatButton setTitle:@"聊天" forState:UIControlStateNormal];
        _chatButton.layer.cornerRadius = 13;
        _chatButton.layer.borderWidth = 1;
        _chatButton.layer.masksToBounds = YES;
        
    }
    return _chatButton;
}

@end
