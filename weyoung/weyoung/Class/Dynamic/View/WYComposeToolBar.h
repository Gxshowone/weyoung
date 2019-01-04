//
//  WYComposeToolBar.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYComposeToolBar : UIView

@property (nonatomic ,strong) UIButton * photoButton;

-(void)updateCount:(NSString*)count;

@end

NS_ASSUME_NONNULL_END
