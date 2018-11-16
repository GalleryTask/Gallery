//
//  SchemeCell.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "SchemeCell.h"

@interface SchemeCell ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *detailTitleLabel;
@property (nonatomic, strong) UILabel  *detailOneLabel;
@property (nonatomic, strong) UILabel  *detailTwoLabel;
@property (nonatomic, strong) UILabel  *detailThreeLabel;
@property (nonatomic, strong) UILabel  *detailFourLabel;
@property (nonatomic, strong) UILabel  *priceLabel;
@property (nonatomic, strong) UILabel  *countLabel;

@end

@implementation SchemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init ];
    [_titleLabel setText:@"苹果高档礼品包装方案"];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(16)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)detailTitleLabel {
  if (!_detailTitleLabel) {
    _detailTitleLabel = [[UILabel alloc] init ];
    [_detailTitleLabel setText:@"精品卡盒方案"];
    [_detailTitleLabel setTextColor:BASECOLOR_BLACK_333];
    [_detailTitleLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_detailTitleLabel];
  }
  return _detailTitleLabel;
}

-(UILabel *)detailOneLabel {
  if (!_detailOneLabel) {
    _detailOneLabel = [[UILabel alloc] init ];
    [_detailOneLabel setText:@"精品卡盒方案一/材质：牛纸"];
    [_detailOneLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailOneLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_detailOneLabel];
  }
  return _detailOneLabel;
}

-(UILabel *)detailTwoLabel {
  if (!_detailTwoLabel) {
    _detailTwoLabel = [[UILabel alloc] init ];
    [_detailTwoLabel setText:@"内容物规格：10个装"];
    [_detailTwoLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailTwoLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_detailTwoLabel];
  }
  return _detailTwoLabel;
}

-(UILabel *)detailThreeLabel {
  if (!_detailThreeLabel) {
    _detailThreeLabel = [[UILabel alloc] init ];
    [_detailThreeLabel setText:@"内容物尺寸： 直径100mm"];
    [_detailThreeLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailThreeLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_detailThreeLabel];
  }
  return _detailThreeLabel;
}

-(UILabel *)detailFourLabel {
  if (!_detailFourLabel) {
    _detailFourLabel = [[UILabel alloc] init ];
    [_detailFourLabel setText:@"包装尺寸： 长200mm 宽200mm 高200mm"];
    [_detailFourLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailFourLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_detailFourLabel];
  }
  return _detailFourLabel;
}

-(UILabel *)priceLabel {
  if (!_priceLabel) {
    _priceLabel = [[UILabel alloc] init ];
    [_priceLabel setText:@"¥ 5.00"];
    [_priceLabel setTextColor:BASECOLOR_BLACK_333];
    [_priceLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_priceLabel];
  }
  return _priceLabel;
}

-(UILabel *)countLabel {
  if (!_countLabel) {
    _countLabel = [[UILabel alloc] init ];
    [_countLabel setText:@"x 1个"];
    [_countLabel setTextColor:BASECOLOR_BLACK_999];
    [_countLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_countLabel];
  }
  return _countLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*14);
    make.top.mas_equalTo(SCALE_SIZE*26);
  }];
  
  [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_SIZE*26);
  }];
  
  [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*16);
    make.centerY.equalTo(self.detailTitleLabel);
  }];
  
  [self.detailOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailTitleLabel.mas_bottom).offset(SCALE_SIZE*5);
    make.left.equalTo(self.titleLabel);
  }];
  
  [self.detailTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailOneLabel.mas_bottom).offset(SCALE_SIZE*4);
    make.left.equalTo(self.titleLabel);
  }];
  
  [self.detailThreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailTwoLabel.mas_bottom).offset(SCALE_SIZE*4);
    make.left.equalTo(self.titleLabel);
  }];
  
  [self.detailFourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.detailThreeLabel.mas_bottom).offset(SCALE_SIZE*4);
    make.left.equalTo(self.titleLabel);
  }];
  
  [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.priceLabel);
    make.top.equalTo(self.detailOneLabel);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
