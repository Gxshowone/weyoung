//
//  WYMessageHeaderTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2019/1/12.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYMessageHeaderTableViewCell.h"
@interface WYMessageHeaderTableViewCell()

@property(nonatomic,strong)UIImageView * icon;
@property(nonatomic,strong)UILabel *  titleLabel;
@property(nonatomic,strong)UILabel * unreadLabel;

@end
@implementation WYMessageHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.unreadLabel];
        
        [self getSystemCount];
    }
    return self;
}

-(void)getSystemCount
{

    int count =  [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_SYSTEM targetId:@"10000"];
    self.unreadLabel.text = [NSString stringWithFormat:@"%d",count];
    self.unreadLabel.hidden = (count==0)?YES:NO;
    
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[data valueForKey:@"title"]];
    [self.icon setImage:[UIImage imageNamed:[data valueForKey:@"image"]]];
    
    self.unreadLabel.hidden = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.icon.frame = CGRectMake(20, 12.5, 45, 45);
    self.titleLabel.frame = CGRectMake(80.3, 22, 100, 26);
    self.unreadLabel.frame = CGRectMake(KScreenWidth-18-20, 26, 18, 18);

}

-(UIImageView*)icon
{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

-(UILabel *)titleLabel
{
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UILabel*)unreadLabel
{
    if (!_unreadLabel) {
        _unreadLabel = [[UILabel alloc]init];
        _unreadLabel.backgroundColor = [UIColor binaryColor:@"F64F6E"];
        _unreadLabel.font = [UIFont fontWithName:TextFontName_Light size:12];
        _unreadLabel.textColor = [UIColor whiteColor];
        _unreadLabel.textAlignment = NSTextAlignmentCenter;
        _unreadLabel.layer.cornerRadius = 9;
        _unreadLabel.layer.masksToBounds = YES;
        _unreadLabel.text = @"1";
    }
    return _unreadLabel;
}

@end
