//
//  MeView.m
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import "MeView.h"
@interface MeView ()
@property (strong, nonatomic) UILabel            *nameLabel;      // 昵称名字
@property (strong, nonatomic) UIButton           *messageButton;
@property (strong, nonatomic) UIButton           *settingButton;
@property (strong, nonatomic) UIButton           *headButton;
@end
@implementation MeView

-(void)messageButtonClick:(UIButton *)sender {
  
}
-(void)settingButtonClick:(UIButton *)sender {
  
}
-(void)headButtonClick:(UIButton *)sender {
  
}
-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.headButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE * 25);
    make.top.mas_equalTo(SCALE_SIZE * 36 + STATUSBAR_HRIGHT - 20);
    make.height.width.mas_equalTo(SCALE_SIZE * 57);
  }];
  
  [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.headButton.mas_top).offset(SCALE_SIZE*7);
    make.left.equalTo(self.headButton.mas_right).offset(SCALE_SIZE*15);
  }];
  
  [self.messageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.mas_right);
    make.width.height.mas_equalTo(SCALE_SIZE*40);
    make.top.mas_equalTo(SCALE_SIZE*23 + STATUSBAR_HRIGHT - 20);
  }];
  
  [self.settingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.messageButton.mas_left);
    make.top.width.height.equalTo(self.messageButton);
  }];
}
-(UILabel *)nameLabel {
  if (!_nameLabel) {
    _nameLabel = [[UILabel alloc] init];
    [_nameLabel setTextColor:[UIColor whiteColor]];
    [_nameLabel setFont:FONTSIZE(14)];
    [_nameLabel setTextAlignment:(NSTextAlignmentCenter)];
    [_nameLabel setText:@"158****0012"];
    [self addSubview:_nameLabel];
  }
  return _nameLabel;
}
-(UIButton *)messageButton {
  if (!_messageButton) {
    _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_messageButton setImage:[UIImage imageNamed:@"me_message"] forState:(UIControlStateNormal)];
    [_messageButton addTarget:self action:@selector(messageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_messageButton];
  }
  return _messageButton;
}
-(UIButton *)settingButton {
  if (!_settingButton) {
    _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingButton setImage:[UIImage imageNamed:@"me_setting"] forState:(UIControlStateNormal)];
    [_settingButton setImageEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 0)];
    [_settingButton addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_settingButton];
  }
  return _settingButton;
}
-(UIButton *)headButton {
  if (!_headButton) {
    _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // [_headButton setImage:[UIImage imageNamed:@"service_check"] forState:(UIControlStateNormal)];
    [_headButton setBackgroundColor:BASECOLOR_BLACK_999];
    [_headButton addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headButton.layer setMasksToBounds:YES];
    [_headButton.layer setCornerRadius:SCALE_SIZE*57/2];
    [self addSubview:_headButton];
  }
  return _headButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
