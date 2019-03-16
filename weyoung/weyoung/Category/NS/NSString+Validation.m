//
//  NSString+Validation.m
//  weyoung
//
//  Created by gongxin on 2018/12/17.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "NSString+Validation.h"

@implementation NSString (Validation)



/*判断输入的是否是昵称*/
-(BOOL)isValidNickName;
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{2,8}$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:self];
    
}


/*判断输入的是否是手机号码
 
 public static String[] phoneArrays = { "130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "150",
 "151", "152", "153", "154", "155", "156", "157", "158", "159", "180", "181", "182", "183", "184", "185",
 "186", "187", "188", "189" };
 
 * 仅允许130-139，150-159，180-189号段的手机号注册
 * ----------------------------------------------------------------------------
 * 以下为注释： 阿里小号177管理混乱需要限制，物联网卡199段不用实名，需要限制，运营商新出号段统计不全
 * 移动：134、135、136、137、138、139、150、151、152、157(TD)、158、159、187、188
 * 联通：130、131、132、155、156、185、186 电信：180、189、133、153、（1349卫通）
 *
 * @param phone
 * @return
 */
- (BOOL)isValidPhone
{
    if (self && self.length > 3) {
        NSString *hex = [self substringToIndex:3];
        NSArray *phone = @[@"130", @"131", @"132", @"133", @"134", @"135", @"136", @"137", @"138", @"139",
                           @"150", @"151", @"152", @"153", @"154", @"155", @"156", @"157", @"158", @"159",@"175",@"176",
                           @"180", @"181", @"182", @"183", @"184", @"185", @"186", @"187", @"188", @"189"];
        if (![phone containsObject:hex]) {
            return NO;
        }
    }
    
    NSString *stricterFilterString = @"\\b(1)[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\\b";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:self];
}

/*判断输入帐号是否为邮箱*/
-(BOOL)isValidEmail
{
    
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]";
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/*帐号密码格式*/
-(BOOL)isValidPassword
{
    NSString *stricterFilterString = @"^[A-Za-z0-9!@#$%^&*.~/{}|()'\"?><,.`+-=_:;\\\\[]]\\\[]{6,20}$";
    //    NSLog(@"stricterFilterString = %@",stricterFilterString);
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [passwordTest evaluateWithObject:self];
}

/*判断是否有效的整数*/
-(BOOL)isValidInteger {
    NSString *stricterFilterString = @"^\\d+$";
    NSPredicate *integerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [integerTest evaluateWithObject:self];
}

/*判断是否有效的正整数*/
-(BOOL)isValidPositiveInteger {
    NSString *stricterFilterString = @"^[0-9]*[1-9][0-9]*$";
    NSPredicate *integerTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [integerTest evaluateWithObject:self];
}

/*判断是否有效的浮点数*/
- (BOOL)isValidFloat {
    NSString *stricterFilterString = @"^(\\d*\\.)?\\d+$";
    NSPredicate *floatTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [floatTest evaluateWithObject:self];
}

/*判断是否有效的正浮点数*/
- (BOOL)isValidPositiveFloat {
    NSString *stricterFilterString = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [test evaluateWithObject:self];
}

/*判断是否为空字符串*/
- (BOOL)isEmpty {
    NSString *stricterFilterString = @"^\[ \t]*$";
    NSPredicate *emptyTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emptyTest evaluateWithObject:self];
    
}



@end
