//
//  NSString+Extension.m
//  weyoung
//
//  Created by gongxin on 2018/12/18.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)



/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    
    //    NSLog(@"size:%@", NSStringFromCGSize(rect.size));
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    
    
    return rect.size;
}



/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.length)];
    [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
    CGRect rect = [attributeString boundingRectWithSize:size options:options context:nil];
    
    //    NSLog(@"size:%@", NSStringFromCGSize(rect.size));
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((rect.size.height - font.lineHeight) <= paragraphStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height-paragraphStyle.lineSpacing);
        }
    }
    
    
    return rect.size;
}



/**
 *  计算最大行数文字高度,可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines{
    
    if (maxLines <= 0) {
        return 0;
    }
    
    CGFloat maxHeight = font.lineHeight * maxLines + lineSpacing * (maxLines - 1);
    
    CGSize orginalSize = [self boundingRectWithSize:size font:font lineSpacing:lineSpacing];
    
    if ( orginalSize.height >= maxHeight ) {
        return maxHeight;
    }else{
        return orginalSize.height;
    }
}

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing{
    
    if ( [self boundingRectWithSize:size font:font lineSpacing:lineSpacing].height > font.lineHeight  ) {
        return YES;
    }else{
        return NO;
    }
}
//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *dict = @{NSFontAttributeName: font};
    CGSize textSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return textSize;
}

+(NSString *)dateToOld:(NSString*)birth
{
    //获得当前系统时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDay = [dateFormatter dateFromString:birth];
    
    
    NSDate *currentDate = [NSDate date];
    //获得当前系统时间与出生日期之间的时间间隔
    NSTimeInterval time = [currentDate timeIntervalSinceDate:birthDay];
    //时间间隔以秒作为单位,求年的话除以60*60*24*356
    int age = ((int)time)/(3600*24*365);
    return [NSString stringWithFormat:@"%d",age];
}

+(NSString*)timeIntervaltoString:(NSString*)timeStampString
{
    
    // iOS 生成的时间戳是10位
    NSTimeInterval interval    =[timeStampString doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

+(NSString*)timeToYear:(NSString*)timeStampString
{
    NSTimeInterval interval    =[timeStampString doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+(NSString*)timeToMonth:(NSString*)timeStampString
{
    NSTimeInterval interval    =[timeStampString doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
    
}
+(NSString*)timeToDay:(NSString*)timeStampString
{
    NSTimeInterval interval    =[timeStampString doubleValue];
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    
    return dateString;
}

+(NSString *)getAstroWithBrith:(NSString*)brith{
    
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:brith];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    int m = (int) [dateComponent month];
    int d = (int) [dateComponent day];
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        
        return @"日期格式有误";
    }
    if(m==2 && d>29){
        return @"错误日期格式!!";
    }
    else if(m==4 || m==6 || m==9 || m==11) {
        
        if (d>30) {
            return @"错误日期格式!!!";
            
        }
        
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    
    return result;
    
}

+(NSString *)inputTimeStr:(NSString *)timeStr withFormat:(NSString *)format

{
    
    NSDate *nowDate = [NSDate date];
    
    NSDate *sinceDate = [self becomeDateStr:timeStr withFormat:format];
    
    int i  = [nowDate timeIntervalSinceDate:sinceDate];
    
    
    
    NSString  *str  = @"";
    
    
    
    if (i <= 60)
        
    {//小于60s
        
        str = @"刚刚";
        
    }else if(i>60 && i<=3600)
        
    {//大于60s，小于一小时
        
        str = [NSString stringWithFormat:@"%d分钟前",i/60];
        
    }else if (i>3600 && i<60*60*24)
        
    {//
        
        if ([self isYesterdayWithDate:sinceDate])
            
        {//24小时内可能是昨天
            
            str = [NSString stringWithFormat:@"昨天"];
            
        }else
            
        {//今天
            
            str = [NSString stringWithFormat:@"%d小时前",i/3600];
            
        }
        
    }else
        
    {//
        
        int k = i/(3600*24);
        
        if ([self isYesterdayWithDate:sinceDate])
            
        {//大于24小时也可能是昨天
            
            str = [NSString stringWithFormat:@"昨天"];
            
        }else
            
        {
            
            //在这里大于1天的我们可以以周几的形式显示
            
            if (k>=1)
                
            {
                
                if (k < [self getNowDateWeek])
                    
                {//本周
                    
                    str  = [self weekdayStringFromDate:[self becomeDateStr:timeStr withFormat:format]];
                    
                }else
                    
                {//不是本周
                    
                    //                    str  = [NSString stringWithFormat:@"不是本周%@",[self weekdayStringFromDate:[self becomeDateStr:timeStr]]];
                    
                    str  = timeStr;
                    
                }
                
            }else
                
            {//
                
                str = [NSString stringWithFormat:@"%d天前",i/(3600*24)];
                
            }
            
        }
        
    }
    
    return str;
    
}

//把时间字符串转换成NSDate

+ (NSDate *)becomeDateStr:(NSString *)dateStr withFormat:(NSString *)format

{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (format) {
        [dateFormatter setDateFormat:format];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSDate *date1 = [dateFormatter dateFromString:dateStr];
    
    return date1;
    
}

//把时间转换成星期

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    
    
    //    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"zh-Hans"];
    
    
    
    [calendar setTimeZone: timeZone];
    
    
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

//判断是否为昨天

+ (BOOL)isYesterdayWithDate:(NSDate *)newDate

{
    
    BOOL isYesterday = YES;
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    //
    
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    
    /** 前天判断
     
     //    NSDate *qianToday =  [[NSDate alloc] initWithTimeIntervalSinceNow:-2*secondsPerDay];
     
     //    NSDateComponents* comp3 = [calendar components:unitFlags fromDate:qianToday];
     
     //    if (comp1.year == comp3.year && comp1.month == comp3.month && comp1.day == comp3.day)
     
     //    {
     
     //        dateContent = @"前天";
     
     //    }
     
     **/
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    //    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:newDate];
    
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
    
    
    
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day)
        
    {
        
        isYesterday = YES;
        
    }else
        
    {
        
        isYesterday = NO;
        
    }
    
    return isYesterday;
    
}

