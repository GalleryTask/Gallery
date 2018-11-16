//
//  LoginView.m
//  Gallery
//
//  Created by admin on 2018/11/13.
//  Copyright © 2018 安东. All rights reserved.
//

#import "LoginView.h"
@interface LoginView () <UITextFieldDelegate>

@property (strong, nonatomic) UIView             *accountLine;        // 账号下划线
@property (strong, nonatomic) UIView             *passwordLine;       // 密码下划线
@property (strong, nonatomic) UIButton           *countryBtn;         // 国家代码点击按钮
@property (strong, nonatomic) UIButton           *verifyCodeBtn;      // 发送验证码按钮
@property (strong, nonatomic) UILabel            *promptLabel;        // 提示
@property (strong, nonatomic) UIButton           *serviceBtn;         // 服务协议按钮
@property (strong, nonatomic) NextButton         *loginBtn;           // 确定按钮
@property (strong, nonatomic) UILabel            *passwordLabel;      // 密码登录时，密码前的提示
@property (strong, nonatomic) UIButton           *forgetPasswordBtn;  // 忘记密码
@property (strong, nonatomic) UIView             *line;               // 账号注册分割线
@property (strong, nonatomic) UIButton           *registerBtn;        //账号注册
@property (strong, nonatomic) UIButton           *passwordLoginBtn;   //密码登录
@property (strong, nonatomic) UILabel            *nameLabel;       //下方App名字
@property (strong, nonatomic) UIImageView        *logoImageView;      //图标
@end

@implementation LoginView


#pragma mark - 选择国家代码的点击事件
- (void)countryBtnClick {
  [_delegate loignViewCountryBtnClick];
}

#pragma mark - 用户协议点击
- (void)serviceBtnClick {
  [_delegate loginViewServiceBtnClick];
}

#pragma mark =========密码登录点击事件
-(void)passwordLoginBtnClick:(UIButton *)sender{
  [self endEditing:YES];
  if (sender.isSelected) {
    [self.passwordLoginBtn setSelected:NO];
    [self.passwordLoginBtn setTitle:@"密码登录" forState:(UIControlStateNormal)];
    [self.forgetPasswordBtn setHidden:YES];
    [self.verifyCodeBtn setHidden:NO];
    [self.countryBtn setTitle:@"+86" forState:(UIControlStateNormal)];
    [self.passwordLabel setText:@""];
    [self.accountField setPlaceholder:@"请输入手机号"];
    [self.passwordField setPlaceholder:@"请输入验证码"];
    [self.accountField setKeyboardType:UIKeyboardTypeNumberPad];
    [self.passwordField setKeyboardType:UIKeyboardTypeNumberPad];
  }else{
    [self.passwordLoginBtn setSelected:YES];
    [self.passwordLoginBtn setTitle:@"免密码登录" forState:(UIControlStateNormal)];
    [self.forgetPasswordBtn setHidden:NO];
    [self.verifyCodeBtn setHidden:YES];
    [self.countryBtn setTitle:@"账号" forState:(UIControlStateNormal)];
    [self.passwordLabel setText:@"密码"];
    [self.accountField setPlaceholder:@"请输入账号"];
    [self.passwordField setPlaceholder:@"请输入密码"];
    [self.accountField setKeyboardType:UIKeyboardTypeDefault];
    [self.passwordField setKeyboardType:UIKeyboardTypeDefault];
  }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  
  [textField resignFirstResponder];//取消第一响应者
  
  return YES;
}

