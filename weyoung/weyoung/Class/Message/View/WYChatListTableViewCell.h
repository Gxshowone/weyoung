//
//  WYChatListTableViewCell.h
//  weyoung
//
//  Created by gongxin on 2019/1/12.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <RongIMKit/RongIMKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYChatListTableViewCell : RCConversationBaseCell

@property(nonatomic, strong) UIImageView *ivAva;
@property(nonatomic, strong) UILabel *lblName;
@property(nonatomic, strong) UILabel *lblDetail;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, strong) UILabel *labelTime;


@end

NS_ASSUME_NONNULL_END
