//
//  Model.h
//  YSD
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//

//#import "ParamterModel.h"

typedef void (^ReturnValueBlock)(id returnValue);
typedef void (^ErrorCodeBlock)(id errorCode);
typedef void (^ProgressBlock)(id progress);
typedef void (^FailureBlock)(void);
typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface DataRequest : NSObject

@property (copy, nonatomic) ReturnValueBlock  returnBlock;
@property (copy, nonatomic) ErrorCodeBlock    errorBlock;
@property (copy, nonatomic) FailureBlock      failureBlock;
@property (copy, nonatomic) ProgressBlock     progressBlock;


// 传入交互的Block块
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock;

- (void) setBlockWithProgressBlock: (ProgressBlock) progressBlock;


/**
 发送验证码

 @param phone 手机号
 */
- (void)sendVerificationCodeWithPhone:(NSString *)phone;


@end