//判断今天是本周的第几天

+ (int)getNowDateWeek

{
    
    NSDate *nowDate = [NSDate date];
    
    NSString *nowWeekStr = [self weekdayStringFromDate:nowDate];
    
    int  factWeekDay = 0;
    
    
    
    if ([nowWeekStr isEqualToString:@"周日"])
        
    {
        
        factWeekDay = 7;
        
    }else if ([nowWeekStr isEqualToString:@"周一"])
        
    {
        
        factWeekDay = 1;
        
    }else if ([nowWeekStr isEqualToString:@"周二"])
        
    {
        
        factWeekDay = 2;
        
    }else if ([nowWeekStr isEqualToString:@"周三"])
        
    {
        
        factWeekDay = 3;
        
    }else if ([nowWeekStr isEqualToString:@"周四"])
        
    {
        
        factWeekDay = 4;
        
    }else if ([nowWeekStr isEqualToString:@"周五"])
        
    {
        
        factWeekDay = 5;
        
    }else if ([nowWeekStr isEqualToString:@"周六"])
        
    {
        
        factWeekDay = 6;
        
    }
    
    return  factWeekDay;
    
}

+(NSString*)exchangeToEngMonth:(NSString*)cn
{
    if ([cn isEqualToString:@"01"]) {
        return @"Jan.";
    }else if ([cn isEqualToString:@"02"]) {
        return @"Feb.";
    }else if ([cn isEqualToString:@"03"]) {
        return @"Mar.";
    }else if ([cn isEqualToString:@"04"]) {
        return @"Apr";
    }else if ([cn isEqualToString:@"05"]) {
        return @"May.";
    }else if ([cn isEqualToString:@"06"]) {
        return @"Jun.";
    }else if ([cn isEqualToString:@"07"]) {
        return @"Jul.";
    }else if ([cn isEqualToString:@"08"]) {
        return @"Aug.";
    }else if ([cn isEqualToString:@"09"]) {
        return @"Sep.";
    }else if ([cn isEqualToString:@"10"]) {
        return @"Oct.";
    }else if ([cn isEqualToString:@"11"]) {
        return @"Nov.";
    }else if ([cn isEqualToString:@"12"]) {
        return @"Dec.";
    }
    
    return @"Jan.";
}


+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}
@end
