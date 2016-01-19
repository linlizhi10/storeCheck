// AFHTTPRequestOperation.m
// Copyright (c) 2011–2015 Alamofire Software Foundation (http://alamofire.org/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
static dispatch_queue_t http_request_operation_processing_queue() {
    static dispatch_queue_t af_http_request_operation_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_http_request_operation_processing_queue = dispatch_queue_create("com.alamofire.networking.http-request.processing", DISPATCH_QUEUE_CONCURRENT);
    });

    return af_http_request_operation_processing_queue;
}

static dispatch_group_t http_request_operation_completion_group() {
    static dispatch_group_t af_http_request_operation_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_http_request_operation_completion_group = dispatch_group_create();
    });

    return af_http_request_operation_completion_group;
}

#pragma mark -

@interface AFURLConnectionOperation ()
@property (readwrite, nonatomic, strong) NSURLRequest *request;
@property (readwrite, nonatomic, strong) NSURLResponse *response;
@end

@interface AFHTTPRequestOperation ()
@property (readwrite, nonatomic, strong) NSHTTPURLResponse *response;
@property (readwrite, nonatomic, strong) id responseObject;
@property (readwrite, nonatomic, strong) NSError *responseSerializationError;
@property (readwrite, nonatomic, strong) NSRecursiveLock *lock;
@end

@implementation AFHTTPRequestOperation
@dynamic response;
@dynamic lock;

- (instancetype)initWithRequest:(NSURLRequest *)urlRequest {
    self = [super initWithRequest:urlRequest];
    if (!self) {
        return nil;
    }

    self.responseSerializer = [AFHTTPResponseSerializer serializer];

    return self;
}

- (void)setResponseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *)responseSerializer {
    NSParameterAssert(responseSerializer);

    [self.lock lock];
    _responseSerializer = responseSerializer;
    self.responseObject = nil;
    self.responseSerializationError = nil;
    [self.lock unlock];
}

- (id)responseObject {
    [self.lock lock];
    if (!_responseObject && [self isFinished] && !self.error) {
        NSError *error = nil;
        self.responseObject = [self.responseSerializer responseObjectForResponse:self.response data:self.responseData error:&error];
        if (error) {
            self.responseSerializationError = error;
        }
    }
    [self.lock unlock];

    return _responseObject;
}

- (NSError *)error {
    if (_responseSerializationError) {
        return _responseSerializationError;
    } else {
        return [super error];
    }
}

#pragma mark - AFHTTPRequestOperation

- (void)setCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // completionBlock is manually nilled out in AFURLConnectionOperation to break the retain cycle.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
#pragma clang diagnostic ignored "-Wgnu"
    self.completionBlock = ^{
        if (self.completionGroup) {
            dispatch_group_enter(self.completionGroup);
        }

        dispatch_async(http_request_operation_processing_queue(), ^{
            if (self.error) {
                if (failure) {
                    dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                        NSLog(@"\n[-------failure----[%ld]--]:%@\n\n",[self.error code],self.error);
                        switch ([self.error code]) {
     
                            case kCFURLErrorTimedOut:
                                
//                                [WToast showWithText:@"请求超时,请重试!" forToastType:Error];
                                
                                failure(self,self.error);

                                break;
                                
                            case kCFURLErrorCannotFindHost:
                                
//                                [WToast showWithText:@"找不到服务器,请重试!" forToastType:Error];
                                
                                failure(self,self.error);

                                break;
                                
                            case kCFURLErrorCannotConnectToHost:
                                
//                                [WToast showWithText:MobileErrorMsg forToastType:Error];
                                
                                failure(self,self.error);

                                break;
                                
                            case kCFURLErrorNetworkConnectionLost:
                                
//                                [WToast showWithText:@"网络连接断开,请重试!" forToastType:Error];
                                
                                failure(self,self.error);

                                break;
                                
                            case kCFURLErrorNotConnectedToInternet:
                                
//                                [WToast showWithText:@"请检查设备是否连接互联网" forToastType:Error];
                                
                                failure(self,self.error);
                                
                                break;
                                
                            case kCFURLErrorBadServerResponse:
                                
//                                [WToast showWithText:@"服务器错误,请重试!" forToastType:Error];
                                
                                failure(self,self.error);
                                
                                break;
                                
                            default:
                                
                                failure(self, self.error);
                                
                                break;
                        }
                        
                        
//                        [DejalBezelActivityView removeViewAnimated:YES];
                        
                    });
                }
            } else {
                
                if (self.error) {
                    if (failure) {
                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                            failure(self, self.error);
                        });
                    }
                } else {
                    if (success) {
                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                            //在这里json转对象
                            NSDictionary *resultsDictionary = [ self.responseData objectFromJSONData];
                            NSDictionary *body = [resultsDictionary objectForKey:@"data"];
                            success(self, body);
                            
                        });
                    }
                    
                }
            }

            if (self.completionGroup) {
                dispatch_group_leave(self.completionGroup);
            }
        });
    };
