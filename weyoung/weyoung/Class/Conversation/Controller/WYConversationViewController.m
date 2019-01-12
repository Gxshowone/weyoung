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

  
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

}

-(void)initUI
{
    self.view.backgroundColor = [UIColor blackColor];
    self.conversationMessageCollectionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.navigationBar];
}

- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell

                   atIndexPath:(NSIndexPath *)indexPath

{

    
    if ([cell isMemberOfClass:[RCTextMessageCell class]]) {
        
        RCTextMessageCell *textCell=(RCTextMessageCell *)cell;
        
        //      自定义气泡图片的适配
        
        UIImage *image=textCell.bubbleBackgroundView.image;
        
        textCell.bubbleBackgroundView.image=[textCell.bubbleBackgroundView.image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.8,image.size.height * 0.2, image.size.width * 0.2)];
        
        //      更改字体的颜色
        
        textCell.textLabel.textColor=[UIColor whiteColor];
        
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