#pragma mark - 验证码点击事件
- (void)verifyCodeBtnClick:(id)sender {
  if ([self.accountField.text isEqualToString:@""] || ![CommonUtil isValidateMobile:self.accountField.text]) {
    [CommonUtil promptViewWithText:@"请输入正确的手机号" view:self hidden:YES];
  } else {
    [CommonUtil promptViewWithText:@"验证码已发送" view:self hidden:YES];
    [self startTime];
    [_delegate loginViewSendCodeClick];
  }
}
#pragma mark - 忘记密码点击事件
- (void)forgetPasswordBtnClick:(UIButton *)sender {
  [_delegate loginViewForgetPasswordClick];
}
#pragma mark - 注册按钮点击事件
- (void)registerBtnClick:(UIButton *)sender {
  [_delegate loginViewRegisterClick];
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.accountLine mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*30);
    make.width.equalTo(self).offset(-SCALE_SIZE*60);
    make.top.equalTo(self).offset(SCALE_SIZE*76);
    make.height.mas_equalTo(1);
  }];
  
  [self.passwordLine mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.accountLine);
    make.top.equalTo(self.accountLine).offset(SCALE_SIZE*44);
  }];
  
  [self.countryBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.accountLine);
    make.top.height.equalTo(self.accountField);
    make.width.mas_equalTo(SCALE_SIZE*56);
  }];
  
  [self.passwordLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.passwordLine);
    make.top.height.equalTo(self.passwordField);
    make.width.mas_equalTo(SCALE_SIZE*56);
  }];
  
  [self.accountField mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*86);
    make.top.equalTo(self.accountLine).offset(-SCALE_SIZE*44);
    make.width.mas_equalTo(SCALE_SIZE*200);
    make.height.mas_equalTo(SCALE_SIZE*44);
  }];
  
  [self.passwordField mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.accountField);
    make.top.equalTo(self.accountLine.mas_bottom);
  }];
  
  [self.verifyCodeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.accountLine);
    make.top.equalTo(self.accountField).offset(SCALE_SIZE*8);
    make.width.mas_equalTo(SCALE_SIZE*86);
    make.height.mas_equalTo(SCALE_SIZE*28);
  }];
  
  [self.forgetPasswordBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.passwordLine);
    make.top.equalTo(self.accountLine).offset(SCALE_SIZE*8);
    make.height.equalTo(self.verifyCodeBtn);
    make.width.equalTo(self.verifyCodeBtn);
  }];
  
  [self.loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.accountLine);
    make.height.equalTo(self.accountField);
    make.top.equalTo(self.passwordLine.mas_bottom).offset(SCALE_SIZE*79);
  }];
  
  [self.promptLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.loginBtn.mas_bottom).offset(SCALE_SIZE*12);
    make.left.mas_equalTo(SCALE_SIZE*124);
    make.height.mas_equalTo(SCALE_SIZE*44);
  }];
  
  [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.height.equalTo(self.promptLabel);
    make.left.equalTo(self.promptLabel.mas_right);
  }];
  
  [self.line mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.promptLabel.mas_bottom).offset(SCALE_SIZE*35);
    make.width.mas_equalTo(1);
    make.height.mas_equalTo(SCALE_SIZE*16);
    make.centerX.equalTo(self);
  }];
  
  [self.registerBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.line.mas_right).offset(-SCALE_SIZE * 14);
    make.top.height.equalTo(self.line);
  }];
  
  [self.passwordLoginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.line.mas_left).offset(SCALE_SIZE * 14);
    make.top.height.equalTo(self.line);
  }];
  
  [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self).offset(-SCALE_SIZE*20-SafeAreaBottomHeight-NAVIGATIONBAR_HEIGHT);
    make.centerX.equalTo(self);
  }];

  [self.logoImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self);
    make.bottom.equalTo(self.nameLabel.mas_top).offset(-SCALE_SIZE*7);
    make.width.height.mas_equalTo(SCALE_SIZE*30);
  }];
}

#pragma mark -  getters
-(UITextField *)accountField {
  if (!_accountField) {
    _accountField = [[UITextField alloc] init];
    [_accountField setFont:FONTSIZE(14)];
    [_accountField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_accountField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_accountField setKeyboardType:UIKeyboardTypeNumberPad];
    [_accountField setValue:BASECOLOR_LIGHTGRAY forKeyPath:@"_placeholderLabel.textColor"];
    [_accountField setValue:FONTSIZE(14) forKeyPath:@"_placeholderLabel.font"];
    [_accountField setPlaceholder:@"请输入手机号"];
    [_accountField setDelegate:self];
    //    [_accountField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_accountField setReturnKeyType:UIReturnKeyDone];
    [self addSubview:_accountField];
  }
  return _accountField;
}

