//
//  WYMyDynamicTableViewCell.m
//  weyoung
//
//  Created by gongxin on 2019/1/4.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYMyDynamicTableViewCell.h"
#import "WYCopyLabel.h"
#import "WYJPPView.h"
@interface WYMyDynamicTableViewCell()

@property(nonatomic,strong)UILabel * dayLabel;
@property(nonatomic,strong)UILabel * monthLabel;
@property(nonatomic,strong)WYCopyLabel *messageTextLabel;
@property(nonatomic,strong)WYJPPView *jggView;

@end
@implementation WYMyDynamicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.dayLabel];
        [self.contentView addSubview:self.monthLabel];
        [self.contentView addSubview:self.messageTextLabel];
        [self.contentView addSubview:self.jggView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.dayLabel.frame = CGRectMake(19.5, 23.5, 24, 28);
    self.monthLabel.frame = CGRectMake(19,CGRectGetMaxY(self.dayLabel.frame), 23, 16);
    self.messageTextLabel.frame = CGRectMake(68, 23.5, KScreenWidth-88, 100);
    
}

-(UILabel*)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont fontWithName:TextFontName_Medium size:20];
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
}

-(UILabel*)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.font = [UIFont fontWithName:TextFontName size:11];
        _monthLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.49];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
}

-(WYCopyLabel*)messageTextLabel
{
    if(!_messageTextLabel)
    {
        _messageTextLabel = [[WYCopyLabel alloc]init];
    }
    return _messageTextLabel;
}

-(WYJPPView*)jggView
{
    if (!_jggView) {
        _jggView = [[WYJPPView alloc]init];
    }
    return _jggView;
}
@end
