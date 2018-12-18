//
//  WYPersonCenterHeaderView.h
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PersonCenterClickBlock)(NSInteger index);

@interface WYPersonCenterHeaderView : UIView

@property(nonatomic,copy)PersonCenterClickBlock block;

@end

NS_ASSUME_NONNULL_END
