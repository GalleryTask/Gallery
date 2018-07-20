//
//  UserInfoSingleton.h
//  Tourmaline
//
//  Created by previz on 16/7/18.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserInfoData;

@interface UserInfoSingleton : NSObject

+ (UserInfoSingleton *)shareData;

@property (assign, nonatomic) BOOL      login;              // 是否是登录状态
@property (copy,   nonatomic) NSString  *accessToken;       // token

@end
