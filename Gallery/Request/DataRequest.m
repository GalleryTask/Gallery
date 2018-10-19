//
//  Model.m
//  YSD
//
//  Created by 安东 on 2017/2/20.
//  Copyright © 2017年 安东. All rights reserved.
//


@implementation DataRequest

#pragma mark - 发送验证码
- (void)sendVerificationCodeWithPhone:(NSString *)phone {
//  NSString *url = @"/oauth/getVerificationCode";
//  VerificationCodeModel *model = [[VerificationCodeModel alloc] initWithPhone:phone];
//  [self netRequestWithMethodType:RequestMethodTypePOST URLString:url params:[model toDictionary] successBlock:^(id returnValue) {
//    SendVerificationCodeResult *result = [[SendVerificationCodeResult alloc] initWithDictionary:returnValue error:nil];
//    self.returnBlock(result.code);
//  }];
}

#pragma mark - 获取省市区信息
- (void)getAreaTree {
//  NSString *url = @"/sysArea/nbox/getAreaTreaDate";
//  ParamterModel *model = [[ParamterModel alloc] init];
//  [self netRequestWithMethodType:RequestMethodTypePOST URLString:url params:[model toDictionary] successBlock:^(id returnValue) {
//    AreaTreeResult *result = [[AreaTreeResult alloc] initWithDictionary:returnValue error:nil];
//    self.returnBlock(result.data);
//  }];
}

@end
