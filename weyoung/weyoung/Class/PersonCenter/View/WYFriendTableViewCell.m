//
//  WYFriendTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYFriendTableViewCell.h"
#import "NSString+Extension.h"
@interface WYFriendTableViewCell()

@property(nonatomic,strong)UIImageView * avatarImageView;
@property(nonatomic,strong)UILabel     * nickLabel;
@property(nonatomic,strong)UILabel     * contentLabel;
@property(nonatomic,strong)UIButton    * chatButton;

@end
@implementation WYFriendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.chatButton];
    }
    return self;
}

-(void)setModel:(WYUserInfo *)model
{
    _model = model;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:model.portraitUri] placeholder:nil];
    
    self.nickLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    NSString *bir =  [NSString stringWithFormat:@"%@",model.brithday];
    NSString * age = [NSString dateToOld:bir];
    NSString * xing = [NSString getAstroWithBrith:bir];
    self.contentLabel.text = [NSString stringWithFormat:@"%@岁  %@座",age,xing];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avatarImageView.frame = CGRectMake(20, 17.5, 45, 45);
    self.nickLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+15, 17.5, 150, 22.5);
    self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+15, CGRectGetMaxY(self.nickLabel.frame)+1, 150, 22.5);
    self.chatButton.frame = CGRectMake(KScreenWidth-75, 27, 55, 26);
}

-(UIImageView*)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc]init];
        _avatarImageView.layer.cornerRadius = 22.5;
        _avatarImageView.layer.masksToBounds= YES;
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
        _chatButton.layer.borderWidth = 0.5;
        _chatButton.layer.masksToBounds = YES;
        [_chatButton setTitleColor:[UIColor binaryColor:@"979797"] forState:UIControlStateNormal];
        _chatButton.layer.borderColor = [UIColor binaryColor:@"979797"].CGColor;
        _chatButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _chatButton;
}

@end
