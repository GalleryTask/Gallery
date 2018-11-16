//
//  BottomSelectBar.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "BottomSelectBar.h"

@interface BottomSelectBar ()

@property (nonatomic, strong) UIButton  *leftBtn;
@property (nonatomic, strong) UIButton  *rightBtn;
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation BottomSelectBar
-(instancetype)initWithLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle delegate:(nonnull id<BottomSelectBarDelegate>)delegate {
  if (self = [super init]) {
  
    self.delegate = delegate;
    [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightBtn setTitle:rightTitle forState:UIControlStateNormal];
  }
  return self;
}

#pragma mark -点击事件
- (void)leftBtnClick:(id)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(bottomBarWithLeftBtnClick:)]) {
    [_delegate bottomBarWithLeftBtnClick:sender];
  }
}

- (void)rightBtnClick:(id)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(bottomBarWithRightBtnClick:)]) {
    [_delegate bottomBarWithRightBtnClick:sender];
  }
}

#pragma marks - getters
-(UIButton *)leftBtn {
  if (!_leftBtn) {
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setBackgroundColor:BASECOLOR_BLACK_000];
    [[_leftBtn titleLabel] setFont:FONTSIZE(16)];
    [_leftBtn setBackgroundColor:[UIColor whiteColor]];
    [_leftBtn setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
  }
  return _leftBtn;
}

-(UIButton *)rightBtn {
  if (!_rightBtn) {
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [[_rightBtn titleLabel] setFont:FONTSIZE(16)];
    [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
  }
  return _rightBtn;
}

-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self addSubview:_lineView];
  }
  return _lineView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self);
    make.top.equalTo(self).offset(-0.5);
    make.height.mas_equalTo(0.5);
  }];
  
  [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.equalTo(self);
    make.width.mas_equalTo(SCREEN_WIDTH/2);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
  
  [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.mas_equalTo(SCREEN_WIDTH/2);
    make.bottom.equalTo(self);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}


@end
