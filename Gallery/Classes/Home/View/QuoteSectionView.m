//
//  QuoteSectionView.m
//  Gallery
//
//  Created by 安东 on 2018/9/25.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "QuoteSectionView.h"

@interface QuoteSectionView()

@property (nonatomic, strong) UILabel  *titleLabel;

@end

@implementation QuoteSectionView

-(instancetype)init {
  if (self = [super init]) {
    [self setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  }
  return self;
}

-(void)setTitleStr:(NSString *)titleStr {
  if (titleStr) {
    [self.titleLabel setText:titleStr];
  }
}

#pragma marks - getters
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLUE];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:SCALE_SIZE*16]];
    [_titleLabel setText:@"配材信息"];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(SCALE_SIZE*20);
    make.centerY.equalTo(self);
  }];
}


@end
