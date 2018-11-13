//
//  PackagingCustomView.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingCustomView.h"

@interface PackagingCustomView ()

@property (nonatomic, copy)   PackagingSelectedItemBlock  selectedItemBlock;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView  *lineView;
@property (nonatomic, copy) NSArray  *items;

@end

@implementation PackagingCustomView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                   itemsArray:(NSArray *)items
            selectedItemBlock:(PackagingSelectedItemBlock)block {
  if (self = [super initWithFrame:frame]) {
    self.selectedItemBlock = block;
    self.items = items;
    [self.titleLabel setText:title];
    [self createBtnWithItems:items];
  }
  return self;
}


- (void)createBtnWithItems:(NSArray *)items {
  for (int i = 0; i < items.count; i++) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateSelected];
    [button setTitleColor:BASECOLOR_GRAY_CC  forState:UIControlStateNormal];
    [button setBackgroundImage:[CommonUtil imageWithColor:BASECOLOR_BACKGROUND_GRAY] forState:UIControlStateNormal];
    [button setBackgroundImage:[CommonUtil imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
    [[button layer] setCornerRadius:5];
    [[button layer] setMasksToBounds:YES];
    [[button titleLabel] setFont:FONTSIZE(12)];
    [button setTitle:items[i] forState:UIControlStateNormal];
    [button setTag:(100+i)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    float width = [CommonUtil adaptionWidthWithString:items[i] fontSize:SCALE_SIZE*12 andHeight:32] + SCALE_SIZE*20;
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(SCALE_SIZE*10+(SCALE_SIZE*(12+width))*i);
      make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_SIZE*10);
      make.width.mas_equalTo(width);
      make.height.mas_equalTo(32);
    }];
    
    if (i == 0) {
      [button setSelected:YES];
      [[button layer] setBorderColor:BASECOLOR_BLACK_000.CGColor];
      [[button layer] setBorderWidth:0.5];
    }
  }
}

- (void)buttonClick:(UIButton *)button {
  for (int i = 0; i < self.items.count; i++) {
    UIButton *btn = [self viewWithTag:100+i];
    [btn setSelected:NO];
    [[btn layer] setBorderWidth:0];
  }
  if (!button.selected) {
    [button setSelected:YES];
    [[button layer] setBorderColor:BASECOLOR_BLACK_000.CGColor];
    [[button layer] setBorderWidth:0.5];
  }
  self.selectedItemBlock(button.currentTitle);
}

#pragma marks - getters
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(14)];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
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
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE*16);
  }];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.right.mas_equalTo(-SCALE_SIZE*10);
    make.bottom.equalTo(self);
    make.height.mas_equalTo(0.5);
  }];
}

@end
