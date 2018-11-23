//
//  OrderCell.m
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderHeaderCell.h"

@interface OrderHeaderCell ()

@property (nonatomic, strong) UIButton  *selectedBtn;
@property (nonatomic, strong) UIView  *lineView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) UILabel  *tagLabel;
@property (strong, nonatomic) UIImageView  *arrowImgView;
@property (nonatomic, strong) UILabel  *statusLabel;
@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation OrderHeaderCell

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

  self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame] ;
  self.selectedBackgroundView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
  
  [super setFrame:frame];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

-(id)initWithData:(PlaceOrderResult *)data isEdit:(BOOL)isEdit {

  UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerTopRight;
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:corner
                                                       cornerRadii:CGSizeMake(13, 13)];
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  maskLayer.frame = self.bounds;
  maskLayer.path = maskPath.CGPath;
  self.layer.mask = maskLayer;
  
  [self.titleLabel setText:data.title];
  
  self.isEdit = isEdit;
  
  if (!self.isEdit) {
    [self.selectedBtn setHidden:YES];
  }
  switch ([data.tag intValue]) {
    case 0:
    {
      [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0);
      }];
    }
      break;
    case 1:
    {
      [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCALE_SIZE*49);
      }];
      [self.tagLabel setText:@"打样订单"];
      [[self.tagLabel layer] setBorderColor:[UIColor hexStringToColor:@"#15BC83"].CGColor];
      [self.tagLabel setTextColor:[UIColor hexStringToColor:@"#15BC83"]];
    }
      break;
    case 2:
    {
      [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCALE_SIZE*49);
      }];
      [self.tagLabel setText:@"生产订单"];
      [[self.tagLabel layer] setBorderColor:[UIColor hexStringToColor:@"#3296FA"].CGColor];
      [self.tagLabel setTextColor:[UIColor hexStringToColor:@"#3296FA"]];
    }
      break;
      
    default:
      break;
  }
  
  [self.selectedBtn setSelected:data.isSelected];
  
  
  return self;
}

-(void)setIndexPath:(NSIndexPath *)indexPath {
  _indexPath = indexPath;
}
#pragma mark -
- (void)selectedBtnClick {

  self.selectedBtn.selected = !self.selectedBtn.isSelected;
  if (_delegate && [_delegate respondsToSelector:@selector(orderHeaderCellWithSelected:index:)]) {
    [_delegate orderHeaderCellWithSelected:self.selectedBtn.selected index:_indexPath.section];
  }
}

#pragma marks - getters
-(UIButton *)selectedBtn {
  if (!_selectedBtn) {
    _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedBtn setImage:[UIImage imageNamed:@"btn_default"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    [_selectedBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectedBtn];
  }
  return _selectedBtn;
}

-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self.contentView addSubview:_lineView];
  }
  return _lineView;
}

-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setFont:FONTSIZE(16)];
    [self.contentView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)statusLabel {
  if (!_statusLabel) {
    _statusLabel = [[UILabel alloc] init];
    [_statusLabel setTextColor:[UIColor hexStringToColor:@"#FFB000"]];
    [_statusLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_statusLabel];
  }
  return _statusLabel;
}

-(UILabel *)tagLabel {
  if (!_tagLabel) {
    _tagLabel = [[UILabel alloc] init];
    [[_tagLabel layer] setBorderWidth:1];
    [[_tagLabel layer] setBorderColor:[UIColor hexStringToColor:@"#15BC83"].CGColor];
    [_tagLabel setTextColor:[UIColor hexStringToColor:@"#15BC83"]];
    [_tagLabel setFont:FONTSIZE(10)];
    [_tagLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_tagLabel];
  }
  return _tagLabel;
}

-(UIImageView *)arrowImgView {
  if (!_arrowImgView) {
    _arrowImgView = [[UIImageView alloc] init];
    [_arrowImgView setContentMode:UIViewContentModeScaleAspectFit];
    [_arrowImgView setImage:[UIImage imageNamed:@"arrow"]];
    [_arrowImgView setUserInteractionEnabled:NO];
    [self.contentView addSubview:_arrowImgView];
  }
  return _arrowImgView;
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*8);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE*38);
  }];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(SCALE_SIZE*10);
    make.width.equalTo(self).offset(-SCALE_SIZE*20);
    make.bottom.equalTo(self);
    make.height.mas_equalTo(0.5);
  }];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    if (self.isEdit) {
      
      make.left.equalTo(self.selectedBtn.mas_right).offset(SCALE_SIZE*6);
    } else {
      make.left.equalTo(self).offset(SCALE_SIZE*16);
    }
    make.centerY.equalTo(self);
  }];
  
  [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.titleLabel.mas_right).offset(SCALE_SIZE*12);
    make.centerY.equalTo(self.titleLabel);
    make.width.mas_equalTo(SCALE_SIZE*49);
    make.height.mas_equalTo(SCALE_SIZE*16);
  }];
  
  [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.tagLabel.mas_right).offset(SCALE_SIZE*12);
    make.centerY.equalTo(self.titleLabel);
    make.width.height.mas_equalTo(SCALE_SIZE*16);
  }];
  
  [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*10);
    make.centerY.equalTo(self.titleLabel);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
