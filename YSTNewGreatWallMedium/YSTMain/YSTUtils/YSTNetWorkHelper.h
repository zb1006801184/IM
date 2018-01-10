//
//  YSTNetWorkHelper.h
//  YSTNewGreatWallMedium
//
//  Created by 朱标 on 2017/11/21.
//  Copyright © 2017年 zhubiao. All rights reserved.
//

#import <Foundation/Foundation.h>
enum {
    IPHNetWorkHelperOptionUPLOAD = 1, // 上传
    IPHNetWorkHelperOptionGET = 1 << 1, // GET
    IPHNetWorkHelperOptionPOST = 1 << 2, // POST
};
typedef NSInteger IPHNetWorkHelperOption;
@interface YSTNetWorkHelper : NSObject <NSURLConnectionDataDelegate>

+ (instancetype _Nonnull)networkHelper;
/**
 *  统一数据请求借口
 *
 *  @param api            api
 *  @param option         操作方式
 *  @param parameters     GET | POST参数
 *  @param data           上传API的二进制文件
 *  @param key            上传二进制文件的key
 *  @param success        成功
 *  @param failure        失败
 */
- (NSURLSessionDataTask *)callAPI:(NSString * _Nonnull)api
                           option:(IPHNetWorkHelperOption)option
                       parameters:(NSDictionary * _Nullable)parameters
                             data:(NSData * _Nullable)data
                          dataKey:(NSString * _Nullable)key
                         progress:(void (^_Nullable)(NSProgress * _Nullable uploadProgress))progress
                          success:(void(^_Nullable)(id _Nullable responseObject))success
                          failure:(void(^_Nullable)(NSError * _Nonnull error))failure;


- (NSURLSessionDataTask *)Upload:(NSString * _Nonnull)api
                          params:(NSDictionary * _Nullable)params
                            type:(NSString * _Nullable)type
                           thumb:(NSData * _Nullable)thumb key:(NSString * _Nullable)key
                        progress:(void (^ _Nullable)(NSProgress * _Nonnull uploadProgress))progress
                         success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                         failure:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failure;

-(void)uploadFileWithURL:( NSString* )urlString params:( NSDictionary*)params fileKey:( NSString*)fileKey data:( NSData*)data completeHander:(void(^)(NSURLResponse *response, NSData *data, NSError *  connectionError))completeHander;

@end
