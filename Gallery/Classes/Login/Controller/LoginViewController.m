//
//  LoginViewController.m
//  Gallery
//
//  Created by 安东 on 2018/7/20.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
@interface LoginViewController ()
@property (strong, nonatomic) LoginView        *loginView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.view addSubview:self.loginView];
}
#pragma mark - getters
- (LoginView *)loginView {
  if (!_loginView) {
    _loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    //[_loginView setDelegate:self];
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
