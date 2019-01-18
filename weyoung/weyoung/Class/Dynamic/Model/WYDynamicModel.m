//
//  WYDynamicModel.m
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYDynamicModel.h"
#import "NSString+Extension.h"

@implementation WYDynamicModel


-(void)setContent:(NSString *)content
{
    _content = content;

    
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    UIFont *font = [UIFont systemFontOfSize:14.0];
    muStyle.alignment = NSTextAlignmentLeft;//对齐方式
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.content];
    [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.length)];
    [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, attrString.length)];
    
    if ([attrString.string isMoreThanOneLineWithSize:CGSizeMake(KScreenWidth-67-20, CGFLOAT_MAX) font:font lineSpaceing:3.0]) {//margin
        muStyle.lineSpacing = 3.0;//设置行间距离
    }else{
        muStyle.lineSpacing = CGFLOAT_MIN;//设置行间距离
    }
    
    
    self.attributedText = attrString;
    
    //算text的layout
    CGFloat textHeight = [attrString.string boundingRectWithSize:CGSizeMake(KScreenWidth-67-20, CGFLOAT_MAX) font:font lineSpacing:3.0].height+0.5;

    self.textLayout.frameLayout = CGRectMake(67, 63.9, KScreenWidth-67-20, textHeight);
    
    //算九宫格的layout
    CGFloat jgg_Width = KScreenWidth-67-20;
    CGFloat image_Width = jgg_Width;
    CGFloat jgg_height = 0;
    if (IsStrEmpty(self.image)) {
        jgg_height = 0;
    }else
    {
        jgg_height = image_Width;
    }
 
    self.jggLayout.frameLayout =  CGRectMake(self.textLayout.frameLayout.origin.x,63.9 + textHeight+5.5, jgg_Width, jgg_height);
    
    CGFloat rowHeight = 63.9 + textHeight + jgg_height + 5.5 + 20;
    self.rowHeight =rowHeight;
}



-(WYLayout *)textLayout{
    if (_textLayout==nil) {
        _textLayout = [WYLayout new];
    }
    return _textLayout;
}
-(WYLayout *)jggLayout{
    if (_jggLayout==nil) {
        _jggLayout = [WYLayout new];
    }
    return _jggLayout;
}
@end
