//
//  CategoryCell.m
//  YSD_SaaS
//
//  Created by 安东 on 2017/6/5.
//  Copyright © 2017年 安东. All rights reserved.
//

#import "CategoryCell.h"

@interface CategoryCell()

@property (strong, nonatomic) UILabel   *categoryLabel;  ///< 商品类别
@property (nonatomic, strong) UIView    *spitView;
@property (nonatomic, strong) UIView    *lineView;

@end

@implementation CategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

  }
  return self;
}

#pragma mark - 赋值
-(void)setCategoryString:(NSString *)categoryString {
  if (categoryString) {
    [self.categoryLabel setText:categoryString];
  }
}

#pragma mark - setters and getters
-(UILabel *)categoryLabel {
  if (!_categoryLabel) {
    _categoryLabel = [[UILabel alloc] init];
    [_categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [_categoryLabel setTextColor:BASECOLOR_BLACK_030];
    [_categoryLabel setNumberOfLines:2];
    [_categoryLabel setFont:FONTSIZE(13)];
    [self.contentView addSubview:_categoryLabel];
  }
  return _categoryLabel;
}

-(UIView *)spitView {
  if (!_spitView) {
    _spitView = [[UIView alloc] init];
    [_spitView setBackgroundColor:[UIColor hexStringToColor:@"#CCCCCC"]];
    [self.contentView addSubview:_spitView];
  }
  return _spitView;
}

-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_BLACK_000];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.categoryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerX.centerY.equalTo(self);
  }];
  
  [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self);
    make.width.equalTo(self.categoryLabel);
    make.top.equalTo(self.categoryLabel.mas_bottom).offset(SCALE_SIZE*4);
    make.height.mas_equalTo(SCALE_SIZE*3);
  }];
  
  [self.spitView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.height.top.equalTo(self);
    make.width.mas_equalTo(0.5);
  }];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  if (selected) {
    [self.categoryLabel setFont:[UIFont boldSystemFontOfSize:SCALE_SIZE*14.f]];
    [self.lineView setHidden:NO];
  } else {
    [self.categoryLabel setFont:FONTSIZE(13.f)];
    [self.lineView setHidden:YES];
  }
}

@end
