//
//  WYDynamicModel.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WYLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYDynamicModel : NSObject


@property(nonatomic,assign)NSInteger praise_count; //点赞数

@property(nonatomic,copy)NSString * uid; //发布者id

@property(nonatomic,assign)NSInteger type; //动态类型

@property(nonatomic,copy)NSString *d_id; //动态id

@property(nonatomic,copy)NSString *nick_name; //发布者昵称

@property(nonatomic,copy)NSString *header_url;//发布者头像

@property(nonatomic,copy)NSString * create_time; //动态时间

@property(nonatomic,copy)NSString * content; //动态详情

@property(nonatomic,copy)NSAttributedString *attributedText;

@property(nonatomic,copy)NSString * image;

@property (nonatomic, assign)CGFloat rowHeight;

///发布文字的布局
@property (nonatomic, strong) WYLayout *textLayout;
///九宫格的布局
@property (nonatomic, strong) WYLayout *jggLayout;


@end

NS_ASSUME_NONNULL_END
