//
//  WYNoDataView.h
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol WYNoDataViewDelegate;

@interface WYNoDataView : UIView

@property (nonatomic,weak) id<WYNoDataViewDelegate> delegate;


-(void)showNoDataView:(UIView*)superView noDataString:(NSString *)noDataString noDataImage:(NSString*)imageName imageViewFrame:(CGRect)rect;


/**
 * 隐藏方法
 */
-(void)hide;

/**
 * 坐标
 */
-(void)setContentViewFrame:(CGRect)rect;

/**
 * 颜色
 */
-(void)setColor:(UIColor*)color;

@end

@protocol WYNoDataViewDelegate <NSObject>

-(void)didClickedNoDataButton;


@end

NS_ASSUME_NONNULL_END
