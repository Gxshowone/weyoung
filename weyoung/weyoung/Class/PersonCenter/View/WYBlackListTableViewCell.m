//
//  WYBlackListTableViewCell.m
//  weyoung
//
//  Created by 巩鑫 on 2019/1/20.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYBlackListTableViewCell.h"
#import "NSString+Extension.h"
@interface WYBlackListTableViewCell()

@property(nonatomic,strong)UIImageView * avatarImageView;
@property(nonatomic,strong)UILabel     * nickLabel;

@end
@implementation WYBlackListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nickLabel];
    }
    return self;
}

-(void)setModel:(RCUserInfo *)model
{
    _model = model;
    
    [self.avatarImageView yy_setImageWithURL:[NSURL URLWithString:model.portraitUri] placeholder:nil];
    
    self.nickLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avatarImageView.frame = CGRectMake(20, 17.5, 45, 45);
    self.nickLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+15, 26, 150, 28);
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



@end
