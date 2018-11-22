//
//  OrderFooterCell.m
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderFooterCell.h"

@interface OrderFooterCell ()

@property (nonatomic, strong) UIView  *lineView;

@end

@implementation OrderFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// 重写cell的frame 使得cell间有空隙
-(void)setFrame:(CGRect)frame {
  
  frame.origin.x = SCALE_SIZE*10;
  frame.size.width -= SCALE_SIZE*20;
  
  self.layer.masksToBounds = NO;
  
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  
  [super setFrame:frame];
}

-(id)initWithDic:(NSDictionary *)dic {
 
  UIRectCorner corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
  
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:corner
                                                       cornerRadii:CGSizeMake(13, 13)];
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.frame = self.bounds;
  maskLayer.path = maskPath.CGPath;
  self.layer.mask = maskLayer;
  
  return self;
}

#pragma marks - getters
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
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.width.equalTo(self).offset(-SCALE_SIZE*20);
    make.height.mas_equalTo(0.5);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
