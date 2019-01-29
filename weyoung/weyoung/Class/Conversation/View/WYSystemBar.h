//
//  WYSystemBar.h
//  weyoung
//
//  Created by gongxin on 2019/1/29.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYSystemBar : UIView

@property(nonatomic,strong)UIButton * backButton;
-(void)updateTitle:(NSString*)title;
@end

NS_ASSUME_NONNULL_END
