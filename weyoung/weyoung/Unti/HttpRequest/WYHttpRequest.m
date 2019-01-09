//
//  WYHttpRequest.m
//  weyoung
//
//  Created by gongxin on 2018/12/19.
//  Copyright © 2018 SouYu. All rights reserved.
//

#import "WYHttpRequest.h"
#import "NSString+AES.h"
@implementation WYHttpRequest


//不带图片post请求
-(void)requestWithPragma:(NSDictionary*)pragma
             showLoading:(BOOL)show
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@",MainURL];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:[self pragmaExchangeToBody:pragma]];
    
    NSString * token = [WYSession sharedSession].token;
    if (token) {
       [request setValue:token forHTTPHeaderField:@"X-LOGON-TOKEN"];
        
    }
    
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    
   
    [[manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSData * data = [NSData dataWithData:responseObject];
        NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString * result = [str aci_decryptWithAES];
        NSDictionary * dict = [self dictionaryWithJsonString:result];
        NSInteger status = [[dict valueForKey:@"status"] integerValue];
   
        switch (status) {
            case 200:
            {
                NSDictionary *obj = [dict valueForKey:@"data"];
                self.successBlock(obj);
            }
                break;
                case 300:
            {
                NSString * msg  = [dict valueForKey:@"msg"];
                self.failureDataBlock(msg);
                
            }
                break;
            default:
                break;
        }
        
    }] resume];
    
    
}



-(void)put_uploadFileWithURLString:(NSString *)URLString
                            rename:(id)rename
                        orFromData:(id)bodyData
{
    NSMutableURLRequest * request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:URLString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       
        
        if(bodyData==nil) return ;
        else if([bodyData isKindOfClass:[NSData class]]){
            [formData appendPartWithFileData:bodyData name:rename fileName:@"defult_placeImage.png" mimeType:@"png"];
        }else if([bodyData isKindOfClass:[NSMutableArray class]]){
            //多张图片上传
            [bodyData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSData *imgData = (NSData *)obj;
                NSString *imgKey = [rename isKindOfClass:[NSString class]]?rename:rename[idx];
                [formData appendPartWithFileData:imgData name:imgKey fileName:@"defult_placeImage.png" mimeType:@"png"];
            }];
        }
        
    } error:nil];


    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"[gx] 上传进度 %@",uploadProgress);
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
    }] resume] ;
}



-(NSData*)pragmaExchangeToBody:(NSDictionary*)pragma
{
    //1 json 转字符串
    NSString * pStr = [self convertToJsonData:pragma];
    
    //2 字符串加密
    NSString * aes  = [pStr aci_encryptWithAES];
    
    //3 字符串转字典
    NSData *data =[aes dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

//json 转串
-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}


-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
