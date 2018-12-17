//
//  NSString+Validation.h
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Validation)

/*判断输入的是否是昵称*/
-(BOOL)isValidNickName;

/*判断输入的是否是手机号码*/
-(BOOL)isValidPhone;

/*判断输入帐号是否为邮箱*/
-(BOOL)isValidEmail;

/*判断密码只能是6-20位数字和字母*/
-(BOOL)isValidPassword;

/*判断是否有效的整数*/
-(BOOL)isValidInteger;

/*判断是否有效的整数*/
-(BOOL)isValidPositiveInteger;

/*判断是否有效的浮点数*/
- (BOOL)isValidFloat;

/*判断是否有效的正浮点数*/
- (BOOL)isValidPositiveFloat;

/*判断是否为空字符串*/
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
