//
//  WYNickNameInputView.m
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYNickNameInputView.h"
#import "WYTextField.h"
@interface WYNickNameInputView ()<UITextFieldDelegate>

@property(nonatomic,strong)WYTextField * textField;
@property(nonatomic,strong)UIButton    * randomButton;

@end
@implementation WYNickNameInputView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 26.94;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.15].CGColor;
        [self addSubview:self.textField];
        [self addSubview:self.randomButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textField.frame = CGRectMake(20,0,self.width-70, 50);
    self.randomButton.frame = CGRectMake(self.width-60, 0, 50, 50);
    
}

-(WYTextField*)textField
{
    if (!_textField) {
        _textField = [[WYTextField alloc]init];
        _textField.placeholder = @"设置昵称";
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

-(UIButton*)randomButton
{
    if (!_randomButton) {
        _randomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        @weakify(self);
        [[_randomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
        
            
        }];
    }
    return _randomButton;
}

@end
