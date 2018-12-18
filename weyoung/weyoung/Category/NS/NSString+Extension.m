//
//  NSString+Extension.m
//  weyoung
//
//  Created by gongxin on 2018/12/18.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/*
 m:月份
 d:日期
 */
+(NSString *)getAstroWithMonth:(int)m day:(int)d{
    
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

@end
