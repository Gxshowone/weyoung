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

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
    
     
        NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
        UIFont *font = [UIFont systemFontOfSize:14.0];
        muStyle.alignment = NSTextAlignmentLeft;//对齐方式
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.dynamicText];
        [attrString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attrString.length)];
        [attrString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, attrString.length)];
        
        if ([attrString.string isMoreThanOneLineWithSize:CGSizeMake(KScreenWidth-kGAP-kAvatar_Size-2*kGAP, CGFLOAT_MAX) font:font lineSpaceing:3.0]) {//margin
            muStyle.lineSpacing = 3.0;//设置行间距离
        }else{
            muStyle.lineSpacing = CGFLOAT_MIN;//设置行间距离
        }
        
        
        self.attributedText = attrString;
        
        //算text的layout
        CGFloat textHeight = [attrString.string boundingRectWithSize:CGSizeMake(KScreenWidth-kGAP-kAvatar_Size-2*kGAP, CGFLOAT_MAX) font:font lineSpacing:3.0].height+0.5;
        
        self.textLayout.frameLayout = CGRectMake(kGAP+kAvatar_Size+kGAP, kGAP+kAvatar_Size/2+2, KScreenWidth-2*kGAP-kAvatar_Size-kGAP, textHeight);
        
        //算九宫格的layout
        CGFloat jgg_Width = KScreenWidth-2*kGAP-kAvatar_Size-50;
        CGFloat image_Width = (jgg_Width-2*kGAP)/3;
        CGFloat jgg_height = 0;
        if (self.picArray.count==0) {
            jgg_height = 0;
        }else if (self.picArray.count<=3) {
            jgg_height = image_Width;
        }else if (self.picArray.count>3&&self.picArray.count<=6){
            jgg_height = 2*image_Width+kGAP;
        }else  if (self.picArray.count>6&&self.picArray.count<=9){
            jgg_height = 3*image_Width+2*kGAP;
        }
        
        self.jggLayout.frameLayout =  CGRectMake(self.textLayout.frameLayout.origin.x, CGRectGetMaxY(self.textLayout.frameLayout)+kGAP, jgg_Width, jgg_height);
        
        self.rowHeight = CGRectGetMaxY(self.jggLayout.frameLayout)+kGAP;
    }
    return self;
}

-(NSMutableArray*)picArray
{
    if (!_picArray) {
        _picArray = [NSMutableArray array];
    }
    return _picArray;
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
