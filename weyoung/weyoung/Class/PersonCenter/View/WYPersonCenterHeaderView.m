//
//  WYPersonCenterHeaderView.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPersonCenterHeaderView.h"
#import "WYButtonItem.h"
#import "NSString+Extension.h"
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
      
        [self update];
    }
    return self;
}

-(void)update
{
    NSString *bir = [WYSession sharedSession].birthday;
    NSString * age = [NSString dateToOld:bir];
    NSString * xing = [NSString getAstroWithBrith:bir];
    NSString * info = [NSString stringWithFormat:@"%@岁  %@座",age,xing];

    [self.avatarItem yy_setImageWithURL:[NSURL URLWithString:[WYSession sharedSession].avatar] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    self.nickLabel.text= [WYSession sharedSession].nickname;
    self.infoLabel.text  = info;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatarItem.frame = CGRectMake(KScreenWidth/2-45,20, 90, 90);
    self.nickLabel.frame = CGRectMake(50, CGRectGetMaxY(self.avatarItem.frame)+11, KScreenWidth-100, 27);
    self.infoLabel.frame = CGRectMake(KScreenWidth/2-35, CGRectGetMaxY(self.nickLabel.frame)+2, 91, 26);
    self.sexImageView.frame = CGRectMake(KScreenWidth/2-45, CGRectGetMaxY(self.nickLabel.frame)+10, 10, 10);
    
    self.dynamicItem.frame = CGRectMake(KScreenWidth/2-100, CGRectGetMaxY(self.infoLabel.frame)+5, 80, 44);
    self.friendItem.frame = CGRectMake(KScreenWidth/2+20, CGRectGetMaxY(self.infoLabel.frame)+5, 80, 44);
    
}


-(UIButton*)avatarItem
{
    if (!_avatarItem) {
        _avatarItem = [[UIButton alloc]init];
        _avatarItem.layer.cornerRadius = 45;
            _avatarItem.layer.masksToBounds = YES;
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
        _nickLabel.font = [UIFont fontWithName:TextFontName size:18];
        _nickLabel.textColor = [UIColor whiteColor];
        _nickLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nickLabel;
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _infoLabel.textColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.5];
    }
    return _infoLabel;
}

-(WYButtonItem*)dynamicItem
{
    if (!_dynamicItem) {
        _dynamicItem = [[WYButtonItem alloc] init];
        _dynamicItem.userInteractionEnabled = YES;
        [_dynamicItem setLeft:@"动态"];
        [_dynamicItem setRight:@"23"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            
            @strongify(self);
            if (self.block) {
                self.block(1);
            }
            
        }];
        
        [_dynamicItem addGestureRecognizer:tap];
    }
    return _dynamicItem;
}

-(WYButtonItem*)friendItem
{
    if (!_friendItem) {
        _friendItem = [[WYButtonItem alloc] init];
        _friendItem.userInteractionEnabled = YES;
        [_friendItem setLeft:@"好友"];
        [_friendItem setRight:@"17"];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            
            @strongify(self);
            if (self.block) {
                self.block(2);
            }
            
        }];
        
        [_friendItem addGestureRecognizer:tap];
        
    }
    return _friendItem;
}

@end
