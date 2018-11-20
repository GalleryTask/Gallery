//
//  LoginViewController.m
//  Gallery
//
//  Created by 安东 on 2018/7/20.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
@interface LoginViewController ()<LoginViewDelegate>
@property (strong, nonatomic) LoginView        *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"登录";
  
  BaseNavigationController *navigation = (BaseNavigationController *)self.navigationController;
  [navigation showLeftNavBtnWithClick:nil];
  [self.view addSubview:self.loginView];
  
}

#pragma mark - loginView delegate
#pragma mark - 登录按钮代理
-(void)loginViewloginBtnClick {
  
}
#pragma mark - 选择国家代码的代理
- (void)loignViewCountryBtnClick {
  
}
#pragma mark - 用户协议代理
- (void)loginViewServiceBtnClick {
  
}
#pragma mark - 验证码点击
- (void)loginViewSendCodeClick {
  
}
#pragma mark - 忘记密码代理
- (void)loginViewForgetPasswordClick {
  
}
#pragma mark - 注册按钮代理
- (void)loginViewRegisterClick {
  
}
#pragma mark - getters
- (LoginView *)loginView {
  if (!_loginView) {
    _loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    [_loginView setDelegate:self];
  }
  return _loginView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
