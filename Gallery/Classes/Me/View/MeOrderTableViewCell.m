//
//  MeOrderTableViewCell.m
//  Gallery
//
//  Created by admin on 2018/11/22.
//  Copyright © 2018 安东. All rights reserved.
//

#import "MeOrderTableViewCell.h"
@interface MeOrderTableViewCell ()

@property (strong, nonatomic) UILabel             *titleLabel;
@property (strong, nonatomic) UIButton            *orderButton;
@property (strong, nonatomic) UIView              *lineView;
@property (strong, nonatomic) UIView              *backView;          // 背景
@property (strong, nonatomic) UILabel             *timeLabel;
@property (strong, nonatomic) UILabel             *orderTitleLabel;
@property (strong, nonatomic) UILabel             *logisticsLabel;
@property (strong, nonatomic) UILabel             *detailLabel;
@property (strong, nonatomic) UIButton            *logisticsButton;
@end
@implementation MeOrderTableViewCell

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
  NSArray *array = @[@"待付款",@"待处理",@"待收货",@"已完成",@"售后"];
  for (int i = 0; i < array.count; i++) {
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake((SCREEN_WIDTH - SCALE_SIZE*20)/5 * i, SCALE_SIZE*31, (SCREEN_WIDTH - SCALE_SIZE*20)/5, SCALE_SIZE*80);
    [but setTitle:array[i] forState:UIControlStateNormal];
    [but setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
    [[but titleLabel] setFont:FONTSIZE(12)];
    [but addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:@"tool_button_home_selected"] forState:(UIControlStateNormal)];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [but setTitleEdgeInsets:UIEdgeInsetsMake(SCALE_SIZE*80-SCALE_SIZE*28, -but.imageView.frame.size.width, 0, 0)];
    [but setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, -but.titleLabel.bounds.size.width)];
    [but setTag:1000+i];
    [self addSubview:but];
  }
}
-(void)orderButtonClick:(UIButton *)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(orderButtonIndex:)]) {
    [_delegate orderButtonIndex:sender.tag-1000];
  }
}
-(void)logisticsButtonClick:(UIButton *)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(meLogisticsClick)]) {
    [_delegate meLogisticsClick];
  }
}
-(void)layoutSubviews {
  [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE*6);
  }];
  [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.right.equalTo(self.mas_right).offset(-SCALE_SIZE*10);
    make.height.mas_equalTo(1);
    make.top.mas_equalTo(SCALE_SIZE*32);
  }];
  [self.orderButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.mas_right).offset(-SCALE_SIZE*10);
    make.top.equalTo(self);
    make.height.mas_equalTo(SCALE_SIZE*32);
    make.width.mas_equalTo(SCALE_SIZE*80);
  }];
  
  [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.mas_bottom).offset(-SCALE_SIZE*10);
    make.left.mas_equalTo(SCALE_SIZE*20);
    make.right.mas_equalTo(-SCALE_SIZE*20);
    make.height.mas_equalTo(SCALE_SIZE*82);
  }];
  
  [self.logisticsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE*8);
  }];
  
  [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(SCALE_SIZE*8);
    make.right.equalTo(self.backView.mas_right).offset(-SCALE_SIZE*6);
  }];
  
  [self.orderTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE*31);
  }];
  
  [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*10);
    make.top.mas_equalTo(SCALE_SIZE*57);
    make.right.equalTo(self.backView.mas_right).offset(-SCALE_SIZE*10);
  }];
  
  [self.logisticsButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.left.height.with.equalTo(self.backView);
  }];
}
-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_titleLabel setText:@"我的订单"];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}
-(UIButton *)orderButton {
  if (!_orderButton) {
    _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_orderButton setTitle:@"全部订单" forState:UIControlStateNormal];
    [_orderButton setTitleColor:BASECOLOR_BLACK_999 forState:UIControlStateNormal];
    [[_orderButton titleLabel] setFont:FONTSIZE(12)];
    [_orderButton addTarget:self action:@selector(orderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_orderButton setImage:[UIImage imageNamed:@"arrow"] forState:(UIControlStateNormal)];
    [_orderButton setImageEdgeInsets:UIEdgeInsetsMake(0, SCALE_SIZE*65, 0, 0)];
    [_orderButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, SCALE_SIZE*13)];
    [_orderButton setTag:1000];
    [self addSubview:_orderButton];
  }
  return _orderButton;
}
-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}
-(UIView *)backView {
  if (!_backView) {
    _backView = [[UIView alloc] init];
    [_backView setBackgroundColor:[UIColor hexStringToColor:@"#F2F2F2"]];
    [self.contentView addSubview:_backView];
  }
  return _backView;
}
-(UILabel *)timeLabel {
  if (!_timeLabel) {
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setTextColor:BASECOLOR_BLACK_999];
    [_timeLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*12.f]];
    [_timeLabel setText:@"2018/10/22  18:45"];
    [self.backView addSubview:_timeLabel];
  }
  return _timeLabel;
}
-(UILabel *)orderTitleLabel {
  if (!_orderTitleLabel) {
    _orderTitleLabel = [[UILabel alloc] init];
    [_orderTitleLabel setTextColor:BASECOLOR_BLACK_050];
    [_orderTitleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_orderTitleLabel setText:@"苹果高档礼品包装方案"];
    [self.backView addSubview:_orderTitleLabel];
  }
  return _orderTitleLabel;
}
-(UILabel *)logisticsLabel {
  if (!_logisticsLabel) {
    _logisticsLabel = [[UILabel alloc] init];
    [_logisticsLabel setTextColor:BASECOLOR_BLACK_999];
    [_logisticsLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*12.f]];
    [_logisticsLabel setText:@"最新物流"];
    [self.backView addSubview:_logisticsLabel];
  }
  return _logisticsLabel;
}
-(UILabel *)detailLabel {
  if (!_detailLabel) {
    _detailLabel = [[UILabel alloc] init];
    [_detailLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*12.f]];
    [_detailLabel setText:@"您的订单已达到【丰台科技园】快递小哥联系电话18345179888"];
    [self.backView addSubview:_detailLabel];
  }
  return _detailLabel;
}
-(UIButton *)logisticsButton {
  if (!_logisticsButton) {
    _logisticsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logisticsButton addTarget:self action:@selector(logisticsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_logisticsButton];
  }
  return _logisticsButton;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
