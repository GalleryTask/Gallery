//
//  ServiceCell.m
//  Gallery
//
//  Created by 安东 on 19/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ServiceCell.h"

@interface ServiceCell ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UILabel  *detailLabel;
@property (nonatomic, copy)  NSArray   *dataArray;

@end

@implementation ServiceCell

#pragma mark - 重写cell的frame
-(void)setFrame:(CGRect)frame {
  
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  
  [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
   
  }
  return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

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
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(15)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}

-(UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init];
    [_detailLabel setTextColor:BASECOLOR_BLACK_333];
    [_detailLabel setFont: FONTSIZE(15)];
    [self.contentView addSubview:_detailLabel];
  }
  return _detailLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*15);
    make.centerY.equalTo(self);
  }];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.titleLabel);
    make.right.mas_equalTo(SCALE_SIZE*15);
    make.bottom.equalTo(self);
    make.height.mas_equalTo(0.5);
  }];
  
  [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*35);
    make.centerY.equalTo(self);
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
