//
//  SelectTableViewCell.m
//  Gallery
//
//  Created by admin on 2018/9/27.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "SelectTableViewCell.h"
@interface SelectTableViewCell()

@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UIView   *lineView;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UIImageView  *imgView;

@end
@implementation SelectTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      self.selectionStyle = UITableViewCellSelectionStyleNone;
//        [self setClipsToBounds:YES];
    }
    return self;
}

-(void)setTitleString:(NSString *)titleString {
    if (titleString) {
      [self.titleLabel setText:titleString];
    }
}

-(void)setImgString:(NSString *)imgString {
  if (imgString) {
    [self.imgView setImage:[UIImage imageNamed:imgString]];
  }
}

#pragma marks - getters
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextColor:BASECOLOR_BLACK_333];
        [_titleLabel setFont:FONTSIZE(14)];
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

-(UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.image = [UIImage imageNamed:@"btn-weixuanzhong"];
        [self.contentView addSubview:_selectImageView];
    }
    return _selectImageView;
}

-(UIImageView *)imgView {
  if (!_imgView) {
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
  }
  return _imgView;
}

-(void)layoutSubviews {
    [super layoutSubviews];
  
  [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*15);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE*24);
  }];
  
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.imgView.mas_right).offset(SCALE_SIZE*12);
    make.centerY.equalTo(self);
  }];
  
//  [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
//    make.left.bottom.width.equalTo(self);
//    make.height.mas_equalTo(1);
//  }];
  
  [self.selectImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*20);
    make.centerY.equalTo(self);
    make.height.mas_equalTo(22);
    make.width.mas_equalTo(22);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  UIColor *lineColor = self.lineView.backgroundColor;
  [super setSelected:selected animated:animated];
  self.lineView.backgroundColor = lineColor;
  
  if (selected) {
    self.selectImageView.image = [UIImage imageNamed:@"btn-xuanzhong"];
  } else{
    self.selectImageView.image = [UIImage imageNamed:@"btn-weixuanzhong"];
  }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    UIColor *lineColor = self.lineView.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    self.lineView.backgroundColor = lineColor;
}

@end
