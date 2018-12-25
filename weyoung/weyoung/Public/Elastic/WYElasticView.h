//
//  WYElasticView.h
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYElasticView : UIView

@property (nonatomic,assign) BOOL  iSResponsHandleButton;

/**
 实例方法
 
 @param superView 父视图
 @param animationTimeravel 弹起动画的时间 此时间也是收起modalView的时间
 @param height modalView的高度
 @return 实例
 */
- (instancetype)initWithSuperView:(UIView *)superView
                  animationTravel:(NSTimeInterval)animationTimeravel
                       viewHeight:(CGFloat)height;


/**
 供子类重写
 */
- (void)initView;
- (void)modalViewDidloade;
- (void)modalViewDidAppare;
- (void)modalViewWillDisappare;


/**
 公共方法
 */
- (void)show;
- (void)hide;
- (void)disMiss;

@end

NS_ASSUME_NONNULL_END
