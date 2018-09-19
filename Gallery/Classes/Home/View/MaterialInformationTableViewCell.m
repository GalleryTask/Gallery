//
//  MaterialInformationTableViewCell.m
//  Gallery
//
//  Created by admin on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "MaterialInformationTableViewCell.h"
@interface MaterialInformationTableViewCell ()

@property (strong, nonatomic) UILabel    *titlelabel;
@property (strong, nonatomic) UITextField *detailTextField;
@property (strong, nonatomic) UIView     *spitView;   // 分割view

@end
@implementation MaterialInformationTableViewCell

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
-(UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] init];
        [_titlelabel setTextColor:BASECOLOR_BLACK];
        [_titlelabel setFont:FONTSIZE(15)];
        _titlelabel.text = @"面纸";
        [self.contentView addSubview:_titlelabel];
    }
    return _titlelabel;
}

-(UITextField *)detailTextField{
    if (!_detailTextField) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.enabled = NO;
        [_detailTextField setFont:FONTSIZE(15)];
        _detailTextField.placeholder = @"请选择";
        [self.contentView addSubview:_detailTextField];
    }
    return _detailTextField;
}
-(UIView *)spitView {
    if (!_spitView) {
        _spitView = [[UIView alloc] init];
        [_spitView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
        [self.contentView addSubview:_spitView];
    }
    return _spitView;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.spitView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titlelabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self);
      make.width.mas_equalTo(100);
    }];
    
    [self.detailTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.titlelabel.mas_right);
      make.right.mas_equalTo(15);
      make.centerY.equalTo(self);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
