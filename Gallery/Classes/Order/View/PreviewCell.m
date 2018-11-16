//
//  PreviewCell.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PreviewCell.h"

@interface PreviewCell ()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *detailLabel;
@property (nonatomic, strong) UILabel  *priceLabel;
@property (nonatomic, strong) UILabel  *countLabel;

@end

@implementation PreviewCell

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

-(void)setDic:(NSDictionary *)dic {
  if (dic) {
    [self.titleLabel setText:dic[@"title"]];
    [self.detailLabel setText:dic[@"detail"]];
    [self.countLabel setText:dic[@"count"]];
  }
}

-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setFont:FONTSIZE(14)];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [self addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init ];
    [_detailLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailLabel setFont:FONTSIZE(12)];
    [self.contentView addSubview:_detailLabel];
  }
  return _detailLabel;
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
    make.top.equalTo(self);
  }];
  
  [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_SIZE*4);
  }];
  
  [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*16);
    make.centerY.equalTo(self.titleLabel);
  }];
  
  [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.priceLabel);
    make.top.equalTo(self.detailLabel);
  }];
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
