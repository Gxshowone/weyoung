//
//  WYMessageHeaderView.h
//  weyoung
//
//  Created by gongxin on 2019/1/10.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WYMessageHeaderViewDelegate <NSObject>

@optional

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface WYMessageHeaderView : UITableView

@property (weak,nonatomic) id<WYMessageHeaderViewDelegate> protocal;


@end

NS_ASSUME_NONNULL_END
