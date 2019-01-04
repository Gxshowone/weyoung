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

@property(nonatomic,assign)BOOL isFriend;

@property(nonatomic,assign)BOOL isLike;

@property (nonatomic,assign)BOOL isExpand;

@property(nonatomic,copy)NSString *dynamicId; //发布者id

@property(nonatomic,copy)NSString *dynamicUserId; //发布者id

@property(nonatomic,copy)NSString *dynamicUserName; //发布者昵称

@property(nonatomic,copy)NSString *dynamicAvatar;//发布者头像

@property(nonatomic,copy)NSString *dynamicTime; //动态时间

@property(nonatomic,copy)NSString *dynamicText; 

@property(nonatomic,copy)NSAttributedString *attributedText;

@property(nonatomic,strong)NSMutableArray *picArray;

@property (nonatomic, assign)CGFloat rowHeight;

///发布文字的布局
@property (nonatomic, strong) WYLayout *textLayout;
///九宫格的布局
@property (nonatomic, strong) WYLayout *jggLayout;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
