//
//  WYCopyLabel.m
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import "WYCopyLabel.h"

@interface WYCopyLabel ()
@property(nonatomic,strong)UIColor *originalColor;
@end

@implementation WYCopyLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
    }
    return self;
}
-(void)setUp{
    
    self.font = [UIFont fontWithName:TextFontName_Light size:15];
    self.textColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressToCopy:)];
    [self addGestureRecognizer:longPress];
}
-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    if (self.originalColor==nil) {
        self.originalColor = backgroundColor;
    }
}
-(void)longPressToCopy:(UILongPressGestureRecognizer *)sender{
    if (sender.state==UIGestureRecognizerStateBegan) {
        [sender.view becomeFirstResponder];
        self.backgroundColor = [UIColor lightGrayColor];
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setTargetRect:sender.view.frame inView:self.superview];
        [menuController setMenuVisible:YES animated:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pasteboardHideNotice:) name:UIMenuControllerWillHideMenuNotification object:nil];
    }else if (sender.state==UIGestureRecognizerStateCancelled){
        
    }else if (sender.state==UIGestureRecognizerStateChanged){
        
    }else if (sender.state==UIGestureRecognizerStateEnded){
        
    }
}
-(void)pasteboardHideNotice:(NSNotification *)obj{
    self.backgroundColor = self.originalColor;
    if (self) {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:UIMenuControllerWillHideMenuNotification object:nil];
    }
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    NSArray* methodNameArr = @[@"copy:"];
    if ([methodNameArr containsObject:NSStringFromSelector(action)]) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

-(void)copy:(id)sender{
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    if (self.tag==1000) {
        if ([self.text containsString:@":"]) {
            NSRange mhRange = [self.text rangeOfString:@":"];
            pasteboard.string = [self.text substringFromIndex:mhRange.location+1];
            pasteboard.string = self.text;
        }else{
            pasteboard.string = self.text;
        }
    }else{
        pasteboard.string = self.text;
    }
}

@end
