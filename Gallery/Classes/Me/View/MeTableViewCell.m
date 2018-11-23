//
//  MeTableViewCell.m
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import "MeTableViewCell.h"
#import "ImageTitleButton.h"
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
  
  NSArray *array = @[@{@"name":@"定制",@"img":@"me_customized"},
                     @{@"name":@"保存",@"img":@"me_save"},
                     @{@"name":@"地址",@"img":@"me_address"},
                     @{@"name":@"客服",@"img":@"me_customer_service"},
                     @{@"name":@"发票",@"img":@"me_invoice"},
                     @{@"name":@"质检",@"img":@"me_quality_testing"}];
  for (int i = 0; i < array.count; i++) {
    ImageTitleButton *but = [ImageTitleButton buttonWithType:UIButtonTypeCustom];
    int j = i / 4;
    but.frame = CGRectMake((SCREEN_WIDTH - SCALE_SIZE*20)/4 * (i % 4), j * (SCALE_SIZE * 63), (SCREEN_WIDTH - SCALE_SIZE*20)/4, SCALE_SIZE*63);
    [but setTitle:array[i][@"name"] forState:UIControlStateNormal];
    [but setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [[but titleLabel] setFont:FONTSIZE(12)];
    [but addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:array[i][@"img"]] forState:(UIControlStateNormal)];
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
