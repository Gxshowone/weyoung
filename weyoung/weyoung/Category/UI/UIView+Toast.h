//
//  UIView+Toast.h
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

extern NSString * const CSToastPositionTop;
extern NSString * const CSToastPositionCenter;
extern NSString * const CSToastPositionBottom;

@interface UIView (Toast)

// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message;
+ (void)centerMakeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title image:(UIImage *)image;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point
      tapCallback:(void(^)(void))tapCallback;

@end

NS_ASSUME_NONNULL_END
