//
//  WYComposePhotosView.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WYComposePhotosViewBlock)(NSInteger count);

@interface WYComposePhotosView : UIView

@property(nonatomic,copy)WYComposePhotosViewBlock block;

-(void)setData:(NSMutableArray*)array;

-(BOOL)hasImage;

@end

NS_ASSUME_NONNULL_END
