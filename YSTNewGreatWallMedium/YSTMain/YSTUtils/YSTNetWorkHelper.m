//
//  YSTNetWorkHelper.m
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import "YSTNetWorkHelper.h"
#import <MobileCoreServices/UTType.h>

@interface YSTNetWorkHelper ()
@property (nonatomic, strong) NSString *serviceAdr;
@property (strong, nonatomic) AFHTTPSessionManager *session;
@end

@implementation YSTNetWorkHelper {
    NSMutableURLRequest *request;
    NSOperationQueue *queue;
    NSURLConnection *_connection;
    NSMutableData *_reveivedData;
}
- (AFHTTPSessionManager *)session {
    if (!_session) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone withPinnedCertificates:[NSSet new]];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        session.securityPolicy = securityPolicy;
        session.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        _session = session;
    }
    return _session;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

// single object mothed
+ (instancetype)networkHelper {
    static YSTNetWorkHelper *networkHelper = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        networkHelper = [[YSTNetWorkHelper alloc] init];
    });
    return networkHelper;
}

- (NSURLSessionDataTask *)callAPI:(NSString * _Nonnull)api
                           option:(IPHNetWorkHelperOption)option
                       parameters:(NSDictionary * _Nullable)parameters
                             data:(NSData * _Nullable)data
                          dataKey:(NSString * _Nullable)key
                         progress:(void (^ _Nullable)(NSProgress * _Nonnull uploadProgress))progress
                          success:(void (^ _Nullable)(id _Nonnull))success
                          failure:(void (^ _Nullable)(NSError * _Nonnull))failure {
    NSString *service;
    self.serviceAdr = YST_API_URLNAME;
        service = [self.serviceAdr stringByAppendingString:api];
    NSLog(@"%@----------%@",service,parameters);
    
//    NSDictionary *dicc = [YSTFileManageTool encryptChangeDic2:parameters AndUrl:api]; //设置部分统一参数
    switch (option) {
        case IPHNetWorkHelperOptionUPLOAD: {
            self.serviceAdr = YST_API_URLNAMEIMAGE;
            NSString *service = [self.serviceAdr stringByAppendingString:api];

            //upload
            return [self Upload:service params:parameters type:@"png" thumb:data key:key progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    progress(uploadProgress);
                }
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"%@",responseObject);
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                failure(error);
            }];
        }
            break;
        case IPHNetWorkHelperOptionGET: {
            //GET
            return [self GETApi:service Parameters:parameters Success:^(id  _Nullable responseObject) {
                success(responseObject);
                NSLog(@"++%@",responseObject);
            } Failure:^(NSError * _Nonnull error) {
                failure(error);
                NSLog(@"error:%@",error);
            }];
        }
            break;
        default: {
            //POST
            return [self POSTApi:service Parameters:parameters Success:^(id  _Nullable responseObject) {
                NSLog(@"++%@",responseObject);
                success(responseObject);
            } Failure:^(NSError * _Nonnull error) {
                failure(error);
                NSLog(@"error:%@",error);
            }];
        }
            break;
    }
    return nil;
}

/**
 *  get 请求
 *
 *  @param api        api
 *  @param parameters get 参数
 */
- (NSURLSessionDataTask *)GETApi:(NSString * _Nonnull)api
                      Parameters:(NSDictionary * _Nullable)parameters
                         Success:(void(^)(id _Nullable responseObject ))success
                         Failure:(void (^)(NSError * _Nonnull error))failure{
    return  [self.session GET:api
                   parameters:parameters
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          success (responseObject);
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          failure (error);
                      }];
}

/**
 *  post请求
 *
 *  @param api        api
 *  @param parameters post 参数
 */
- (NSURLSessionDataTask *)POSTApi:(NSString * _Nonnull)api
                       Parameters:(NSDictionary * _Nullable)parameters
                          Success:(void(^)(id _Nullable responseObject))success
                          Failure:(void (^)(NSError * _Nonnull error))failure {
    //    self.session.requestSerializer = [AFJSONRequestSerializer serializer];
    return [self.session POST:api
                   parameters:parameters
                     progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          success (responseObject);
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          failure(error);
                      }];
}

- (NSURLSessionDataTask *)Upload:(NSString * _Nonnull)api
                          params:(NSDictionary * _Nullable)params
                            type:(NSString * _Nullable)type
                           thumb:(NSData * _Nullable)thumb key:(NSString * _Nullable)key
                        progress:(void (^ _Nullable)(NSProgress * _Nonnull uploadProgress))progress
                         success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure {
    self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    return [self.session POST:api
                   parameters:params
    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.%@", str,type];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:thumb name:key?:@"file" fileName:fileName mimeType:@"application/octet-stream"];
    }
                     progress:^(NSProgress * _Nonnull uploadProgress) {
                         progress(uploadProgress);
                     }
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          success(task, responseObject);
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          failure(task, error);
                      }];
}




-(void)uploadFileWithURL:(NSString *)urlString params:(NSDictionary *)params fileKey:(NSString *)fileKey data:( NSData*)data completeHander:(void (^)(NSURLResponse *, NSData *, NSError *))completeHander{
    
    NSURL *URL = [[NSURL alloc]initWithString:urlString];
    request = [[NSMutableURLRequest alloc]initWithURL:URL cachePolicy:(NSURLRequestUseProtocolCachePolicy) timeoutInterval:30];
    NSString *boundary = @"wfWiEWrgEFA9A78512weF7106A";
    NSData *fileData = data;
    request.HTTPMethod = @"POST";
    request.allHTTPHeaderFields = @{
                                    @"Content-Type":[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary]
                                    };
    
    //multipart/form-data格式按照构建上传数据
    NSMutableData *postData = [[NSMutableData alloc]init];
    for (NSString *key in params) {
        NSString *pair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n",boundary,key];
        [postData appendData:[pair dataUsingEncoding:NSUTF8StringEncoding]];
        
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [postData appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
        }else if ([value isKindOfClass:[NSData class]]){
            [postData appendData:value];
        }
        [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    //文件部分
    NSString *filename = [self cNowTimestamp];
//    NSString *contentType = AFContentTypeForPathExtension([filePath pathExtension]);
    
    NSString *filePair = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"; filename=\"%@.png\";Content-Type=image/png\r\n\r\n",boundary,fileKey,filename];
    [postData appendData:[filePair dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:fileData]; //加入文件的数据
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    request.HTTPBody = postData;
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [_connection start];
}

static inline NSString * AFContentTypeForPathExtension(NSString *extension) {
#ifdef __UTTYPE__
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
#else
#pragma unused (extension)
    return @"application/octet-stream";
#endif
}

- (NSString *)cNowTimestamp{
    NSDate *newDate = [NSDate date];
    long int timeSp = (long)[newDate timeIntervalSince1970];
    NSString *tempTime = [NSString stringWithFormat:@"%ld",timeSp];
    return tempTime;
}

#pragma mark - connection delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"reveive Response:\n%@",response);
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (!_reveivedData) {
        _reveivedData = [[NSMutableData alloc]init];
    }
    
    [_reveivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"received Data:\n%@",[[NSString alloc] initWithData:_reveivedData encoding:NSUTF8StringEncoding]);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

}

@end
