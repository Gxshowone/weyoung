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

@property(nonatomic,strong) successGetData successBlock;
@property(nonatomic,strong) failureData failureDataBlock;
@property(nonatomic,strong) failureGetData failureBlock;

@property(nonatomic,copy)void(^FiledownloadedTo)(NSURL*);
@property(nonatomic,copy)void(^FileuploadedTo)(id);


//Get请求
-(void)requestDataWithUrl:(NSString*)urlString;
//post请求
-(void)requestDataWithUrl:(NSString*)urlString pragma:(NSDictionary*)pragmaDict;
//带图片Post请求
-(void)requestDataWithUrl:(NSString*)urlString pragma:(NSDictionary*)pragmaDict ImageDatas:(id)data imageName:(id)imageName;
//下载
-(void)startDownloadTaskWithUrl:(NSString*)urlString;
//上传
-(void)startUploadTaskTaskWithUrl:(NSString*)urlString;
//结果回调
-(void)getResultWithSuccess:(successGetData)success DataFaiure:(failureData)datafailure Failure:(failureGetData)failure;

@end

NS_ASSUME_NONNULL_END
