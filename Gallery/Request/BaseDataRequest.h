//
//  BaseDataRequest.h
//  NBox
//
//  Created by 安东 on 2018/9/13.
//  Copyright © 2018年 安东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetRequestClass.h"

typedef void (^ReturnValueBlock)(id returnValue);
typedef void (^ErrorCodeBlock)(id errorCode);
typedef void (^ProgressBlock)(id progress);
typedef void (^FailureBlock)(void);
typedef void (^NetWorkBlock)(BOOL netConnetState);
typedef void (^successReturnBlock)(id returnValue);

@interface BaseDataRequest : NSObject

@property (copy, nonatomic) ReturnValueBlock  returnBlock;
@property (copy, nonatomic) ErrorCodeBlock    errorBlock;
@property (copy, nonatomic) FailureBlock      failureBlock;
@property (copy, nonatomic) ProgressBlock     progressBlock;


- (void)netRequestWithMethodType:(RequestMethodType)methodType
                       URLString:(NSString *)URLString
                          params:(NSDictionary *)params
                    successBlock:(successReturnBlock)block;

- (void)netRequestUploadImageWithURLString:(NSString *)URLString
                                    params:(NSDictionary *)params
                                      name:(NSString *)name
                               imagesArray:(NSArray *)images
                              successBlock:(successReturnBlock)block;
// 传入交互的Block块
-(void)setBlockWithReturnBlock:(ReturnValueBlock)returnBlock
                WithErrorBlock:(ErrorCodeBlock)errorBlock
              WithFailureBlock:(FailureBlock)failureBlock;

- (void)setBlockWithProgressBlock:(ProgressBlock)progressBlock;

@end
