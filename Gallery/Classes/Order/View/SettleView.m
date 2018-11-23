//
//  SettleView.m
//  Gallery
//
//  Created by 安东 on 23/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "SettleView.h"
// 结算
@interface SettleView ()

@property (nonatomic, strong) UIView  *lineView;
@property (nonatomic, strong) UIButton  *selectedBtn;
@property (nonatomic, strong) UIButton  *settleBtn;
@property (nonatomic, strong) UILabel  *promptLabel;

@end

@implementation SettleView

-(instancetype)init {
  if (self = [super init]) {
    [self setBackgroundColor:[UIColor whiteColor]];
  }
  return self;
}

#pragma marks - getters
-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self addSubview:_lineView];
  }
  return _lineView;
}

-(UIButton *)selectedBtn {
  if (!_selectedBtn) {
    _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedBtn setImage:[UIImage imageNamed:@"btn_default"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    [self addSubview:_selectedBtn];
  }
  return _selectedBtn;
}

-(UIButton *)settleBtn {
  if (!_settleBtn) {
    _settleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settleBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [[_settleBtn titleLabel] setFont:FONTSIZE(16)];
    [_settleBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
    [self addSubview:_settleBtn];
  }
  return _settleBtn;
}

-(UILabel *)promptLabel {
  if (!_promptLabel) {
    _promptLabel = [[UILabel alloc] init];
    [_promptLabel setText:@"全选"];
    [_promptLabel setTextColor:BASECOLOR_BLACK_333];
    [_promptLabel setFont:FONTSIZE(12)];
    [self addSubview:_promptLabel];
  }
  return _promptLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.width.equalTo(self);
    make.height.mas_equalTo(0.5);
  }];
  
  [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*12);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE*30);
  }];
  
  [self.settleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.height.top.equalTo(self);
    make.width.mas_equalTo(SCALE_SIZE*93);
  }];
  
  [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.selectedBtn.mas_right);
    make.centerY.equalTo(self);
  }];
}
@end
