//
//  WYCodeInputView.m
//  weyoung
//
//  Created by gongxin on 2018/12/19.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYCodeInputView.h"
#import "WYTextField.h"

@interface WYCodeInputView ()<UITextFieldDelegate>

@property(nonatomic,strong)WYTextField * textField;
@property(nonatomic,strong)UIView      * lineView;


@end
@implementation WYCodeInputView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 26.94;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.15].CGColor;
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        [self addSubview:self.codeButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(20,0,self.width-140, 50);
    self.lineView.frame = CGRectMake(self.width-120, 12, 1, 26);
    self.codeButton.frame = CGRectMake(self.width-120, 0, 120, 50);
 
}

-(WYTextField*)textField
{
    if (!_textField) {
        _textField = [[WYTextField alloc]init];
        _textField.placeholder = @"输入密码";
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

-(UIView*)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    }
    return _lineView;
}

-(UIButton*)codeButton
{
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton setTitle:@"验证码登录" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont fontWithName:TextFontName size:16];
       
    }
    return _codeButton;
}

-(NSString*)inputText
{
    return self.textField.text;
}



@end
