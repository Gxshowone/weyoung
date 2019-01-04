//
//  WYAssets.h
//  weyoung
//
//  Created by gongxin on 2019/1/2.
//  Copyright © 2019 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYAssets : NSObject

@property (nonatomic, strong) NSString  *groupPropertyID;
@property (nonatomic, strong) NSURL     *groupPropertyURL;
@property (nonatomic, strong) NSURL     *assetPropertyURL;
@property (nonatomic, strong) UIImage   *photo;

@end

NS_ASSUME_NONNULL_END
