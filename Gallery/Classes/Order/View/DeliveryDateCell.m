//
//  DeliveryDateCell.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "DeliveryDateCell.h"

@interface DeliveryDateCell ()

@property (nonatomic, strong) UIView  *topLine;
@property (nonatomic, strong) UIView  *bottomLine;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIImageView  *arrowImgView;
@end

@implementation DeliveryDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - 重写cell的frame
-(void)setFrame:(CGRect)frame {
  
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  
  [super setFrame:frame];
}

-(UIView *)topLine {
  if (!_topLine) {
    _topLine = [[UIView alloc] init];
    [_topLine setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_topLine];
  }
  return _topLine;
}

-(UIView *)bottomLine {
  if (!_bottomLine) {
    _bottomLine = [[UIView alloc] init];
    [_bottomLine setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_bottomLine];
  }
  return _bottomLine;
}

-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setText:@"交期"];
    [_titleLabel setTextColor:BASECOLOR_BLACK_000];
    [_titleLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UIImageView *)arrowImgView {
  if (!_arrowImgView) {
    _arrowImgView = [[UIImageView alloc] init];
    [_arrowImgView setImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:_arrowImgView];
  }
  return _arrowImgView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self);
    make.width.equalTo(self).offset(-SCALE_SIZE*20);
    make.centerX.equalTo(self);
    make.height.mas_equalTo(0.5);
  }];
  
  [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.topLine);
    make.bottom.equalTo(self);
  }];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*14);
    make.centerY.equalTo(self);
  }];
  
  [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*16);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE*16);
  }];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIColor *lineColor = self.topLine.backgroundColor;
  [super setSelected:selected animated:animated];
  self.topLine.backgroundColor = lineColor;
  self.bottomLine.backgroundColor = lineColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  
  UIColor *lineColor = self.topLine.backgroundColor;
  [super setHighlighted:highlighted animated:animated];
  self.topLine.backgroundColor = lineColor;
  self.bottomLine.backgroundColor = lineColor;
}

@end
