//
//  NetRequestClass.h
//  Tourmaline
//
//  Created by dongan on 17/2/20.
//  Copyright © 2017年 dongan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
  网络请求
 */
@interface NetRequestClass : NSObject

#pragma mark - 检测网络的可链接性
+ (BOOL) netWorkReachability;


#pragma mark - POST请求
+ (void) netRequestPOSTWithRequestURL:(NSString *) requestURLString
                            Parameter: (NSDictionary *) parameter
                     ReturnValueBlock: (ReturnValueBlock) block
                       ErrorCodeBlock: (ErrorCodeBlock) errorBlock
                         FailureBlock: (FailureBlock) failureBlock;

#pragma mark - GET请求
+ (void) netRequestGETWithRequestURL:(NSString *)requestURLString
                           Parameter:(NSDictionary *)parameter
                    ReturnValueBlock:(ReturnValueBlock)block
                      ErrorCodeBlock:(ErrorCodeBlock)errorBlock
                        FailureBlock:(FailureBlock)failureBlock;

#pragma mark - PUT请求
+ (void) netRequestPUTWithRequestURL:(NSString *)requestURLString
                           Parameter:(NSDictionary *)parameter
                    ReturnValueBlock:(ReturnValueBlock)block
                      ErrorCodeBlock:(ErrorCodeBlock)errorBlock
                        FailureBlock:(FailureBlock)failureBlock;

#pragma mark - DELETE请求方式
+ (void) netRequestDELETEWithRequestURL:(NSString *) requestURLString
                              Parameter:(NSDictionary *) parameter
                       ReturnValueBlock:(ReturnValueBlock) block
                         ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                           FailureBlock:(FailureBlock) failureBlock;

#pragma mark - POST image请求方式
/**
 *  上传图片
 *
 *  @param resuestURLString 请求地址
 *  @param parameter        参数
 *  @param name             服务器名字
 *  @param images           图片文件
 *  @param block            正确返回
 *  @param errorBlock       错误返回
 *  @param failureBlock     请求失败
 */
+ (void) netRequestPOSTImageWithRequestURL:(NSString *) resuestURLString
                                 Parameter:(NSDictionary *) parameter
                                      name:(NSString *)name
                               imagesArray:(NSArray *)images
                          ReturnValueBlock:(ReturnValueBlock) block
                            ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                              FailureBlock:(FailureBlock)failureBlock;


#pragma mark - POST 上传视频
+ (void) netRequestPOSTVideoWithRequestURL:(NSString *) resuestURLString
                                 Parameter:(NSDictionary *) parameter
                               filePathURL:(NSURL *)filePathURL
                          ReturnValueBlock:(ReturnValueBlock) block
                            ErrorCodeBlock:(ErrorCodeBlock) errorBlock
                              FailureBlock:(FailureBlock)failureBlock
                             ProgressBlock:(ProgressBlock)progressBlock;
@end
