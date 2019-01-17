//
//  WYDefine.h
//  weyoung
//
//  Created by gongxin on 2018/12/6.
//  Copyright © 2018 SouYu. All rights reserved.
//

#ifndef WYDefine_h
#define WYDefine_h


#pragma mark -
#pragma mark 打印日志
#define GTDEBUG 0
#if GTDEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#define KTabBarHeight                       (49.0f + KTabbarSafeBottomMargin)
#define KNaviBarHeight                      ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
#define KTabbarSafeBottomMargin             ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 34 : 0)
#define KNaviBarSafeBottomMargin            ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 24 : 0 )
#define IS_IPHONE_X                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断是否是ipad
#define isPad                               ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPHoneXr
#define IS_IPHONE_Xr                        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max                    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isPad : NO)
#define Height_StatusBar                    ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
#define Height_TabBar                       ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))
#define ISNIL(variable) (variable==nil)
//是不是NULL类型
#define IS_NULL_CLASS(variable)    ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNull class]])
//字典数据是否有效
#define IS_DICTIONARY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSDictionary class]])&&([((NSDictionary *)variable) count]>0))
//数组数据是否有效
#define IS_ARRAY_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSArray class]]))
//数字类型是否有效
#define IS_NUMBER_CLASS(variable) ((!ISNIL(variable))&&([variable  isKindOfClass:[NSNumber class]]))
//字符串是否有效
#define IS_EXIST_STR(str) ((nil != (str)) &&([(str) isKindOfClass:[NSString class]]) && (((NSString *)(str)).length > 0))

//color
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define kThemeColor  HexRGBAlpha(0xFF6BB7, 1)

#define WYRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//屏幕宽高
#define KScreenHeight   ([UIScreen mainScreen].bounds).size.height //屏幕的高度
#define KScreenWidth    ([UIScreen mainScreen].bounds).size.width //屏幕的宽度

#define TextFontName        @"PingFangSC-Regular"
#define TextFontName_Light  @"PingFangSC-Light"
#define TextFontName_Bold   @"PingFangSC-Semibold"
#define TextFontName_Italic @"Verdana-Italic"
#define TextFontName_Medium @"PingFangSC-Medium"
#define TextFontName_Helvetica @"Helvetica"


#define kGAP 10
#define kAvatar_Size 30

#define kTestAvatar @"http://mmbiz.qpic.cn/mmbiz/PwIlO51l7wuFyoFwAXfqPNETWCibjNACIt6ydN7vw8LeIwT7IjyG3eeribmK4rhibecvNKiaT2qeJRIWXLuKYPiaqtQ/0"

#endif /* WYDefine_h */
