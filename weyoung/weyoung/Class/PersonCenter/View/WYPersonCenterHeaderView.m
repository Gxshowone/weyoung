//
//  WYPersonCenterHeaderView.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPersonCenterHeaderView.h"
#import "WYButtonItem.h"
@interface WYPersonCenterHeaderView ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton *  avatarItem;
@property(nonatomic,strong)UILabel     * nickLabel;
@property(nonatomic,strong)UIImageView * sexImageView;
@property(nonatomic,strong)UILabel     * infoLabel; //age  constellation
@property(nonatomic,strong)WYButtonItem * dynamicItem;
@property(nonatomic,strong)WYButtonItem * friendItem;

@end
@implementation WYPersonCenterHeaderView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.avatarItem];
        [self addSubview:self.nickLabel];
        [self addSubview:self.sexImageView];
        [self addSubview:self.infoLabel];
        [self addSubview:self.dynamicItem];
        [self addSubview:self.friendItem];
      
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarItem.frame = CGRectMake(KScreenWidth/2-45, KNaviBarHeight+20, 90, 90);
    self.nickLabel.frame = CGRectMake(50, CGRectGetMaxY(self.avatarItem.frame)+11, KScreenWidth-100, 27);
    self.infoLabel.frame = CGRectMake(KScreenWidth/2-35, CGRectGetMaxY(self.nickLabel.frame)+2, 91, 26);
    self.sexImageView.frame = CGRectMake(KScreenWidth/2-45, CGRectGetMaxY(self.nickLabel.frame)+10, 10, 10);
    
    self.dynamicItem.frame = CGRectMake(KScreenWidth/2-90, CGRectGetMaxY(self.infoLabel.frame)+5, 60, 44);
    self.friendItem.frame = CGRectMake(KScreenWidth/2+30, CGRectGetMaxY(self.infoLabel.frame)+5, 60, 44);
    
}


-(UIButton*)avatarItem
{
    if (!_avatarItem) {
        _avatarItem = [[UIButton alloc]init];
        _avatarItem.layer.cornerRadius = 45;
        _avatarItem.layer.masksToBounds = YES;
        [_avatarItem yy_setImageWithURL:[NSURL URLWithString:@"http://mmbiz.qpic.cn/mmbiz/PwIlO51l7wuFyoFwAXfqPNETWCibjNACIt6ydN7vw8LeIwT7IjyG3eeribmK4rhibecvNKiaT2qeJRIWXLuKYPiaqtQ/0"] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
        @weakify(self);
        [[_avatarItem rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.block) {
                self.block(0);
            }
        }];
        
    }
    return _avatarItem;
}

-(UILabel*)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc]init];
        _nickLabel.text= @"昵称最多八个字";
        _nickLabel.font = [UIFont fontWithName:TextFontName size:18];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nickLabel;
}

-(WYButtonItem*)dynamicItem
{
    if (!_dynamicItem) {
        _dynamicItem = [[WYButtonItem alloc] init];
        @weakify(self);
        [[_dynamicItem rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.block) {
                self.block(1);
            }
        }];
        
    }
    return _dynamicItem;
}

-(WYButtonItem*)friendItem
{
    if (!_friendItem) {
        _friendItem = [[WYButtonItem alloc] init];
        @weakify(self);
        [[_friendItem rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.block) {
                self.block(2);
            }
        }];
        
    }
    return _dynamicItem;
}

@end
