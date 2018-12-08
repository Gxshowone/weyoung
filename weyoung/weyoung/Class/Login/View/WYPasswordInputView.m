//
//  WYPasswordInputView.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPasswordInputView.h"
#import "WYTextField.h"
@interface WYPasswordInputView ()<UITextFieldDelegate>

@property(nonatomic,strong)WYTextField * textField;

@end
@implementation WYPasswordInputView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 26.94;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.15].CGColor;
        [self addSubview:self.textField];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(20,0,self.width-70, 50);
 
}

-(WYTextField*)textField
{
    if (!_textField) {
        _textField = [[WYTextField alloc]init];
        _textField.placeholder = @"设置密码";
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypePhonePad;
        @weakify(self);
        [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            NSLog(@"%@",x);
            @strongify(self);
        }];
    }
    return _textField;
    
}

@end
