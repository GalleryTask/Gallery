//
//  AddressEditView.m
//  Gallery
//
//  Created by admin on 2018/11/16.
//  Copyright © 2018 安东. All rights reserved.
//

#import "AddressEditView.h"
@interface AddressEditView ()<UITextFieldDelegate>

@property (strong, nonatomic) UIView             *backView;          // 背景
@property (strong, nonatomic) UIView             *switchView;        // 默认选中背景
@property (strong, nonatomic) UILabel            *switchLabel;
@property (strong, nonatomic) UISwitch           *defaultSwitch;//默认开关

@property (strong, nonatomic) UIButton           *companyButton;
@property (strong, nonatomic) UIButton           *officeButton;
@property (strong, nonatomic) UIButton           *warehouseButton;
@end
@implementation AddressEditView

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
    [self setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
//    [self addGestureRecognizer:tap];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*300)];
    [self.backView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.backView];
    
    NSArray *array = @[@"收  货  人",@"手机账号",@"所在城市",@"收货地址",@"楼号门牌",@"地址类型"];
    for (int i = 0; i < array.count; i ++) {
      UILabel *promptLabel = [[UILabel alloc] init];
      [promptLabel setFrame:CGRectMake(SCALE_SIZE*20, SCALE_SIZE*18+SCALE_SIZE*50*i, SCALE_SIZE*70, SCALE_SIZE*14)];
      [promptLabel setTextColor:BASECOLOR_BLACK_333];
      [promptLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
      [promptLabel setText:array[i]];
      [self.backView addSubview:promptLabel];
      
      UIView *lineView = [[UIView alloc] init];
      [lineView setFrame:CGRectMake(SCALE_SIZE*20, SCALE_SIZE*50*(i+1), SCREEN_WIDTH-SCALE_SIZE*20, 0.5)];
      [lineView setBackgroundColor:BASECOLOR_LINE];
      [self.backView addSubview:lineView];
      
      if (i == 5) {
        [lineView setHidden:YES];
      }
    }
    
  }
  return self;
}
#pragma mark =====所在城市按钮点击事件
-(void)cityBtnClick {
  
}
#pragma mark =====默认选择事件
-(void)defaultSwitchAction:(UISwitch *)sender {
  if (_delegate && [_delegate respondsToSelector:@selector(addressEditDefaultSwitch:)]) {
    [_delegate addressEditDefaultSwitch:sender.isOn];
  }
}
#pragma mark =====公司按钮点击事件
-(void)companyButtonClick:(UIButton *)sender {
  [self addressEditType:1];
}
#pragma mark =====办公室按钮点击事件
-(void)officeButtonClick:(UIButton *)sender {
  [self addressEditType:2];
}
#pragma mark =====仓库按钮点击事件
-(void)warehouseButtonClick:(UIButton *)sender {
  [self addressEditType:3];
}
-(void)addressEditType:(NSInteger)index{
  NSString *typeStr;
  [self.companyButton setTitleColor:BASECOLOR_GRAY_CC forState:UIControlStateNormal];
  [self.companyButton.layer setBorderColor:BASECOLOR_GRAY_CC.CGColor];
  [self.officeButton setTitleColor:BASECOLOR_GRAY_CC forState:UIControlStateNormal];
  [self.officeButton.layer setBorderColor:BASECOLOR_GRAY_CC.CGColor];
  [self.warehouseButton setTitleColor:BASECOLOR_GRAY_CC forState:UIControlStateNormal];
  [self.warehouseButton.layer setBorderColor:BASECOLOR_GRAY_CC.CGColor];
  if (index == 1) {
    typeStr = self.companyButton.titleLabel.text;
    [self.companyButton setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [self.companyButton.layer setBorderColor:BASECOLOR_BLUE.CGColor];
  }else if (index == 2){
    typeStr = self.officeButton.titleLabel.text;
    [self.officeButton setTitleColor:[UIColor hexStringToColor:@"#15BC83"] forState:UIControlStateNormal];
    [self.officeButton.layer setBorderColor:[UIColor hexStringToColor:@"#15BC83"].CGColor];
  }else{
    typeStr = self.warehouseButton.titleLabel.text;
    [self.warehouseButton setTitleColor:[UIColor hexStringToColor:@"#FF943E"] forState:UIControlStateNormal];
    [self.warehouseButton.layer setBorderColor:[UIColor hexStringToColor:@"#FF943E"].CGColor];
  }
  if (_delegate && [_delegate respondsToSelector:@selector(addressEditType:)]) {
    [_delegate addressEditType:typeStr];
  }
}
-(void)layoutSubviews {
  [super layoutSubviews];
  [self.nameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE * 100);
    make.top.equalTo(self);
    make.width.equalTo(self).offset(-SCALE_SIZE * 100);
    make.height.mas_equalTo(SCALE_SIZE * 50);
  }];
  
  [self.phoneTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.nameTextField);
    make.top.equalTo(self.nameTextField.mas_bottom);
  }];
  
  [self.cityBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.phoneTextField);
    make.top.equalTo(self.phoneTextField.mas_bottom);
  }];
  
  [self.addressTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.cityBtn);
    make.top.equalTo(self.cityBtn.mas_bottom);
  }];
  
  [self.detailAddressField mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.height.equalTo(self.addressTextField);
    make.top.equalTo(self.addressTextField.mas_bottom);
  }];
  
  [self.companyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.backView.mas_bottom).offset(-SCALE_SIZE*18);
    make.height.mas_equalTo(SCALE_SIZE*16);
    make.width.mas_equalTo(SCALE_SIZE*49);
    make.left.equalTo(self.detailAddressField);
  }];
  
  [self.officeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.height.top.width.equalTo(self.companyButton);
    make.left.equalTo(self.companyButton.mas_right).offset(SCALE_SIZE*15);
  }];
  
  [self.warehouseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.height.top.width.equalTo(self.officeButton);
    make.left.equalTo(self.officeButton.mas_right).offset(SCALE_SIZE*15);
  }];
  
  [self.switchView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self);
    make.top.equalTo(self.backView.mas_bottom).offset(10);
    make.height.mas_equalTo(SCALE_SIZE * 50);
  }];
  
  [self.switchLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(SCALE_SIZE*20);
    make.top.mas_equalTo(SCALE_SIZE*18);
  }];
  
  [self.defaultSwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.right.mas_equalTo(-SCALE_SIZE*20);
    make.height.mas_equalTo(SCALE_SIZE*30);
    make.width.mas_equalTo(SCALE_SIZE*50);
    make.centerY.equalTo(self);
  }];
}
-(UITextField *)nameTextField {
  if (!_nameTextField) {
    _nameTextField = [[UITextField alloc] init];
    [_nameTextField setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_nameTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_nameTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_nameTextField setDelegate:self];
    [_nameTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_nameTextField setReturnKeyType:UIReturnKeyDone];
    [_nameTextField setPlaceholder:@"收货人姓名"];
    [self.backView addSubview:_nameTextField];
  }
  return _nameTextField;
}
-(UITextField *)phoneTextField {
  if (!_phoneTextField) {
    _phoneTextField = [[UITextField alloc] init];
    [_phoneTextField setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_phoneTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_phoneTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_phoneTextField setDelegate:self];
    [_phoneTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_phoneTextField setReturnKeyType:UIReturnKeyDone];
    [_phoneTextField setPlaceholder:@"配送员联系您的电话"];
    [self.backView addSubview:_phoneTextField];
  }
  return _phoneTextField;
}
-(UITextField *)addressTextField {
  if (!_addressTextField) {
    _addressTextField = [[UITextField alloc] init];
    [_addressTextField setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_addressTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_addressTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_addressTextField setDelegate:self];
    [_addressTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_addressTextField setReturnKeyType:UIReturnKeyDone];
    [_addressTextField setPlaceholder:@"小区/写字楼"];
    [self.backView addSubview:_addressTextField];
  }
  return _addressTextField;
}
-(UITextField *)detailAddressField {
  if (!_detailAddressField) {
    _detailAddressField = [[UITextField alloc] init];
    [_detailAddressField setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_detailAddressField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_detailAddressField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_detailAddressField setDelegate:self];
    [_detailAddressField setKeyboardType:UIKeyboardTypeNumberPad];
    [_detailAddressField setReturnKeyType:UIReturnKeyDone];
    [_detailAddressField setPlaceholder:@"楼号/单元/门牌号"];
    [self.backView addSubview:_detailAddressField];
  }
  return _detailAddressField;
}
-(UIButton *)cityBtn {
  if (!_cityBtn) {
    _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //    [[_addressSelectBtn titleLabel] setTextColor:BASECOLOR_BLACK];
    [_cityBtn setTitleColor:[UIColor hexStringToColor:@"#CCCCCC"] forState:UIControlStateNormal];
    [[_cityBtn titleLabel] setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_cityBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_cityBtn setTitle:@"选择您所在的城市" forState:(UIControlStateNormal)];
    [self.backView addSubview:_cityBtn];
  }
  return _cityBtn;
}