-(UITextField *)passwordField {
  if (!_passwordField) {
    _passwordField = [[UITextField alloc] init];
    [_passwordField setFont:FONTSIZE(14)];
    [_passwordField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_passwordField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_passwordField setKeyboardType:UIKeyboardTypeNumberPad];
    [_passwordField setValue:BASECOLOR_LIGHTGRAY forKeyPath:@"_placeholderLabel.textColor"];
    [_passwordField setValue:FONTSIZE(14) forKeyPath:@"_placeholderLabel.font"];
    [_passwordField setPlaceholder:@"请输入验证码"];
    [_passwordField setDelegate:self];
    [_passwordField setSecureTextEntry:YES];
    //    [_passwordField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_passwordField setReturnKeyType:UIReturnKeyDone];
    [self addSubview:_passwordField];
  }
  return _passwordField;
}

-(UIView *)accountLine {
  if (!_accountLine) {
    _accountLine = [[UIView alloc] init];
    [_accountLine setBackgroundColor:BASECOLOR_LINE];
    [self addSubview:_accountLine];
  }
  return _accountLine;
}

-(UIView *)passwordLine {
  if (!_passwordLine) {
    _passwordLine = [[UIView alloc] init];
    [_passwordLine setBackgroundColor:BASECOLOR_LINE];
    [self addSubview:_passwordLine];
  }
  return _passwordLine;
}
-(UIButton *)countryBtn {
  if (!_countryBtn) {
    _countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_countryBtn setTitle:@"+86" forState:UIControlStateNormal];
    [_countryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_countryBtn addTarget:self action:@selector(countryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [[_countryBtn titleLabel] setFont:FONTSIZE(14)];
    [self addSubview:_countryBtn];
  }
  return _countryBtn;
}
-(UIButton *)verifyCodeBtn {
  if (!_verifyCodeBtn) {
    _verifyCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_verifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyCodeBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
    [[_verifyCodeBtn titleLabel] setFont:FONTSIZE(14)];
    [_verifyCodeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_verifyCodeBtn.layer setMasksToBounds:YES];
    [_verifyCodeBtn.layer setCornerRadius:3];
    [_verifyCodeBtn.layer setBorderWidth:1];
    [_verifyCodeBtn.layer setBorderColor:BASECOLOR_BLACK_999.CGColor];
    [_verifyCodeBtn addTarget:self action:@selector(verifyCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_verifyCodeBtn];
  }
  return _verifyCodeBtn;
}
-(UILabel *)promptLabel {
  if (!_promptLabel) {
    _promptLabel = [[UILabel alloc] init];
    [_promptLabel setTextColor:BASECOLOR_BLACK_999];
    [_promptLabel setFont:FONTSIZE(14)];
    [_promptLabel setText:@"点击查看"];
    [self addSubview:_promptLabel];
  }
  return _promptLabel;
}

-(UIButton *)serviceBtn {
  if (!_serviceBtn) {
    _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_serviceBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
    [[_serviceBtn titleLabel] setFont:FONTSIZE(14)];
    [_serviceBtn setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [_serviceBtn addTarget:self action:@selector(serviceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_serviceBtn];
  }
  return _serviceBtn;
}

-(NextButton *)loginBtn {
  if (!_loginBtn) {
    @weakify(self);
    _loginBtn = [NextButton buttonWithTitle:@"确认" clickBlock:^(id sender) {
      @strongify(self);
      if ([self.accountField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        [CommonUtil promptViewWithText:@"手机号或者验证码为空" view:self hidden:YES];
      } else {
        if ([CommonUtil isValidateMobile:self.accountField.text]) {
          [self.delegate loginViewloginBtnClick];
        } else {
          [CommonUtil promptViewWithText:@"请输入正确的手机号" view:self hidden:YES];
        }
      }
    }];
    [self addSubview:_loginBtn];
  }
  return _loginBtn;
}
-(UILabel *)passwordLabel {
  if (!_passwordLabel) {
    _passwordLabel = [[UILabel alloc] init];
    [_passwordLabel setTextColor:BASECOLOR_BLACK_333];
    [_passwordLabel setFont:FONTSIZE(14)];
    [_passwordLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self addSubview:_passwordLabel];
  }
  return _passwordLabel;
}
-(UIButton *)forgetPasswordBtn {
  if (!_forgetPasswordBtn) {
    _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPasswordBtn setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [_forgetPasswordBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_forgetPasswordBtn.layer setMasksToBounds:YES];
    [_forgetPasswordBtn.layer setCornerRadius:3];
    [_forgetPasswordBtn.layer setBorderWidth:1];
    [_forgetPasswordBtn.layer setBorderColor:BASECOLOR_BLACK_999.CGColor];
    [[_forgetPasswordBtn titleLabel] setFont:FONTSIZE(14)];
    [_forgetPasswordBtn addTarget:self action:@selector(forgetPasswordBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_forgetPasswordBtn setHidden:YES];
    [self addSubview:_forgetPasswordBtn];
  }
  return _forgetPasswordBtn;
}
-(UIView *)line {
  if (!_line) {
    _line = [[UIView alloc] init];
    [_line setBackgroundColor:BASECOLOR_LINE];
    [self addSubview:_line];
  }
  return _line;
}
-(UIButton *)registerBtn {
  if (!_registerBtn) {
    _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBtn setTitle:@"账号注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [[_registerBtn titleLabel] setFont:FONTSIZE(14)];
    [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_registerBtn];
  }
  return _registerBtn;
}
-(UIButton *)passwordLoginBtn {
  if (!_passwordLoginBtn) {
    _passwordLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_passwordLoginBtn setTitle:@"密码登录" forState:UIControlStateNormal];
    [_passwordLoginBtn setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [[_passwordLoginBtn titleLabel] setFont:FONTSIZE(14)];
    [_passwordLoginBtn addTarget:self action:@selector(passwordLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_passwordLoginBtn];
  }
  return _passwordLoginBtn;
}
-(UILabel *)nameLabel {
  if (!_nameLabel) {
    _nameLabel = [[UILabel alloc] init];
    [_nameLabel setTextColor:BASECOLOR_BLACK_666];
    [_nameLabel setFont:FONTSIZE(14)];
    [_nameLabel setTextAlignment:(NSTextAlignmentCenter)];
    [_nameLabel setText:@"一撕得客户端"];
    [self addSubview:_nameLabel];
  }
  return _nameLabel;
}
-(UIImageView *)logoImageView {
  if (!_logoImageView) {
    _logoImageView = [[UIImageView alloc] init];
    [_logoImageView setImage:[UIImage imageNamed:@"AppIcon"]];
    [_logoImageView.layer setMasksToBounds:YES];
    [_logoImageView.layer setCornerRadius:3];
    [self addSubview:_logoImageView];
  }
  return _logoImageView;
}


#pragma mark - Timer 60s倒计时
-(void)startTime{
  @weakify(self);
  __block int timeout=60; //倒计时时间
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
  dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
  dispatch_source_set_event_handler(_timer, ^{
    @strongify(self);
    if(timeout <= 0){
      // 倒计时结束
      dispatch_source_cancel(_timer);
      dispatch_async(dispatch_get_main_queue(), ^{
        [self.verifyCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.verifyCodeBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
        self.verifyCodeBtn.enabled = YES;
      });
    } else {
      int seconds = timeout % 60;
      NSString *strTime = [NSString stringWithFormat:@"%.1d", seconds];
      dispatch_async(dispatch_get_main_queue(), ^{
        self.verifyCodeBtn.enabled = NO;
        [self.verifyCodeBtn setTitle:[NSString stringWithFormat:@"%@s",strTime] forState:UIControlStateNormal];
        [self.verifyCodeBtn setTitleColor:BASECOLOR_LIGHTGRAY forState:UIControlStateNormal];
      });
      timeout--;
    }
  });
  dispatch_resume(_timer);
  
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
