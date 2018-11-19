//
//  ServiceDetailFooterView.m
//  Gallery
//
//  Created by admin on 2018/11/19.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ServiceDetailFooterView.h"

@interface ServiceDetailFooterView ()

@property(nonatomic, strong)UIButton *selectButton;
@property(nonatomic, strong)UILabel  *titleLabel;
@property(nonatomic, strong)UIButton *serviceButton;

@end
@implementation ServiceDetailFooterView

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*20);
    make.centerY.equalTo(self);
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.selectButton.mas_right);
    make.centerY.equalTo(self);
  }];
  
  [self.serviceButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel.mas_right);
    make.centerY.equalTo(self);
  }];
}

-(void)serviceButtonClick:(UIButton *)sender {
  
}
-(void)selectButtonClick:(UIButton *)sender {
  
}
-(UIButton *)selectButton {
  if (!_selectButton) {
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
    [_selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_selectButton];
  }
  return _selectButton;
}
-(UIButton *)serviceButton {
  if (!_serviceButton) {
    _serviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_serviceButton addTarget:self action:@selector(serviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_serviceButton setTitle:@"《一撕得定制服务条款》" forState:UIControlStateNormal];
    [_serviceButton setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [[_serviceButton titleLabel] setFont:FONTSIZE(14)];
    [self addSubview:_serviceButton];
  }
  return _serviceButton;
}
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_999];
    [_titleLabel setFont:FONTSIZE(14)];
    [_titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [_titleLabel setText:@"勾选即表示已阅读并同意"];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
