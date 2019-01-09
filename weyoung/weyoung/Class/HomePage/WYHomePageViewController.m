//
//  WYHomePageViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHomePageViewController.h"

#define kPulseAnimation @"kPulseAnimation"


@interface WYHomePageViewController ()

@property(nonatomic,strong)UIImageView * matchImageView;

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
    [self initUI];
    
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.matchImageView.frame = CGRectMake(KScreenWidth/2-36, KScreenHeight-KTabbarSafeBottomMargin-35-72, 72, 72);
    
    self.matchImageView.layer.cornerRadius = self.matchImageView.bounds.size.width / 2;
    
}

-(void)initUI
{
    [self.view addSubview:self.matchImageView];
  
}

-(void)setNavigationConfig
{
    self.leftButton.x = 10;
    
    self.rightButton.y = 29+KNaviBarSafeBottomMargin;
    self.rightButton.width = 30;
    self.rightButton.height = 30;
    self.rightButton.layer.cornerRadius = 15;
    self.rightButton.layer.masksToBounds = YES;
    
    [self setNavTitle:@"Explore"];
 
    [self.leftButton setImage:[UIImage imageNamed:@"navi_dynamic_btn"] forState:UIControlStateNormal];
  
    [self.rightButton yy_setImageWithURL:[NSURL URLWithString:[WYSession sharedSession].avatar] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    
 
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
     
        [self gotoDynamic];
    }];
    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    
        [self gotoPersonCenter];
    }];
    
}

-(void)gotoDynamic
{
   
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:0];
    }
}


-(void)gotoPersonCenter
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(scrollToIndex:)]) {
        [self.delegate scrollToIndex:2];
    }
}



-(UIImageView*)matchImageView
{
    if (!_matchImageView) {
        _matchImageView = [[UIImageView alloc]init];
        _matchImageView.backgroundColor = [UIColor whiteColor];
        _matchImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self);
        [[tap rac_gestureSignal] subscribeNext:^(id x) {
            NSLog(@"tap");
            @strongify(self);
          
            if(self.delegate&&[self.delegate respondsToSelector:@selector(conversation)])
            {
                [self.delegate conversation];
            }   
        }];
        [_matchImageView addGestureRecognizer:tap];
    
    }
    return _matchImageView;
}





@end
