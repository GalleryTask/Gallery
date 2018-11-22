//
//  MeTableViewCell.m
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import "MeTableViewCell.h"
@interface MeTableViewCell ()

@end
@implementation MeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
// 重写cell的frame 使得cell间有空隙
-(void)setFrame:(CGRect)frame {
  
  frame.origin.x = SCALE_SIZE*10;
  frame.origin.y += SCALE_SIZE*10;
  frame.size.height -= SCALE_SIZE*10;
  frame.size.width -= SCALE_SIZE*20;
  
  self.layer.masksToBounds = NO;
  //  self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
  //  self.layer.shadowOpacity = 0.1f;
  //  self.layer.shadowOffset = CGSizeMake(0,0);
  
  self.layer.cornerRadius = 13.0;
  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  [super setFrame:frame];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addButton];
  }
  return self;
}
-(void)addButton {
  NSArray *array = @[@"定制",@"保存",@"地址",@"客服",@"发票",@"质检"];
  for (int i = 0; i < array.count; i++) {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    int j = i / 4;
    but.frame = CGRectMake((SCREEN_WIDTH - SCALE_SIZE*20)/4 * (i % 4), j * (SCALE_SIZE * 63), (SCREEN_WIDTH - SCALE_SIZE*20)/4, SCALE_SIZE*63);
    [but setTitle:array[i] forState:UIControlStateNormal];
    [but setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [[but titleLabel] setFont:FONTSIZE(12)];
    [but addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:@"tool_button_home_selected"] forState:(UIControlStateNormal)];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [but setTitleEdgeInsets:UIEdgeInsetsMake(SCALE_SIZE*80-SCALE_SIZE*28, -but.imageView.frame.size.width, 0, 0)];
    [but setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, -but.titleLabel.bounds.size.width)];
    [but setTag:2000+i];
    [self addSubview:but];
  }
}
-(void)orderButtonClick:(UIButton *)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(meCellButtonIndex:)]) {
    [_delegate meCellButtonIndex:sender.tag-2000];
  }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
