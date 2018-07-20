//
//  UserInfoSingleton.m
//  Tourmaline
//
//  Created by previz on 16/7/18.
//  Copyright © 2016年 dongan. All rights reserved.
//

#import "UserInfoSingleton.h"

@interface UserInfoSingleton() 

@property (assign, nonatomic) UserInfoSingleton  *manager_;

@end

static UserInfoSingleton *user = nil;
@implementation UserInfoSingleton

+ (UserInfoSingleton *)shareData {
  static dispatch_once_t predicted;
  dispatch_once(&predicted, ^{
    if (user == nil) {
      user = [[UserInfoSingleton alloc] init];
    }
  });
  return user;
}

#pragma mark - 本地化
- (void)setObject:(nullable id)value forKey:(NSString *)defaultName {
  [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

- (nullable id)objectForKey:(NSString *)defaultName {
  return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

#pragma mark - setters and getters
-(void)setAccessToken:(NSString *)accessToken {
  [self setObject:accessToken forKey:@"accesstoken"];
}

-(NSString *)accessToken {
  
  return [self objectForKey:@"accesstoken"];
}

// 是否登录
-(void)setLogin:(BOOL)login {
  [[NSUserDefaults standardUserDefaults] setBool:login forKey:@"login"];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)login {
  return [[NSUserDefaults standardUserDefaults] boolForKey:@"login"];
}


@end
