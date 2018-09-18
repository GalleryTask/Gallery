//
//  NetRequestClass.m
//  Tourmaline
//
//  Created by dongan on 17/2/20.
//  Copyright © 2017年 dongan. All rights reserved.
//

#import "NetRequestClass.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *manager;
@implementation NetRequestClass

#pragma mark - 检测网络的可链接性
+ (BOOL) netWorkReachability {
  __block BOOL netState = NO;
  
  // 监控网络状态变化
  NSOperationQueue *operationQueue = manager.operationQueue;
  [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    switch (status) {
      case AFNetworkReachabilityStatusReachableViaWWAN:
      case AFNetworkReachabilityStatusReachableViaWiFi:
        [operationQueue setSuspended:NO];
        break;
      case AFNetworkReachabilityStatusNotReachable:
      default:
        [operationQueue setSuspended:YES];
        break;
    }
  }];
  
  [manager.reachabilityManager startMonitoring];
  
  return netState;
}

#pragma mark - 网络请求配置
+ (void)setManager {
  if (!manager) {
    manager = [AFHTTPSessionManager manager];
    // 申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 申明请求的数据是json类型
    manager.requestSerializer  = [AFJSONRequestSerializer serializer];
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json", @"text/javascript",@"text/html",
                                                         @"text/plain",@"text/xml", nil];
    // 设置网络超时时间为30s，默认为60s
    manager.requestSerializer.timeoutInterval = 30.f;
    // 采用https请求
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
  }
}

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
                   failureHandle:(RequestManagerFailureHandle)failureHandle {
  [NetRequestClass setManager];
  URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

  switch (methodType) {
    case RequestMethodTypeGET: [manager GET:URLString parameters:params progress:nil success:successHandle failure:failureHandle]; break;
    case RequestMethodTypePOST: [manager POST:URLString parameters:params progress:nil success:successHandle failure:failureHandle]; break;
    case RequestMethodTypePUT: [manager PUT:URLString parameters:params success:successHandle failure:failureHandle]; break;
    case RequestMethodTypePATCH: [manager PATCH:URLString parameters:params success:successHandle failure:failureHandle]; break;
    case RequestMethodTypeDELETE: [manager DELETE:URLString parameters:params success:successHandle failure:failureHandle]; break;
    case RequestMethodTypeHEAD: [manager HEAD:URLString parameters:params success:^(NSURLSessionDataTask * _Nonnull task) {
      !successHandle ?: successHandle(task, nil);
    } failure:failureHandle];break;
  }
}


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
                           failureHandle:(RequestManagerFailureHandle)failureHandle  {
  [NetRequestClass setManager];
  [manager POST:URLString
     parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       for (UIImage *image in images) {
         // 设置时间格式(给个时间便于区分)
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         formatter.dateFormat = @"yyyyMMddHHmmss";
         NSString *fileName = [formatter stringFromDate:[NSDate date]];
         NSData *imageData;
         if (UIImagePNGRepresentation(image) == nil) {
           imageData = UIImageJPEGRepresentation(image, 1);
         } else {
           imageData = UIImagePNGRepresentation(image);
         }
         [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/png"];
       }
     } progress:^(NSProgress * _Nonnull uploadProgress) {
     } success:successHandle failure:failureHandle];
}

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
                           progressBlock:(RequestManagerProgressHandle)progressHandle {
  [NetRequestClass setManager];
  [manager POST:URLString
     parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
       // 设置时间格式(给个时间便于区分)
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       formatter.dateFormat = @"yyyyMMddHHmmss";
       NSString *fileName = [formatter stringFromDate:[NSDate date]];
       [formData appendPartWithFileURL:filePathURL name:@"name" fileName:fileName mimeType:@"application/octet-stream" error:nil];
     } progress:progressHandle success:successHandle failure:failureHandle];
}


@end
