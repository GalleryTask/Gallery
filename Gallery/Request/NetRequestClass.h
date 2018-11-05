//
//  NetRequestClass.h
//  Tourmaline
//
//  Created by dongan on 17/2/20.
//  Copyright © 2017年 dongan. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求成功回调
typedef void(^RequestManagerSuccessHandle)(NSURLSessionTask *task, id response);

// 请求失败回调
typedef void(^RequestManagerFailureHandle)(NSURLSessionTask *task, NSError *error);

// 进度回调
typedef void (^RequestManagerProgressHandle)(NSProgress * _Nonnull);

// 请求方式
typedef enum : NSUInteger {
  
  // GET请求
  RequestMethodTypeGET,
  
  // POST请求
  RequestMethodTypePOST,
  
  // PUT请求
  RequestMethodTypePUT,
  
  // DELETE请求
  RequestMethodTypeDELETE,
  
  // PATCH请求
  RequestMethodTypePATCH,
  
  // HEAD请求
  RequestMethodTypeHEAD
  
} RequestMethodType;


@interface NetRequestClass : NSObject

#pragma mark - 检测网络的可链接性
+ (BOOL) netWorkReachability;

/**
 请求数据

 @param methodType 请求方式
 @param URLString URL地址
 @param params 参数
 @param successHandle 正确回调
 @param failureHandle 失败回调
 */
+ (void)netRequestWithMethodType:(RequestMethodType)methodType
                       URLString:(NSString *)URLString
                          params:(NSDictionary *)params
                   successHandle:(RequestManagerSuccessHandle)successHandle
                   failureHandle:(RequestManagerFailureHandle)failureHandle;


/**
 上传图片
 
 @param URLString 请求地址
 @param params 参数
 @param name 服务器名字
 @param images 图片文件数组
 @param successHandle 正确回调
 @param failureHandle 失败回调
 */
+ (void)netRequestPOSTImageWithURLString:(NSString *)URLString
                                  params:(NSDictionary *)params
                                    name:(NSString *)name
                             imagesArray:(NSArray *)images
                           successHandle:(RequestManagerSuccessHandle)successHandle
                           failureHandle:(RequestManagerFailureHandle)failureHandle ;



/**
 上传视频
 
 @param URLString 请求地址
 @param params 参数
 @param filePathURL 视频路径
 @param successHandle 正确回调
 @param failureHandle 失败回调
 @param progressHandle 进度回调
 */
+ (void)netRequestPOSTVideoWithURLString:(NSString *)URLString
                                  params:(NSDictionary *)params
                             filePathURL:(NSURL *)filePathURL
                           successHandle:(RequestManagerSuccessHandle)successHandle
                           failureHandle:(RequestManagerFailureHandle)failureHandle
                           progressBlock:(RequestManagerProgressHandle)progressHandle;


/**
 下载文件

 @param URLString 请求地址
 @param successHandle 正确回调
 */
+ (void)netRequestDownloadFileWithURLString:(NSString *)URLString successHandle:(RequestManagerSuccessHandle)successHandle;
@end
