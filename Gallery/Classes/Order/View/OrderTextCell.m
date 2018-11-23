//
//  OrderTextCell.m
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderTextCell.h"

@interface OrderTextCell ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *detailLabel;
@property (nonatomic, strong) UILabel  *countLabel;
@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation OrderTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 重写cell的frame 使得cell间有空隙
-(void)setFrame:(CGRect)frame {
  
  frame.origin.x = SCALE_SIZE*10;
  //  frame.origin.y += SCALE_SIZE*10;
//  frame.size.height -= SCALE_SIZE*10;
  frame.size.width -= SCALE_SIZE*20;
  
  self.layer.masksToBounds = NO;
  //  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
  //  self.layer.shadowOpacity = 0.1f;
  //  self.layer.shadowOffset = CGSizeMake(0,0);
  
//  self.layer.cornerRadius = 13.0;
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

-(id)initWithData:(PlaceOrderArr *)data bottomCorner:(BOOL)isCorner isEdit:(BOOL)isEdit {
 
  CGSize size;
  if (isCorner) {
    size = CGSizeMake(13, 13);
  } else {
    size = CGSizeMake(0, 0);
  }
  UIRectCorner corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
  
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:corner
                                                       cornerRadii:size];
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.frame = self.bounds;
  maskLayer.path = maskPath.CGPath;
  self.layer.mask = maskLayer;
  
  [self.titleLabel setText:data.title];
  [self.detailLabel setText:data.price];
  [self.countLabel setText:data.count];
  
  self.isEdit = isEdit;
  
  return self;
}

#pragma marks -getters
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init];
    [_detailLabel setTextColor:BASECOLOR_BLACK_333];
    [_detailLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_detailLabel];
  }
  return _detailLabel;
}

-(UILabel *)countLabel {
  if (!_countLabel) {
    _countLabel = [[UILabel alloc] init];
    [_countLabel setTextColor:BASECOLOR_BLACK_999];
    [_countLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_countLabel];
  }
  return _countLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    if (self.isEdit) {
      
      make.left.mas_equalTo(SCALE_SIZE*54);
    } else {
      make.left.mas_equalTo(SCALE_SIZE*16);
    }
    make.top.mas_equalTo(SCALE_SIZE*10);
  }];
  
  [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*16);
    make.centerY.equalTo(self.titleLabel);
  }];
  
  [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.detailLabel);
    make.top.equalTo(self.detailLabel.mas_bottom);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
