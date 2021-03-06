//
//  AddressCell.m
//  Gallery
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 安东. All rights reserved.
//

#import "AddressCell.h"
@interface AddressCell ()

@property (strong, nonatomic) UILabel    *addressTypeLabel;
@property (strong, nonatomic) UILabel    *titleLabel;
@property (strong, nonatomic) UILabel    *nameLabel;
@property (strong, nonatomic) UILabel    *phoneLabel;
@property (strong, nonatomic) UILabel    *addressLabel;
@property (strong, nonatomic) UIView     *lineView;
@property (strong, nonatomic) UIButton   *editBtn;
@end
@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

#pragma mark - 重写cell的frame
-(void)setFrame:(CGRect)frame {
  
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  
  [super setFrame:frame];
}

#pragma mark =====编辑按钮点击事件
-(void)editBtnClick:(UIButton *)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(addressCelleditBtnClick)]) {
    [_delegate addressCelleditBtnClick];
  }
}
-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE * 32);
    make.left.mas_equalTo(SCALE_SIZE * 8);
  }];
  
  [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    
    make.top.mas_equalTo(SCALE_SIZE * 17);
    make.left.equalTo(self.titleLabel.mas_right).offset(SCALE_SIZE * 20);
  }];
  
  [self.phoneLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.nameLabel);
    make.left.equalTo(self.nameLabel.mas_right).offset(SCALE_SIZE * 10);
  }];
  
  [self.addressTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.nameLabel);
    make.height.mas_equalTo(SCALE_SIZE * 16);
    make.width.mas_equalTo(SCALE_SIZE * 49);
    make.left.equalTo(self.phoneLabel.mas_right).offset(SCALE_SIZE * 14);
  }];
  
  [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.nameLabel.mas_bottom).offset(SCALE_SIZE * 8);
    make.left.equalTo(self.nameLabel);
    make.right.equalTo(self.lineView.mas_left).offset(SCALE_SIZE*5);
  }];
  
  [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(1);
    make.height.mas_equalTo(SCALE_SIZE * 26);
    make.centerY.equalTo(self);
    make.right.mas_equalTo(-SCALE_SIZE * 48);
  }];
  
  [self.editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.height.right.equalTo(self);
    make.width.mas_equalTo(SCALE_SIZE * 48);
  }];
}

-(UILabel *)nameLabel {
  if (!_nameLabel) {
    _nameLabel = [[UILabel alloc] init];
    [_nameLabel setTextColor:BASECOLOR_BLACK_333];
    [_nameLabel setFont:FONTSIZE_REGULAR(14)];
    [_nameLabel setText:@"林坤宝"];
    [self.contentView addSubview:_nameLabel];
  }
  return _nameLabel;
}
-(UILabel *)phoneLabel {
  if (!_phoneLabel) {
    _phoneLabel = [[UILabel alloc] init];
    [_phoneLabel setTextColor:BASECOLOR_BLACK_333];
    [_phoneLabel setFont:FONTSIZE_REGULAR(14)];
    [_phoneLabel setText:@"18345179999"];
    [self.contentView addSubview:_phoneLabel];
  }
  return _phoneLabel;
}
-(UILabel *)addressLabel {
  if (!_addressLabel) {
    _addressLabel = [[UILabel alloc] init];
    [_addressLabel setTextColor:BASECOLOR_BLACK_666];
    [_addressLabel setFont:FONTSIZE_LIGHT(14)];
    [_addressLabel setText:@"北京市丰台区火星街道11号写字公园B座5068"];
    [_addressLabel setNumberOfLines:2];
    [self.contentView addSubview:_addressLabel];
  }
  return _addressLabel;
}
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setBackgroundColor:[UIColor hexStringToColor:@"#B0B2B4"]];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    [_titleLabel.layer setMasksToBounds:YES];
    [_titleLabel.layer setCornerRadius:SCALE_SIZE*16];
    [_titleLabel setFont:FONTSIZE_REGULAR(16)];
    [_titleLabel setText:@"林"];
    [_titleLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}
-(UILabel *)addressTypeLabel {
  if (!_addressTypeLabel) {
    _addressTypeLabel = [[UILabel alloc] init];
    [_addressTypeLabel setTextColor:BASECOLOR_BLUE];
//    [_addressTypeLabel.layer setMasksToBounds:YES];
    [_addressTypeLabel.layer setCornerRadius:3];
    [_addressTypeLabel.layer setBorderWidth:1.f];
    [_addressTypeLabel.layer setBorderColor:BASECOLOR_BLUE.CGColor];
    [_addressTypeLabel setFont:FONTSIZE_REGULAR(10)];
    [_addressTypeLabel setText:@"学校"];
    [_addressTypeLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.contentView addSubview:_addressTypeLabel];
  }
  return _addressTypeLabel;
}
-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}
-(UIButton *)editBtn {
  if (!_editBtn) {
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
    [_editBtn.titleLabel setFont:FONTSIZE_LIGHT(12)];
    [_editBtn setTitleColor:BASECOLOR_BLACK_999 forState:(UIControlStateNormal)];
    [_editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_editBtn];
  }
  return _editBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIColor *lineColor = self.titleLabel.backgroundColor;
  [super setSelected:selected animated:animated];
  self.titleLabel.backgroundColor = lineColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
  
  UIColor *lineColor = self.titleLabel.backgroundColor;
  [super setHighlighted:highlighted animated:animated];
  self.titleLabel.backgroundColor = lineColor;
}

@end
