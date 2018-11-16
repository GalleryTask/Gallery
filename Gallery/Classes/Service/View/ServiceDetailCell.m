//
//  ServiceDetailCell.m
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ServiceDetailCell.h"
@interface ServiceDetailCell ()

@property(strong, nonatomic)UILabel *titleLabel;
@property(strong, nonatomic)UILabel *detailLabel;
@end
@implementation ServiceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)layoutSubviews {
  [super layoutSubviews];
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*15);
    if ([self.lastString isEqualToString:@"1"]) {
      make.top.mas_equalTo(self);
    }else if ([self.lastString isEqualToString:@"0"]){
      make.bottom.equalTo(self);
    }else{
      make.centerY.equalTo(self);
    }
  }];
  [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-SCALE_SIZE*15);
    if ([self.lastString isEqualToString:@"1"]) {
      make.top.mas_equalTo(SCALE_SIZE*8);
    }else if ([self.lastString isEqualToString:@"0"]){
      make.bottom.equalTo(self);
    }else{
      make.centerY.equalTo(self);
    }
  }];
  
  [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(1);
    make.top.left.width.equalTo(self);
  }];
}
-(void)setTitleString:(NSString *)titleString{
  [self.titleLabel setText:titleString];
}
-(void)setDetailString:(NSString *)detailString{
  [self.detailLabel setText:detailString];
}
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_titleLabel setText:@"内容物"];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}
-(UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init];
    [_detailLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_detailLabel setText:@"内容物"];
    [self.contentView addSubview:_detailLabel];
  }
  return _detailLabel;
}
- (UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = BASECOLOR_LINE;
    [_lineView setHidden:YES];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
