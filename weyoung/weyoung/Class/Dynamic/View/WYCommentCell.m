//
//  WYCommentCell.m
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCommentCell.h"
#import "NSString+Extension.h"
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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.avatarIV];
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.timeStampLabel];
        [self.contentView addSubview:self.contentLabel];
     
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarIV.frame = CGRectMake(20, 17.4, 32, 32);
    self.userNameLabel.frame = CGRectMake(67, 12.3, 120, 27);
    self.timeStampLabel.frame = CGRectMake(KScreenWidth-120, 14.5, 100, 27);
    self.contentLabel.frame = CGRectMake(68, 29, KScreenWidth-88, 54);
}

-(void)setModel:(WYCommentModel *)model
{
    _model = model;
    
    NSString * avatar = model.header_url;
    [self.avatarIV yy_setImageWithURL:[NSURL URLWithString:avatar] placeholder:nil];
    
    NSString*nick =model.nick_name;
    self.userNameLabel.text = nick;
    
    
    NSString * time = [NSString timeIntervaltoString:model.create_time];
    self.timeStampLabel.text = [NSString inputTimeStr:time withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    self.contentLabel.attributedText = model.attributedText;
    
    
}
-(UIImageView*)avatarIV
{
    if (!_avatarIV) {
        _avatarIV = [[UIImageView alloc]init];
        _avatarIV.layer.cornerRadius = 16;
        _avatarIV.layer.masksToBounds = YES;
        _avatarIV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            @strongify(self);
            if (self.tapCommentBlock) {
                self.tapCommentBlock(self, self.model);
            }
        }];
        [_avatarIV addGestureRecognizer:tap];
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
