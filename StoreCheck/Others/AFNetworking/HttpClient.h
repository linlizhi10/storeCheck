//
//  HttpClient.h
//  Hotspot
//
//  Created by skunk  on 15/7/31.
//  Copyright (c) 2015年 ZhePhone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^sucessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^failureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface HttpClient : NSObject

+ (instancetype)sharedClient;

/**
 *  get method
 *
 *  @param url    url
 *  @param sucess sucess description
 *  @param failed failed description
 */
- (void)getCustom:(NSString *)url
          success:(sucessBlock)sucess
          failure:(failureBlock)failed;

/**
 *  for extentding use
 *
 *  @param url     url description
 *  @param sucess  sucess description
 *  @param failure failure description
 */
- (void)getServerXWifiCustom:(NSString *)url
                 success:(sucessBlock)sucess
                 failure:(failureBlock)failure;


/**
 *  get the token of upload image from qiniu
 *
 *  @param url     url description
 *  @param sucess  sucess description
 *  @param failure
 */

- (void)getQiNiuToken:(NSString *)url
               sucess:(sucessBlock)sucess
              failure:(failureBlock)failure;

/**
 *  upload image
 *
 *  @param url    url description
 *  @param param  param description
 *  @param data   image data
 *  @param type   type description
 *  @param sucess sucess description
 *  @param failed failed description
 */
- (void)post:(NSString *)url
       param:(NSString *)param
  UploadData:(NSData *)data
        type:(NSString*)type
      sucess:(sucessBlock)sucess
     failure:(failureBlock)failed;

/**
 *  post method
 *
 *  @param url     url description
 *  @param obj     obj description
 *  @param sucess  sucess description
 *  @param failure failure description
 */
- (void)post:(NSString *)url
        obj:(id)obj
     success:(sucessBlock)sucess
     failure:(failureBlock)failure;

/**
 *  上传带图片的内容，允许多张图片上传（URL）POST
 *
 *  @param url                 网络请求地址
 *  @param images              要上传的图片数组（注意数组内容需是图片）
 *  @param parameter           图片数组对应的参数
 *  @param parameters          其他参数字典
 *  @param ratio               图片的压缩比例（0.0~1.0之间）
 *  @param succeedBlock        成功的回调
 *  @param failedBlock         失败的回调
 *  @param uploadProgressBlock 上传进度的回调
 */
+ (void)startMultiPartUploadTaskWithURL:(NSString *)url
                           imagesArray:(NSArray *)images
                     parameterOfimages:(NSString *)parameter
                        parametersDict:(NSDictionary *)parameters
                      compressionRatio:(float)ratio
                          succeedBlock:(void(^)(id operation, id responseObject))succeedBlock
                           failedBlock:(void(^)(id operation, NSError *error))failedBlock
                   uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock;


@end
