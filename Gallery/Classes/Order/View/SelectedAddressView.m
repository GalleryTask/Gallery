//
//  SelectedAddressView.m
//  Gallery
//
//  Created by 安东 on 19/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "SelectedAddressView.h"

@interface SelectedAddressView ()

@property (nonatomic, strong) UIButton  *backBtn;
@property (strong, nonatomic) UILabel   *userLabel;       // 联系人信息
@property (strong, nonatomic) UILabel   *addressLabel;    // 地址信息
@property (strong, nonatomic) UIImageView    *lineImgView;        // 分割线
@property (strong, nonatomic) UIImageView  *arrowImgView;

@end

@implementation SelectedAddressView

#pragma mark - setters
-(void)setAddress:(NSDictionary *)address {
  if (address) {

  }
}

- (void)backBtnClick {
  if (_delegate && [_delegate respondsToSelector:@selector(addressViewClick)]) {
    [_delegate addressViewClick];
  }
}


#pragma mark - getters
-(UIButton *)backBtn {
  if (!_backBtn) {
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundColor:[UIColor whiteColor]];
    [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];
  }
  return _backBtn;
}

-(UILabel *)userLabel {
  if (!_userLabel) {
    _userLabel = [[UILabel alloc] init];
    [_userLabel setTextColor:BASECOLOR_BLACK];
    [_userLabel setFont:FONTSIZE(14)];
    [_userLabel setText:@"刘新宝  18610861197"];
    [_userLabel setUserInteractionEnabled:NO];
    [self.backBtn addSubview:_userLabel];
  }
  return _userLabel;
}

-(UILabel *)addressLabel {
  if (!_addressLabel) {
    _addressLabel = [[UILabel alloc] init];
    [_addressLabel setTextColor:BASECOLOR_BLACK_666];
    [_addressLabel setFont:FONTSIZE(14)];
    [_addressLabel setText:@"天津市 武清区汊沽港菜和悉尼路安丘德尔卡诺街道办"];
    [_addressLabel setNumberOfLines:0];
    [_addressLabel setUserInteractionEnabled:NO];
    [self.backBtn addSubview:_addressLabel];
  }
  return _addressLabel;
}

-(UIImageView *)lineImgView {
  if (!_lineImgView) {
    _lineImgView = [[UIImageView alloc] init];
    [_lineImgView setImage:[UIImage imageNamed:@"delivery_line"]];
    [self.backBtn addSubview:_lineImgView];
  }
  return _lineImgView;
}

-(UIImageView *)arrowImgView {
  if (!_arrowImgView) {
    _arrowImgView = [[UIImageView alloc] init];
    [_arrowImgView setContentMode:UIViewContentModeScaleAspectFit];
    [_arrowImgView setImage:[UIImage imageNamed:@"arrow"]];
    [_arrowImgView setUserInteractionEnabled:NO];
    [self.backBtn addSubview:_arrowImgView];
  }
  return _arrowImgView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.top.equalTo(self);
    make.height.mas_equalTo(SCALE_SIZE*96);
  }];
  
  [self.userLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(SCALE_SIZE*15);
    make.top.equalTo(self).offset(SCALE_SIZE*10);
    make.height.mas_equalTo(SCALE_SIZE*14);
  }];
  
  [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.userLabel);
    make.top.equalTo(self.userLabel.mas_bottom).offset(SCALE_SIZE*8);
    make.width.equalTo(self).offset(-SCALE_SIZE*48);
    make.height.mas_equalTo(SCALE_SIZE*40);
  }];
  
  [self.lineImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self);
    make.bottom.equalTo(self.backBtn);
    make.height.mas_equalTo(SCALE_SIZE*6);
  }];
  
  [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*15);
    make.centerY.equalTo(self.addressLabel);
    make.width.height.mas_equalTo(SCALE_SIZE*16);
  }];
}

@end
