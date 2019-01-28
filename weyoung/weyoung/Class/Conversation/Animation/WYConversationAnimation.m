
//
//  WYConversationAnimation.m
//  weyoung
//
//  Created by gongxin on 2019/1/28.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYConversationAnimation.h"



@implementation WYConversationAnimation 

//返回动画事件
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return (self.transitionType==WYLTransitionOneTypePush)?2.3:0.3;
}

//所有的过渡动画事务都在这个方法里面完成
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    switch (_transitionType) {
      
        case WYLTransitionOneTypePush:
            [self pushAnimation:transitionContext];
            break;
        case WYLTransitionOneTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}

#pragma mark -- transitionType


- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    UIImageView * flightImageView = [[UIImageView alloc]init];
    flightImageView.frame = CGRectMake((KScreenWidth-375)/2, KScreenHeight/2-200,375, 400);
    NSMutableArray * fa = [NSMutableArray array];
    for (int i = 0; i < 24; i ++) {
        
        NSString * fn = [NSString stringWithFormat:@"flight_push_%d",i];
        UIImage  * fi = [UIImage imageNamed:fn];
        [fa addObject:fi];
    }
    flightImageView.animationImages = fa;
    flightImageView.animationDuration = 1.6;
    flightImageView.animationRepeatCount = 1;
    [flightImageView startAnimating];
    [containerView addSubview:toView];
    [containerView addSubview:flightImageView];
    containerView.backgroundColor = [UIColor blackColor];
    fromView.hidden = YES;
    toView.hidden = YES;
    
 
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"flight_end" ofType:@"json"];
    NSArray *components = [filePath componentsSeparatedByString:@"/"];
    NSString * name = [components lastObject];
    LOTAnimationView * filghtAnimation = [LOTAnimationView animationNamed:name];
   filghtAnimation.contentMode = UIViewContentModeScaleAspectFit;
   filghtAnimation.loopAnimation = YES;
   filghtAnimation.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    
    dispatch_time_t flightTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6* NSEC_PER_SEC));
    dispatch_after(flightTime , dispatch_get_main_queue(), ^{
        
        [flightImageView removeFromSuperview];
        [containerView addSubview:filghtAnimation];
        [filghtAnimation play];
   
    });
    

    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3* NSEC_PER_SEC));
    dispatch_after(delayTime , dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
                             
                         }
                         completion:^(BOOL finished) {
                             fromView.hidden = NO;
                             toView.hidden = NO;
                             [filghtAnimation removeFromSuperview];
                             [transitionContext completeTransition:YES];
                         }];
    });
    
}

- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //由于加入了手势必须判断
    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    

    
    //加入动画视图
    [containerView addSubview:fromView];

    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                     
                     }
                     completion:^(BOOL finished) {
                         //由于加入了手势交互转场，所以需要根据手势动作是否完成/取消来做操作
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         if([transitionContext transitionWasCancelled]){
                             //手势取消
                         }else{
                             //手势完成
                             [containerView addSubview:toView];
                         }
                      
                         toView.hidden = NO;
                         
                     }];
}

@end
