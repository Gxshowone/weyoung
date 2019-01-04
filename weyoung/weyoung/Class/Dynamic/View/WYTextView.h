//
//  WYTextView.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYTextView : UITextView

@property (nonatomic , copy) NSString *placeholder;
@property (nonatomic , strong) UIColor *placeholderColor;

@end

NS_ASSUME_NONNULL_END