#pragma clang diagnostic pop
}



- (void)setWifiCompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    // completionBlock is manually nilled out in AFURLConnectionOperation to break the retain cycle.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
#pragma clang diagnostic ignored "-Wgnu"
    self.completionBlock = ^{
        if (self.completionGroup) {
            dispatch_group_enter(self.completionGroup);
        }
        
        dispatch_async(http_request_operation_processing_queue(), ^{
            if (self.error) {
                if (failure) {
                    dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                        NSLog(@"\n[-------failure----[%ld]--]:%@\n\n",[self.error code],self.error);
                        
                        failure(self, self.error);
                        
                    });
                }
            } else {
                
//                id responseObject = self.responseObject;
                
                if (self.error) {
                    if (failure) {
                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                            failure(self, self.error);
                        });
                    }
                } else {
                    if (success) {
                        dispatch_group_async(self.completionGroup ?: http_request_operation_completion_group(), self.completionQueue ?: dispatch_get_main_queue(), ^{
                            
                            
                            NSLog(@"\n\n[-------Result----%ld--]:%@--\n----->%@\n\n",[self.response statusCode],self.responseString,self.request);
                            
//                            [UserDefaults setBool:YES forKey:@"isNetWork"];
                            //在这里json转对象
                            NSDictionary *resultsDictionary = [ self.responseData objectFromJSONData];
                            //                    NSDictionary *resultsDictionary = [self.responseString objectFromJSONString];
                            NSDictionary *resultCode =[resultsDictionary objectForKey:@"code"];
                            //    NSString *message= [jsonObject valueForKey:@"message"];
                            NSString *code = [NSString stringWithFormat:@"%@",resultCode];
                            
                            if([code isEqualToString:@"200"]){
                                NSDictionary *body = [resultsDictionary objectForKey:@"data"];
                                
                                success(self, body);
                                
                            }else{
                                
                                NSLog(@"-----[self.response statusCode]---->%@",code);
                                
                                
                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                
                                [dic setValue:[resultsDictionary valueForKey:@"msg"] forKey:@"msg"];
                                
                                [dic setValue:code forKey:@"code"];
                                
                                NSError *aError =   [[NSError alloc] initWithDomain:@"" code:[code intValue] userInfo:dic];
                                
                                failure(self, aError);
                                
                                
                            }
                            
                        });
                    }
                    
                }
            }
            
            if (self.completionGroup) {
                dispatch_group_leave(self.completionGroup);
            }
        });
    };
#pragma clang diagnostic pop
}


#pragma mark - AFURLRequestOperation

- (void)pause {
    [super pause];

    u_int64_t offset = 0;
    if ([self.outputStream propertyForKey:NSStreamFileCurrentOffsetKey]) {
        offset = [(NSNumber *)[self.outputStream propertyForKey:NSStreamFileCurrentOffsetKey] unsignedLongLongValue];
    } else {
        offset = [(NSData *)[self.outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey] length];
    }

    NSMutableURLRequest *mutableURLRequest = [self.request mutableCopy];
    if ([self.response respondsToSelector:@selector(allHeaderFields)] && [[self.response allHeaderFields] valueForKey:@"ETag"]) {
        [mutableURLRequest setValue:[[self.response allHeaderFields] valueForKey:@"ETag"] forHTTPHeaderField:@"If-Range"];
    }
    [mutableURLRequest setValue:[NSString stringWithFormat:@"bytes=%llu-", offset] forHTTPHeaderField:@"Range"];
    self.request = mutableURLRequest;
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (!self) {
        return nil;
    }

    self.responseSerializer = [decoder decodeObjectOfClass:[AFHTTPResponseSerializer class] forKey:NSStringFromSelector(@selector(responseSerializer))];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];

    [coder encodeObject:self.responseSerializer forKey:NSStringFromSelector(@selector(responseSerializer))];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    AFHTTPRequestOperation *operation = [super copyWithZone:zone];

    operation.responseSerializer = [self.responseSerializer copyWithZone:zone];
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;

    return operation;
}

@end
