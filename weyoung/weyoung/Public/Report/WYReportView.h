//
//  WYReportView.h
//  weyoung
//
//  Created by gongxin on 2018/12/22.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^WYReopotViewBlock)(NSInteger index);
@interface WYReportView : UIView
@property(nonatomic,copy)WYReopotViewBlock block;

- (void)show;
@end

NS_ASSUME_NONNULL_END
