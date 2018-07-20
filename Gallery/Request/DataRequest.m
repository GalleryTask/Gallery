//
//  Model.m
//  YSD
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

#import "NetRequestClass.h"

typedef void (^successReturnBlock)(id returnValue);

@interface DataRequest()

@property (copy,   nonatomic) successReturnBlock  successBlock;

@end


@implementation DataRequest

#pragma mark - 发送请求
- (void)netRequestBlockWithUrl:(NSString *)url paramter:(NSDictionary *)paramter successBlock:(successReturnBlock)block {
//  url = [BASE_URL stringByAppendingString:url];
  [NetRequestClass netRequestPOSTWithRequestURL:url
                                      Parameter:paramter
                               ReturnValueBlock:^(id returnValue) {
                                 block(returnValue);
                               } ErrorCodeBlock:^(id errorCode) {
                                 self.errorBlock(errorCode);
                               } FailureBlock:^{
                                 self.failureBlock();
                               }];
}

#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock:(ReturnValueBlock)returnBlock
                 WithErrorBlock:(ErrorCodeBlock)errorBlock
               WithFailureBlock:(FailureBlock)failureBlock {
  _returnBlock = returnBlock;
  _errorBlock = errorBlock;
  _failureBlock = failureBlock;
}

- (void) setBlockWithProgressBlock:(ProgressBlock)progressBlock {
  _progressBlock = progressBlock;
}

#pragma mark - 发送验证码
- (void)sendVerificationCodeWithPhone:(NSString *)phone {
//  NSString *url = [NSString stringWithFormat:@"%@/oauth/getVerificationCode",BASE_URL];
//  VerificationCodeModel *model = [[VerificationCodeModel alloc] initWithPhone:phone];
//  [self netRequestBlockWithUrl:url paramter:[model toDictionary] successBlock:^(id returnValue) {
//    SendVerificationCodeResult *result = [[SendVerificationCodeResult alloc] initWithDictionary:returnValue error:nil];
//    self.returnBlock(result.code);
//  }];
}


@end
