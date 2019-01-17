//
//  WYCommentModel.h
//  weyoung
//
//  Created by gongxin on 2019/1/3.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYCommentModel : NSObject


@property(nonatomic,copy)NSString *c_header_url;
@property(nonatomic,copy)NSString *c_id;
@property(nonatomic,copy)NSString *c_nick_name;
@property(nonatomic,copy)NSString *c_uid;
@property(nonatomic,copy)NSString *comment;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *d_id;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *header_url;
@property(nonatomic,copy)NSString *nick_name;

@property(nonatomic,copy)NSAttributedString *attributedText;
@property (nonatomic, assign)CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
