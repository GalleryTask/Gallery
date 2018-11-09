//
//  HomeShowView.m
//  Gallery
//
//  Created by 安东 on 09/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "HomeShowView.h"

@interface HomeShowView ()

@property (nonatomic, strong) UILabel  *titleLabel;  // 标题
@property (nonatomic, strong) UILabel  *currentCountLabel;
@property (nonatomic, strong) UILabel  *countLabel;

@end

@implementation HomeShowView

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

-(void)setCurrentCount:(int)currentCount {
  [self.currentCountLabel setText:[NSString stringWithFormat:@"%d",currentCount]];
}

-(void)setTitleString:(NSString *)titleString {
  if (titleString) {
    [self.titleLabel setText:titleString];
  }
}

#pragma marks - getters
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*20 weight:UIFontWeightBold]];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)currentCountLabel {
  if (!_currentCountLabel) {
    _currentCountLabel = [[UILabel alloc] init];
    [_currentCountLabel setTextColor:BASECOLOR_BLACK_000];
    [_currentCountLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*16 weight:UIFontWeightBold]];
    [_currentCountLabel setText:@"1"];
    [self addSubview:_currentCountLabel];
  }
  return _currentCountLabel;
}

-(UILabel *)countLabel {
  if (!_countLabel) {
    _countLabel = [[UILabel alloc] init];
    [_countLabel setTextColor:BASECOLOR_BLACK_999];
    [_countLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*16 weight:UIFontWeightRegular]];
    [_countLabel setText:@" / 8"];
    [self addSubview:_countLabel];
  }
  return _countLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*24);
    make.centerY.equalTo(self);
  }];
  
  [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-SCALE_SIZE*24.2);
    make.centerY.equalTo(self);
  }];
  
  [self.currentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.countLabel.mas_left);
    make.centerY.equalTo(self);
  }];
}
@end
