//
//  WYHttpRequest.h
//  weyoung
//
//  Created by gongxin on 2018/12/19.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WYHttpRequest : NSObject


typedef void(^successGetData)(id response);
typedef void(^failureData)(id error);
typedef void(^failureGetData)(id error);

@property(nonatomic,copy) successGetData successBlock;
@property(nonatomic,copy) failureData failureDataBlock;
@property(nonatomic,copy) failureGetData failureBlock;

@property(nonatomic,copy)void(^FiledownloadedTo)(NSURL*);
@property(nonatomic,copy)void(^FileuploadedTo)(id);


//post请求
-(void)requestWithPragma:(NSDictionary*)pragma
             showLoading:(BOOL)show;
//带图片Post请求
-(void)requestWithPragma:(NSDictionary*)pragma
             showLoading:(BOOL)show
              ImageDatas:(id)data
               imageName:(id)imageName;


@end

NS_ASSUME_NONNULL_END
