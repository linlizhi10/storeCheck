//
//  HttpClient.m
//  Hotspot
//
//  Created by skunk  on 15/7/31.
//  Copyright (c) 2015年 ZhePhone. All rights reserved.
//

#import "HttpClient.h"
#import "AFNetworking.h"

@implementation HttpClient

+ (instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    static HttpClient *httpC = nil;
    
    dispatch_once(&onceToken, ^{
        httpC = [[HttpClient alloc] init];
    });
    
    return httpC;
    
}

- (void)getCustom:(NSString *)url
          success:(sucessBlock)sucess
          failure:(failureBlock)failed
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager GET:[self bricolage:url]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             sucess(operation,responseObject);
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             failed(operation,error);
         }];
    
    
    
}

- (void)getServerXWifiCustom:(NSString *)url
                 success:(sucessBlock)sucess
                 failure:(failureBlock)failure
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager GETWifi:[self bricolage:url]
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(operation,responseObject);
    }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];

}

- (void)post:(NSString *)url
       param:(NSString *)param
  UploadData:(NSData *)data
        type:(NSString *)type
      sucess:(sucessBlock)sucess
     failure:(failureBlock)failed
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[self bricolage:url]
       parameters:param
    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data
                                    name:@"file" //接口参数名
                                fileName:@"vim_go.png" //文件名
                                mimeType:type];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failed(operation,error);
    }];

}

- (void)post:(NSString *)url
         obj:(id)obj
     success:(sucessBlock)sucess
     failure:(failureBlock)failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10;

    
    [manager POST:[self bricolage:url]
       parameters:obj
          success:sucess
          failure:failure];
    
    
}
- (void)getQiNiuToken:(NSString *)url sucess:(sucessBlock)sucess failure:(failureBlock)failure
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = 10;

    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    
}
/**
 *  complete the url
 *
 *  @param url half url
 *
 *  @return complete url
 */
- (NSString *)bricolage:(NSString *)url
{
    return @"";
}

+(void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void (^)(id, id))succeedBlock
                           failedBlock:(void (^)(id, NSError *))failedBlock
                   uploadProgressBlock:(void (^)(float, long long, long long))uploadProgressBlock{
    
    if (images.count == 0) {
        NSLog(@"上传内容没有包含图片");
        return;
    }
    for (int i = 0; i < images.count; i++) {
        if (![images isKindOfClass:[UIImage class]]) {
            NSLog(@"images中第%d个元素不是UIImage对象",i+1);
            return;
        }
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperation *operation = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
            if (ratio > 0.0f && ratio < 1.0f) {
                imageData = UIImageJPEGRepresentation(image, ratio);
            }else{
                imageData = UIImageJPEGRepresentation(image, 1.0f);
            }
            
            [formData appendPartWithFileData:imageData name:parameter fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        } } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            succeedBlock(operation,responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            failedBlock(operation,error);
            
        }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat percent = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
        uploadProgressBlock(percent,totalBytesWritten,totalBytesExpectedToWrite);
    }];
    
}

@end
