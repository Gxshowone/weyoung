//
//  WYCommentToolBar.m
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCommentToolBar.h"
#import "WYTextView.h"
@interface WYCommentToolBar()<UITextViewDelegate>
@property (nonatomic,strong) WYTextView  * textView;
@property (nonatomic,strong)UIButton * sendButton;

@end
@implementation WYCommentToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.textView];
        [self addSubview:self.sendButton];
        self.sendButton.hidden = YES;
        self.sendButton.userInteractionEnabled = NO;
        self.sendButton.alpha = 0.3;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(20, 0, KScreenWidth-58-40,self.height);
    self.sendButton.frame = CGRectMake(KScreenWidth-58, 0, 58, 44);
    
}
-(void)beginEdit
{
    [self.textView becomeFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.sendButton.hidden = NO;
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.sendButton.hidden = YES;
}

-(WYTextView*)textView
{
    if(!_textView)
    {
        _textView = [[WYTextView alloc]init];
        _textView.alwaysBounceVertical = YES ;//垂直方向上有弹簧效果
        _textView.delegate = self;
        _textView.placeholder = @"输入你的评论";
        
        @weakify(self);
        [_textView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            NSLog(@"%@",x);
            @strongify(self);
            
            self.sendButton.alpha = (IsStrEmpty(x))?0.3:1.0;
            self.sendButton.userInteractionEnabled = (IsStrEmpty(x))?NO:YES;
            
        }];
    }
    return _textView;
}

-(UIButton*)sendButton
{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont fontWithName:TextFontName_Light size:14];
        @weakify(self);
        [[_sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            
            [self.textView resignFirstResponder];
            
            if (self.delegate) {
                [self.delegate sendCommon:self.textView.text];
            }
        }];
    }
    return _sendButton;
}

@end
