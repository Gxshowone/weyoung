//
//  WYTextField.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYTextField.h"

@implementation WYTextField

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.keyboardType = UIKeyboardTypePhonePad;
        self.returnKeyType = UIReturnKeyDefault;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textColor = [UIColor binaryColor:@"FFFFFF"];
        self.tintColor = [UIColor binaryColor:@"6060FC"];
    }
    
    return self;
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.3].CGColor);
    
    CGRect inset;
    UIFont * font;
    
    inset = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width , self.bounds.size.height);
    font = [UIFont fontWithName:TextFontName_Light size:16];
    
    [self.placeholder drawInRect:inset withFont:font];
}

@end
