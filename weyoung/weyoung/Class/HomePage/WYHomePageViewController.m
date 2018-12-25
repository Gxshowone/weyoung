//
//  WYHomePageViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHomePageViewController.h"
#import "WYDynamicViewController.h"
#import "WYPersonCenterController.h"
#import "WYConversationViewController.h"

#define kPulseAnimation @"kPulseAnimation"


@interface WYHomePageViewController ()

@property(nonatomic,strong)UIImageView * matchImageView;

@end

@implementation WYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationConfig];
    [self registerGesture];
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
  
    [self.rightButton yy_setImageWithURL:[NSURL URLWithString:@"http://mmbiz.qpic.cn/mmbiz/PwIlO51l7wuFyoFwAXfqPNETWCibjNACIt6ydN7vw8LeIwT7IjyG3eeribmK4rhibecvNKiaT2qeJRIWXLuKYPiaqtQ/0"] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    
    @weakify(self);
    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        [self gotoDynamic];
    }];

    [[self.rightButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"[gx] login click");
        [self gotoPersonCenter];
    }];
    
}

-(void)registerGesture
{
    // 注册手势驱动
    __weak typeof(self)weakSelf = self;
    [self cw_registerShowIntractiveWithEdgeGesture:NO transitionDirectionAutoBlock:^(CWDrawerTransitionDirection direction) {
        if (direction == CWDrawerTransitionFromLeft) { // 左侧滑出
            [weakSelf gotoDynamic];
        } else if (direction == CWDrawerTransitionFromRight) { // 右侧滑出
            [weakSelf gotoPersonCenter];
        }
    }];
}

//
- (void)gotoDynamic{
    
    // 强引用leftVC，不用每次创建新的,也可以每次在这里创建leftVC，抽屉收起的时候会释放掉
    [self cw_showDefaultDrawerViewController:[[WYDynamicViewController alloc]init]];
 
}

-(void)gotoPersonCenter
{
    WYPersonCenterController *vc = [[WYPersonCenterController alloc] init];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    CWLateralSlideConfiguration *conf = [CWLateralSlideConfiguration defaultConfiguration];
    conf.direction = CWDrawerTransitionFromRight; // 从右边滑出
    conf.finishPercent = 0.2f;
    conf.showAnimDuration = 0.2;
    conf.HiddenAnimDuration = 0.2;
    conf.distance = KScreenWidth;
    conf.maskAlpha = 0.1;
    [self cw_showDrawerViewController:nav animationType:CWDrawerAnimationTypeDefault configuration:conf];
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
          //  [self modifyAnimationStatus:self->_matchImageView];
            WYConversationViewController *conversationVC = [[WYConversationViewController alloc]init];
            conversationVC.conversationType = ConversationType_PRIVATE;
            conversationVC.targetId = @"2";
            conversationVC.title = @"想显示的会话标题";
            [self.navigationController pushViewController:conversationVC animated:YES];
            
        }];
        [_matchImageView addGestureRecognizer:tap];
        
        
        
      
    }
    return _matchImageView;
}


//diameter 扩散的大小
- (CALayer *)waveAnimationLayerWithView:(UIView *)view diameter:(CGFloat)diameter duration:(CGFloat)duration {
    CALayer *waveLayer = [CALayer layer];
    waveLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    waveLayer.cornerRadius = diameter / 2; //设置圆角变为圆形
    waveLayer.position = view.center;
    waveLayer.backgroundColor =  [UIColor whiteColor].CGColor;
    [view.superview.layer insertSublayer:waveLayer below:view.layer];//把扩散层放到播放按钮下面
    
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = duration;
    animationGroup.repeatCount = INFINITY; //重复无限次
    animationGroup.removedOnCompletion = NO;
    
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.7; //开始的大小
    scaleAnimation.toValue = @1.0; //最后的大小
    scaleAnimation.duration = duration;
    scaleAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @0.4; //开始的大小
    opacityAnimation.toValue = @0.0; //最后的大小
    opacityAnimation.duration = duration;
    opacityAnimation.removedOnCompletion = NO;
    
    animationGroup.animations = @[scaleAnimation, opacityAnimation];
    [waveLayer addAnimation:animationGroup forKey:kPulseAnimation];
    
    return waveLayer;
}

- (void)modifyAnimationStatus:(UIImageView*)imageView{
    BOOL isAnimating = NO;
    NSArray *layerArr = [NSArray arrayWithArray:imageView.superview.layer.sublayers];
    
    for (CALayer *layer in layerArr) {
        if ([layer.animationKeys containsObject:kPulseAnimation]) {
            isAnimating = YES;
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
    }
    
    if (!isAnimating) {
        [self waveAnimationLayerWithView:self.matchImageView diameter:160 duration:1.2];
        [self waveAnimationLayerWithView:self.matchImageView diameter:115 duration:1.2];
    }
}



@end
