//
//  QuoteCell.m
//  Gallery
//
//  Created by 安东 on 2018/9/25.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "QuoteCell.h"

@interface QuoteCell() <UITextFieldDelegate>

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UILabel  *detailLabel;

@end

@implementation QuoteCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setClipsToBounds:YES];
  }
  return self;
}


#pragma mark - 重写cell的frame
-(void)setFrame:(CGRect)frame {
  
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  
  [super setFrame:frame];
}

#pragma marks - setters
-(void)setTitleString:(NSString *)titleString {
  if (titleString) {
    [self.titleLabel setText:titleString];
  }
}

-(void)setDetailString:(NSString *)detailString {
  if (detailString) {
    [self.detailLabel setText:detailString];
  }
}

#pragma marks - getters
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK];
    [_titleLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init];
    [_detailLabel setTextColor:BASECOLOR_LIGHTBLACK];
    [_detailLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_detailLabel];
  }
  return _detailLabel;
}
-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(SCALE_SIZE*20);
    make.centerY.equalTo(self);
  }];
  
  [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*20);
    make.centerY.equalTo(self);
  }];
  
  [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.width.equalTo(self);
    make.height.mas_equalTo(1);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIColor *lineColor = self.lineView.backgroundColor;
  [super setSelected:selected animated:animated];
  self.lineView.backgroundColor = lineColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {

  UIColor *lineColor = self.lineView.backgroundColor;
  [super setHighlighted:highlighted animated:animated];
  self.lineView.backgroundColor = lineColor;
}
@end
