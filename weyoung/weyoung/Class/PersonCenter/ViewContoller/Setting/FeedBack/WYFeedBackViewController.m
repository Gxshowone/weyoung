//
//  WYFeedBackViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/9.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYFeedBackViewController.h"

@interface WYFeedBackViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UIView * bgView;
@property(nonatomic,strong)UITextView * textView;
@property(nonatomic,strong)UILabel * countLabel;


@end

@implementation WYFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.bgView.frame = CGRectMake(25, KNaviBarHeight+25, KScreenWidth-50, 320);
    
}

-(void)initUI
{
    [self setNavTitle:@"问题反馈"];
    [self.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.countLabel];
}

-(UIView*)bgView
{
    if (!_bgView) {
        _bgView  = [UIView new];
        _bgView.layer.cornerRadius = 10;
        _bgView.layer.borderColor = [UIColor binaryColor:@"333333"].CGColor;
        _bgView.layer.borderWidth = 1;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
    
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
