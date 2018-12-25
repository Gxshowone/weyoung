//
//  WYConversationViewController.m
//  weyoung
//
//  Created by gongxin on 2018/12/21.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYConversationViewController.h"
#import "WYConversationBar.h"
#import <IQKeyboardManager.h>

#define kInputBarHeight 49.5

@interface WYConversationViewController ()

@property(nonatomic,strong)WYConversationBar * navigationBar;

@end

@implementation WYConversationViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [IQKeyboardManager sharedManager].enable = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
      [IQKeyboardManager sharedManager].enable = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self rongCloudCustomUI];
  
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    [self customFrame];
}


-(void)customFrame
{
    self.conversationMessageCollectionView.height = KScreenHeight - KNaviBarHeight - KTabbarSafeBottomMargin-kInputBarHeight;
    self.chatSessionInputBarControl.frame=  CGRectMake(0, KScreenHeight-kInputBarHeight-KTabbarSafeBottomMargin, KScreenWidth,kInputBarHeight+KTabbarSafeBottomMargin);
    self.chatSessionInputBarControl.additionalButton.x = 2;
    self.chatSessionInputBarControl.additionalButton.y = 2;
    self.chatSessionInputBarControl.additionalButton.width = 45;
    self.chatSessionInputBarControl.additionalButton.height = 45;
    
    self.chatSessionInputBarControl.switchButton.x = CGRectGetMaxX(self.chatSessionInputBarControl.additionalButton.frame)+2;
    self.chatSessionInputBarControl.switchButton.y = 2;
    self.chatSessionInputBarControl.switchButton.width = 45;
    self.chatSessionInputBarControl.switchButton.height = 45;
    
    self.chatSessionInputBarControl.inputTextView.x =CGRectGetMaxX(self.chatSessionInputBarControl.switchButton.frame)+2;

    self.chatSessionInputBarControl.inputTextView.y = 6;
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.navigationBar];
}

-(void)rongCloudCustomUI
{
    [self customCollectionView];
    [self customInputBar];
    
}

-(void)customCollectionView
{
    self.conversationMessageCollectionView.backgroundColor = [UIColor blackColor];

}

-(void)customInputBar
{
   
    //输入框区域
    self.chatSessionInputBarControl.backgroundColor = [[UIColor binaryColor:@"FFFFFF"] colorWithAlphaComponent:0.07];
    
    self.chatSessionInputBarControl.inputTextView.backgroundColor = [UIColor clearColor];
    self.chatSessionInputBarControl.inputTextView.textColor = [UIColor binaryColor:@"FFFFFF"];
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:2];
    
    
    self.chatSessionInputBarControl.emojiButton.hidden = YES;
    
    [self.chatSessionInputBarControl.additionalButton setImage:[UIImage imageNamed:@"conversation_input_photo"] forState:UIControlStateNormal];
    [self.chatSessionInputBarControl.additionalButton setImage:[UIImage imageNamed:@"conversation_input_photo"] forState:UIControlStateHighlighted];
    
    [self.chatSessionInputBarControl.switchButton setImage:[UIImage imageNamed:@"conversation_input_voice"] forState:UIControlStateNormal];
    
   
    @weakify(self);
    [[self.chatSessionInputBarControl.switchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
 
        [self chatSessionInputBarStatusChanged:self.chatSessionInputBarControl.currentBottomBarStatus];
  
    }];

}



- (void)keyboardAction:(NSNotification*)sender{
     // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
       
      }else{
    
      }
 }


- (void)chatSessionInputBarStatusChanged:(KBottomBarStatus)bottomBarStatus
{
    switch (bottomBarStatus) {
            
        case KBottomBarDefaultStatus:
        {
            
            
        }
            break;
        case KBottomBarKeyboardStatus:
        {
            [self.chatSessionInputBarControl.switchButton setImage:[UIImage imageNamed:@"conversation_input_keyboard"] forState:UIControlStateNormal];
        }
            break;
        case KBottomBarPluginStatus:
        {
            
            
        }
            break;
        case KBottomBarRecordStatus:
        {
            NSLog(@"[gx] record");
             [self.chatSessionInputBarControl.switchButton setImage:[UIImage imageNamed:@"conversation_input_keyboard"] forState:UIControlStateNormal];
            
            self.chatSessionInputBarControl.recordButton.x = CGRectGetMaxX(self.chatSessionInputBarControl.switchButton.frame)+2;

        
        }
            
            break;
            
        default:
            break;
    }
}


-(WYConversationBar*)navigationBar
{
    if (!_navigationBar) {
        _navigationBar = [[WYConversationBar alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, KNaviBarHeight)];
         @weakify(self);
        [[_navigationBar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
    }
    return _navigationBar;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