-(UIView *)switchView {
  if (!_switchView) {
    _switchView = [[UIView alloc] init];
    [_switchView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:_switchView];
  }
  return _switchView;
}
-(UILabel *)switchLabel {
  if (!_switchLabel) {
    _switchLabel = [[UILabel alloc] init];
    [_switchLabel setTextColor:BASECOLOR_BLACK_333];
    [_switchLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*14.f]];
    [_switchLabel setText:@"设置默认地址"];
    [self.switchView addSubview:_switchLabel];
  }
  return _switchLabel;
}
-(UISwitch *)defaultSwitch {
  if (!_defaultSwitch) {
    _defaultSwitch = [[UISwitch alloc] init];
    [_defaultSwitch addTarget:self action:@selector(defaultSwitchAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_defaultSwitch setOnTintColor:BASECOLOR_BLUE];
    [self.switchView addSubview:_defaultSwitch];
  }
  return _defaultSwitch;
}
-(UIButton *)companyButton {
  if (!_companyButton) {
    _companyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_companyButton setTitle:@"公司" forState:UIControlStateNormal];
    [_companyButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_companyButton.layer setMasksToBounds:YES];
    [_companyButton.layer setCornerRadius:3];
    [_companyButton.layer setBorderWidth:1];
    [_companyButton setTitleColor:BASECOLOR_GRAY_CC forState:UIControlStateNormal];
    [_companyButton.layer setBorderColor:BASECOLOR_GRAY_CC.CGColor];
    [[_companyButton titleLabel] setFont:FONTSIZE(10)];
    [_companyButton addTarget:self action:@selector(companyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_companyButton];
  }
  return _companyButton;
}
-(UIButton *)officeButton {
  if (!_officeButton) {
    _officeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_officeButton setTitle:@"办公室" forState:UIControlStateNormal];
    [_officeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_officeButton.layer setMasksToBounds:YES];
    [_officeButton.layer setCornerRadius:3];
    [_officeButton.layer setBorderWidth:1];
    [_officeButton setTitleColor:BASECOLOR_GRAY_CC forState:UIControlStateNormal];
    [_officeButton.layer setBorderColor:BASECOLOR_GRAY_CC.CGColor];
    [[_officeButton titleLabel] setFont:FONTSIZE(10)];
    [_officeButton addTarget:self action:@selector(officeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_officeButton];
  }
  return _officeButton;
}
-(UIButton *)warehouseButton {
  if (!_warehouseButton) {
    _warehouseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_warehouseButton setTitle:@"仓库" forState:UIControlStateNormal];
    [_warehouseButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_warehouseButton.layer setMasksToBounds:YES];
    [_warehouseButton.layer setCornerRadius:3];
    [_warehouseButton.layer setBorderWidth:1];
    [_warehouseButton setTitleColor:BASECOLOR_GRAY_CC forState:UIControlStateNormal];
    [_warehouseButton.layer setBorderColor:BASECOLOR_GRAY_CC.CGColor];
    [[_warehouseButton titleLabel] setFont:FONTSIZE(10)];
    [_warehouseButton addTarget:self action:@selector(warehouseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_warehouseButton];
  }
  return _warehouseButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
