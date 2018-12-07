//
//  WYPhoneInputView.m
//  weyoung
//
//  Created by gongxin on 2018/12/7.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYPhoneInputView.h"
#import "WYTextField.h"
@interface WYPhoneInputView ()<UITextFieldDelegate>

@property(nonatomic,strong)UIButton * areaButton;
@property(nonatomic,strong)UIView   * line;
@property(nonatomic,strong)WYTextField * textField;

@end
@implementation WYPhoneInputView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.layer.cornerRadius = 26.94;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.15].CGColor;
        
        [self addSubview:self.areaButton];
        [self addSubview:self.line];
        [self addSubview:self.textField];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.line.frame = CGRectMake(73.8, 12, 1, 26);
    self.areaButton.frame = CGRectMake(0,0, 74, 50);
    self.textField.frame = CGRectMake(95,0,self.width-150, 50);

}

-(UIButton*)areaButton
{
    if (!_areaButton) {
        _areaButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_areaButton setTitle:@"+86" forState:UIControlStateNormal];
        [_areaButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _areaButton.titleLabel.font = [UIFont fontWithName:TextFontName size:16];
        
        @weakify(self);
        [[_areaButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            NSLog(@"[gx] _areaButton click");
        }];
    }
    return _areaButton;
}

-(UIView*)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.3];
    
    }
    return _line;
}

-(WYTextField*)textField
{
    if (!_textField) {
        _textField = [[WYTextField alloc]init];
        _textField.placeholder = @"输入手机号";
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
