//
//  SelectCountCell.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "SelectCountCell.h"

@interface SelectCountCell ()

@property (nonatomic, strong) UIButton  *deleteBtn;   // 减少
@property (nonatomic, strong) UIButton  *addBtn;      // 增加
@property (nonatomic, strong) UILabel   *selectLabel; // 选择的个数
@property (nonatomic, strong) UILabel   *leftLabel;
@property (nonatomic, strong) UILabel   *rightLabel;

@end

@implementation SelectCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  return self;
}

#pragma mark - 添加
- (void)addBtnClick {
  
  if ([self.selectLabel.text integerValue] < 100) {
    NSInteger count =  [self.selectLabel.text integerValue] + 1;
    [self.selectLabel setText:[NSString stringWithFormat:@"%ld",count]];
    [self.addBtn setSelected:NO];
    [self.deleteBtn setSelected:NO];
    if ([self.selectLabel.text integerValue] == 100) {
      [self.addBtn setSelected:YES];
    }

  } else {
    [self.addBtn setSelected:YES];
  }
  
}

#pragma mark - 减少
- (void)deleteBtnClick {
  if ([self.selectLabel.text integerValue] > 0) {
    NSInteger count =  [self.selectLabel.text integerValue] - 1;
    [self.selectLabel setText:[NSString stringWithFormat:@"%ld",count]];
    [self.deleteBtn setSelected:NO];
    [self.addBtn setSelected:NO];
    if ([self.selectLabel.text integerValue] == 0) {
      [self.deleteBtn setSelected:YES];
    }

  } else {
    [self.deleteBtn setSelected:YES];
  }
}

-(UIButton *)addBtn {
  if (!_addBtn) {
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setContentMode:UIViewContentModeScaleAspectFit];
    [_addBtn setImage:[UIImage imageNamed:@"order_btn_add_normal"] forState:UIControlStateNormal];
    [_addBtn setImage:[UIImage imageNamed:@"order_btn_add_normal"] forState:UIControlStateHighlighted];
    [_addBtn setImage:[UIImage imageNamed:@"order_btn_add_selected"] forState:UIControlStateSelected];
    [_addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    
    UILongPressGestureRecognizer *addLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addBtnClick)];
    addLongPress.minimumPressDuration = 0.5; //定义按的时间
    [_addBtn addGestureRecognizer:addLongPress];
  }
  return _addBtn;
}

-(UIButton *)deleteBtn {
  if (!_deleteBtn) {
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setContentMode:UIViewContentModeScaleAspectFit];
    [_deleteBtn setImage:[UIImage imageNamed:@"order_btn_delete_normal"] forState:UIControlStateNormal];
    [_deleteBtn setImage:[UIImage imageNamed:@"order_btn_delete_normal"] forState:UIControlStateHighlighted];
    [_deleteBtn setImage:[UIImage imageNamed:@"order_btn_delete_selected"] forState:UIControlStateSelected];
    [_deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    
    UILongPressGestureRecognizer *deleteLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnClick)];
    deleteLongPress.minimumPressDuration = 0.5; //定义按的时间
    [_deleteBtn addGestureRecognizer:deleteLongPress];
  }
  return _deleteBtn;
}

-(UILabel *)selectLabel {
  if (!_selectLabel) {
    _selectLabel = [[UILabel alloc] init];
    [_selectLabel setTextColor:BASECOLOR_BLACK];
    [_selectLabel setFont:FONTSIZE(14)];
    [_selectLabel setText:@"1"];
    [_selectLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:_selectLabel];
  }
  return _selectLabel;
}

-(UILabel *)leftLabel {
  if (!_leftLabel) {
    _leftLabel = [[UILabel alloc] init];
    [_leftLabel setText:@"共"];
    [_leftLabel setTextColor:BASECOLOR_BLACK_000];
    [_leftLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_leftLabel];
  }
  return _leftLabel;
}

-(UILabel *)rightLabel {
  if (!_rightLabel) {
    _rightLabel = [[UILabel alloc] init];
    [_rightLabel setText:@"套"];
    [_rightLabel setTextColor:BASECOLOR_BLACK_000];
    [_rightLabel setFont:FONTSIZE(14)];
    [self.contentView addSubview:_rightLabel];
  }
  return _rightLabel;
}


-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self).offset(-SCALE_SIZE*10);
    make.centerY.equalTo(self);
  }];
  
  
  [self.addBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.rightLabel.mas_left).offset(-SCALE_SIZE*14);
    make.centerY.equalTo(self);
    make.width.height.mas_equalTo(SCALE_SIZE*30);
  }];
  
  [self.selectLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.addBtn.mas_left);
    make.centerY.equalTo(self.addBtn);
    make.width.mas_equalTo(SCALE_SIZE*46);
//    make.height.mas_equalTo(SCALE_SIZE*20);
  }];
  
  [self.deleteBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.centerY.width.height.equalTo(self.addBtn);
    make.right.equalTo(self.selectLabel.mas_left);
  }];
  
  [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.deleteBtn.mas_left).offset(-SCALE_SIZE*14);
    make.centerY.equalTo(self);
  }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
