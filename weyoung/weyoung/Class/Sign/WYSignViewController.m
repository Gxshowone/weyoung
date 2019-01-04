//
//  WYSignViewController.m
//  weyoung
//
//  Created by gongxin on 2019/1/4.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYSignViewController.h"

@interface WYSignViewController ()

@property(nonatomic,strong)UILabel * dayLabel;
@property(nonatomic,strong)UILabel * weekLabel;
@property(nonatomic,strong)UILabel * monthLabel;
@property(nonatomic,strong)UILabel * infoLabel;
@property(nonatomic,strong)UIButton * signButton;

@end

@implementation WYSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI
{
    [self.view addSubview:self.dayLabel];
    [self.view addSubview:self.weekLabel];
    [self.view addSubview:self.monthLabel];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.signButton];

}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.dayLabel.frame = CGRectMake(25, KNaviBarHeight+7, 53, 62);
    self.weekLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame)+8.5, KNaviBarHeight+23, 42, 20);
    self.monthLabel.frame = CGRectMake(CGRectGetMaxX(self.dayLabel.frame)+4.5, CGRectGetMaxY(self.weekLabel.frame), 50, 14);
    self.infoLabel.frame = CGRectMake(25, 127+KNaviBarHeight, KScreenWidth-50, 84);
    self.signButton.frame = CGRectMake(KScreenWidth/2-75, CGRectGetMaxY(self.infoLabel.frame), 150, 40);

}

-(UILabel*)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont fontWithName:TextFontName_Light size:44];
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dayLabel;
    
}

-(UILabel*)weekLabel
{
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc]init];
        _weekLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        _weekLabel.textColor = [UIColor whiteColor];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weekLabel;
    
}

-(UILabel*)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.font = [UIFont fontWithName:TextFontName size:10];
        _monthLabel.textColor = [UIColor whiteColor];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _monthLabel;
    
}

-(UILabel*)infoLabel
{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        _infoLabel.font = [UIFont fontWithName:TextFontName_Light size:16];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _infoLabel;
    
}

-(UIButton*)signButton
{
    if (!_signButton) {
        _signButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _signButton.layer.masksToBounds = YES;
        _signButton.layer.borderWidth = 0.5;
        _signButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _signButton.layer.cornerRadius = 20;
        [_signButton setTitle:@"晚安签到" forState:UIControlStateNormal];
        _signButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        [_signButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        @weakify(self);
        [[_signButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
        }];
    }
    return _signButton;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
