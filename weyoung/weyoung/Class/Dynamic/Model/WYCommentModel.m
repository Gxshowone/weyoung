//
//  WYCommentModel.m
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCommentModel.h"
#import "NSString+Extension.h"

@implementation WYCommentModel


-(void)setComment:(NSString *)comment
{
    _comment = comment;
    

    NSString *str  = nil;

    if (IsStrEmpty(self.c_uid)) {
        
        str= [NSString stringWithFormat:@"%@",_comment];
        
    }else{
        str= [NSString stringWithFormat:@"回复 :%@ %@",
             self.nick_name, _comment];
    }
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    
    if ([str containsString:@"回复"]) {
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor whiteColor]
                     range:NSMakeRange(4, self.nick_name.length)];
    }
   
    UIFont *font = [UIFont fontWithName:TextFontName_Light size:15];
    
    [text addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if ([text.string isMoreThanOneLineWithSize:CGSizeMake(KScreenWidth-68-20, CGFLOAT_MAX) font:font lineSpaceing:3.0]) {//margin
        style.lineSpacing = 3;
    }else{
        style.lineSpacing = CGFLOAT_MIN;
    }
    
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.string.length)];
    
    
    self.rowHeight = [text.string boundingRectWithSize:CGSizeMake(KScreenWidth-68-20, CGFLOAT_MAX) font:font lineSpacing:3.0].height+53;//5.0为最后一行行间距
    self.attributedText = text;
}
@end
