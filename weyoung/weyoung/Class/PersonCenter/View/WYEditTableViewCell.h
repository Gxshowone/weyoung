//
//  WYEditTableViewCell.h
//  weyoung
//
//  Created by gongxin on 2018/12/8.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYEditTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL canEdit;
-(void)setTitle:(NSString*)text;
-(void)setContent:(NSString*)text;
-(NSString*)inputText;
-(void)stopEdit;


@end

NS_ASSUME_NONNULL_END
