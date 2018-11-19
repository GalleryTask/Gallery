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
@property(nonatomic, strong)UISlider *slider;
@property(nonatomic, strong)UILabel  *sliderTitleLabel;
@property(nonatomic, strong)UILabel  *numberLabel;
@property(nonatomic, assign)CGFloat  valueFloat;
@property(nonatomic, strong)UIView   *blackView;
@end
@implementation ServiceDetailFooterView

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*15);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE*32);
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.selectButton.mas_right).offset(-5);
    make.centerY.equalTo(self);
  }];
  
  [self.serviceButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel.mas_right);
    make.centerY.equalTo(self);
  }];
  
  [self.sliderTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*16);
    make.top.mas_equalTo(SCALE_SIZE*20);
    make.width.mas_equalTo(SCALE_SIZE*30);
  }];
  
  [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.sliderTitleLabel);
    make.left.equalTo(self.sliderTitleLabel.mas_right).offset(SCALE_SIZE*10);
    make.right.equalTo(self.mas_right).offset(-15);
  }];
  
  [self.numberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(SCALE_SIZE*65);
    make.top.equalTo(self);
    make.left.mas_equalTo((SCREEN_WIDTH-SCALE_SIZE*(56+50+15))/300*self.valueFloat+SCALE_SIZE*50);
  }];
}

-(void)serviceButtonClick:(UIButton *)sender {
 
}
-(void)selectButtonClick:(UIButton *)sender {
  if (sender.isSelected) {
    [self.selectButton setImage:[UIImage imageNamed:@"service_check"] forState:(UIControlStateNormal)];
    [self.selectButton setSelected:NO];
  }else{
    [self.selectButton setImage:[UIImage imageNamed:@"service_checkOn"] forState:(UIControlStateNormal)];
    [self.selectButton setSelected:YES];
  }
  
  if (_delegate && [_delegate respondsToSelector:@selector(ServiceDetailFooterSelect:)]) {
    [_delegate ServiceDetailFooterSelect:sender.isSelected];
  }
}
-(UIButton *)selectButton {
  if (!_selectButton) {
    _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectButton setImage:[UIImage imageNamed:@"service_check"] forState:(UIControlStateNormal)];
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
-(UILabel *)sliderTitleLabel {
  if (!_sliderTitleLabel) {
    _sliderTitleLabel = [[UILabel alloc] init];
    [_sliderTitleLabel setTextColor:BASECOLOR_BLACK_333];
    [_sliderTitleLabel setFont:FONTSIZE(12)];
    [_sliderTitleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [_sliderTitleLabel setText:@"直径"];
    [self addSubview:_sliderTitleLabel];
  }
  return _sliderTitleLabel;
}
-(UILabel *)numberLabel {
  if (!_numberLabel) {
    _numberLabel = [[UILabel alloc] init];
    [_numberLabel setTextColor:BASECOLOR_BLACK_333];
    [_numberLabel setFont:FONTSIZE(18)];
    [_numberLabel setTextAlignment:(NSTextAlignmentCenter)];
    [_numberLabel setText:@"120mm"];
    [_numberLabel setTextAlignment:(NSTextAlignmentCenter)];
    self.valueFloat = 120;
    [self addSubview:_numberLabel];
  }
  return _numberLabel;
}
-(UISlider *)slider {
  if (!_slider) {
    _slider = [[UISlider alloc] init];
    [_slider setMinimumValue:0];
    [_slider setMaximumValue:300];
    [_slider setValue:120];
    [_slider setContinuous:YES];
    [_slider setMinimumTrackTintColor:BASECOLOR_BLACK_333];
    [_slider setMaximumTrackTintColor:[UIColor hexStringToColor:@"#E6E6E6"]];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    [_slider setThumbImage:[UIImage imageNamed:@"service_checkOn"] forState:(UIControlStateNormal)];
    [self addSubview:_slider];
  }
  return _slider;
}
-(UIView *)blackView {
  if (!_blackView) {
    _blackView = [[UIView alloc] init];
    [self addSubview:_blackView];
  }
  return _blackView;
}
-(void)sliderValueChanged:(id)sender {
  UISlider *slider1 = sender;
  self.valueFloat = slider1.value;
  [self.numberLabel setText:[NSString stringWithFormat:@"%.0fmm",self.valueFloat]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
