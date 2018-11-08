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
    [_categoryLabel setTextColor:BASECOLOR_BLACK];
    [_categoryLabel setNumberOfLines:2];
    [_categoryLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*13.f]];
    [self.contentView addSubview:_categoryLabel];
  }
  return _categoryLabel;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.categoryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  if (selected) {
    self.categoryLabel.textColor = BASECOLOR_BLACK;
    [self.categoryLabel setFont:[UIFont boldSystemFontOfSize:SCALE_SIZE*15.f]];
    [self.categoryLabel setBackgroundColor:[UIColor whiteColor]];
  } else {
    self.categoryLabel.textColor = BASECOLOR_LIGHTBLACK;
    [self.categoryLabel setFont:FONTSIZE(13.f)];
    [self.categoryLabel setBackgroundColor:BASECOLOR_LIGHTGRAY];
  }
}

-(void)dealloc {
  
}
@end
