//
//  WYMessageHeaderTableViewCell.h
//  weyoung
//
//  Created by gongxin on 2019/1/12.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYMessageHeaderTableViewCell : UITableViewCell

@property(nonatomic,strong)NSDictionary * data;

//获取系统消息未读数量
-(void)getSystemCount;

@end

NS_ASSUME_NONNULL_END
