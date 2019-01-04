//
//  WYComposeCollectionViewCell.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYAssets.h"
NS_ASSUME_NONNULL_BEGIN

@interface WYComposeCollectionViewCell : UICollectionViewCell

@property (nonatomic , strong) UIButton *deletePhotoButton;
@property (nonatomic , strong) NSIndexPath *indexpath;
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , strong) WYAssets *asset;

@end

NS_ASSUME_NONNULL_END
