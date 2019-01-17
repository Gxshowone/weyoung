//
//  WYCodeViewController.h
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYBaseViewController.h"

typedef NS_ENUM(NSInteger, WYCodeType)
{
    WYCodeTypeReg=0,
    WYCodeTypeLogin,
    WYCodeTypeForget,
    WYCodeTypeChange,
    
};
NS_ASSUME_NONNULL_BEGIN

@interface WYCodeViewController : WYBaseViewController

@property(nonatomic,copy)NSString * phone;
@property(nonatomic,assign)WYCodeType type;

@end

NS_ASSUME_NONNULL_END
