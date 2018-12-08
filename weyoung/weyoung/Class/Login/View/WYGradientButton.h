//
//  WYGradientButton.h
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WYGradientButtonStyle) {
    WYGradientButtonCircle,
    WYGradientButtonRectangle,
};

@interface WYGradientButton : UIButton

@property(nonatomic,assign)WYGradientButtonStyle style;


@end

NS_ASSUME_NONNULL_END
