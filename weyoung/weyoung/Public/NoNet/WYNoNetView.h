//
//  WYNoNetView.h
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum
{
    WYNoNetWorkViewStyle_No_NetWork=0,
    WYNoNetWorkViewStyle_Load_Fail
}WYNoNetWorkViewStyle;

@protocol WYNoNetWorkViewDelegate ;

@interface WYNoNetView : UIView




@property (weak,nonatomic) id<WYNoNetWorkViewDelegate> delegate;
@property (nonatomic, copy) dispatch_block_t reloadDataBlock;
/**
 * 出现方法
 */
-(void)showInView:(UIView*)superView style:(WYNoNetWorkViewStyle)style imageName:(NSString*)imageName;
/**
 * 隐藏方法
 */
-(void)hide;

//连网小菊花停止转动
-(void)stopAiv;

@end

@protocol WYNoNetWorkViewDelegate <NSObject>
/**
 * 重新加载
 */
-(void)retryToGetData;


@end

NS_ASSUME_NONNULL_END
