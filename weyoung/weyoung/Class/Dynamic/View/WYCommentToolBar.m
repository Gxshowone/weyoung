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

@end
@implementation WYCommentToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.textView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(20, 0, KScreenWidth-40,self.height);
    
    
}

-(WYTextView*)textView
{
    if(!_textView)
    {
        _textView = [[WYTextView alloc]init];
        _textView.alwaysBounceVertical = YES ;//垂直方向上有弹簧效果
        _textView.delegate = self;
        _textView.placeholder = @"输入你的评论";
    }
    return _textView;
}


@end
