//
//  BaseDataRequest.m
//  NBox
//
//  Created by 安东 on 2018/9/13.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "BaseDataRequest.h"


@interface BaseDataRequest ()

@property (copy,   nonatomic) successReturnBlock  successBlock;

@end

@implementation BaseDataRequest

/**
 发送请求

 @param methodType 请求类型
 @param URLString URL地址
 @param params 参数
 @param block 正确回调
 */
- (void)netRequestWithMethodType:(RequestMethodType)methodType
                       URLString:(NSString *)URLString
                          params:(NSDictionary *)params
                    successBlock:(successReturnBlock)block {
  URLString = [BASE_URL stringByAppendingString:URLString];
  [NetRequestClass netRequestWithMethodType:methodType URLString:URLString params:params successHandle:^(NSURLSessionTask *task, id response) {
    [self successWithResponse:response block:block];
  } failureHandle:^(NSURLSessionTask *task, NSError *error) {
    NSLog(@"%@",error);
    [CommonUtil promptViewWithText:@"没有网络连接，请稍后再试" view:ROOTVIEW hidden:YES];
    self.failureBlock();
  }];
}


/**
 上传图片

 @param URLString URL地址
 @param params 参数
 @param name 服务器名
 @param images 文件数组
 @param block 正确回调
 */
- (void)netRequestUploadImageWithURLString:(NSString *)URLString
                                    params:(NSDictionary *)params
                                      name:(NSString *)name
                               imagesArray:(NSArray *)images
                              successBlock:(successReturnBlock)block {
  URLString = [BASE_URL stringByAppendingString:URLString];
  
  [NetRequestClass netRequestPOSTImageWithURLString:URLString params:params name:@"image" imagesArray:images successHandle:^(NSURLSessionTask *task, id response) {
    [self successWithResponse:response block:block];
  } failureHandle:^(NSURLSessionTask *task, NSError *error) {
    NSLog(@"%@",error);
    [CommonUtil promptViewWithText:@"没有网络连接，请稍后再试" view:ROOTVIEW hidden:YES];
    self.failureBlock();
  }];
}

#pragma mark - 网络请求成功返回
- (void)successWithResponse:(id)responseObject block:(ReturnValueBlock)block {
  NSData *data = responseObject;
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
  NSString *status = dic[@"statusCode"] ? dic[@"statusCode"] : dic[@"code"];
  if (REQUEST_SUCCESS(status)) {
    block(dic);
  }  else {
    status ? (dic[@"successMsg"] ?
              [self errorCodeShowWithErrorCode:status errorMsg:dic[@"successMsg"]] :
              [self errorCodeShowWithErrorCode:status errorMsg:nil]) : nil;
    self.errorBlock(status);
  }
}

#pragma mark - 登录失效返回登录页
- (void)loginIsInvalid {
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失效"
                                                                 message:@"已在其他设备上登录或长时间未登录"
                                                          preferredStyle:UIAlertControllerStyleAlert];
  [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
  [alert addAction:
   [UIAlertAction actionWithTitle:@"重新登录"
                            style:UIAlertActionStyleDestructive
                          handler:^(UIAlertAction * _Nonnull action) {
                            
//                            [[UserInfoSingleton shareData] setLogin:NO];
//                            [[UserInfoSingleton shareData] setUser:nil];
                            Class class = NSClassFromString(@"LoginViewController");
                            if (class) {
                              UIViewController *ctrl = class.new;
                              [[CommonUtil getCurrentVC].navigationController pushViewController:ctrl animated:YES];
                            }
                          }]];
}


#pragma mark - 提示错误信息
- (void)errorCodeShowWithErrorCode:(NSString *)errorCode errorMsg:(NSString *)errorMsg {
  if ([errorCode isEqualToString:@"1002"]) {
//    [self loginIsInvalid];
  } else {
    if (errorMsg) {
      [CommonUtil promptViewWithText:errorMsg view:ROOTVIEW hidden:YES];
    } else {
      NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataList"ofType:@"plist"]];
      NSDictionary *errorCodeDic = [dic objectForKey:@"ErrorCode"];
      [CommonUtil promptViewWithText:[errorCodeDic objectForKey:errorCode] view:ROOTVIEW hidden:YES];
    }
  }
}


#pragma 接收传过来的block
-(void)setBlockWithReturnBlock:(ReturnValueBlock)returnBlock
                WithErrorBlock:(ErrorCodeBlock)errorBlock
              WithFailureBlock:(FailureBlock)failureBlock {
  _returnBlock = returnBlock;
  _errorBlock = errorBlock;
  _failureBlock = failureBlock;
}

- (void)setBlockWithProgressBlock:(ProgressBlock)progressBlock {
  _progressBlock = progressBlock;
}

@end
