//
//  NSString+Extension.h
//  weyoung
//
//  Created by gongxin on 2018/12/18.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)


/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


//计算年龄
+(NSString *)dateToOld:(NSString*)birth;

//计算星座
+(NSString *)getAstroWithBrith:(NSString*)brith;

+(NSString*)timeIntervaltoString:(NSString*)timeStampString;
+(NSString *)inputTimeStr:(NSString *)timeStr withFormat:(NSString *)format;

+(NSString*)timeToMonth:(NSString*)timeStampString;
+(NSString*)timeToDay:(NSString*)timeStampString;
+(NSString*)timeToYear:(NSString*)timeStampString;
+(NSString*)exchangeToEngMonth:(NSString*)cn;
+(NSString *)getNowTimeTimestamp;
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;

+(NSString *)currentDateStr;
@end

NS_ASSUME_NONNULL_END
