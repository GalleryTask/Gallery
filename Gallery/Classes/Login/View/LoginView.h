//
//  LoginView.h
//  Gallery
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 安东. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LoginViewDelegate <NSObject>

- (void)loginViewloginBtnClick;//登录的代理
- (void)loignViewCountryBtnClick;//国家代码的代理
- (void)loginViewServiceBtnClick;//用户协议代理
- (void)loginViewSendCodeClick;//验证码代理
- (void)loginViewForgetPasswordClick;//忘记密码
- (void)loginViewRegisterClick;//注册代理
@end
@interface LoginView : UIView
@property (strong, nonatomic) UITextField        *accountField;       // 账号
@property (strong, nonatomic) UITextField        *passwordField;      // 密码

@property (weak,   nonatomic) id <LoginViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
