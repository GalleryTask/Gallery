//
//  PickerView.m
//  Gallery
//
//  Created by 安东 on 2018/9/20.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "PickerView.h"

@interface PickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView   *pickerView;
@property (nonatomic, strong) UIView         *topView;
@property (nonatomic, strong) UIButton       *cancelBtn;
@property (nonatomic, strong) UIButton       *doneBtn;
@property (nonatomic, strong) UILabel        *titleLabel;
@property (nonatomic, strong) UIButton       *overlayBtn;
@property (nonatomic, assign) BOOL           isPop;      // 是否是弹出状态 默认为否
@property (nonatomic, assign) NSInteger      selectedRow;
@property (nonatomic, copy)   NSString       *selectedTitle;
@property (nonatomic, strong) UIView         *backView;

@end

@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
  }
  return self;
}

- (void)pickerViewWithDelegate:(id<PickerViewDelegate>)delegate dataSource:(NSArray *)array title:(NSString *)title {
  // 初始化状态
  self.selectedRow = 0;
  self.selectedTitle = array[0];
  [self.pickerView selectRow:0 inComponent:0 animated:NO];
  
  // 赋值
  self.isPop = true;
  _delegate = delegate;
  _dataArray = array;
  
  [self.titleLabel setText:title];
  
  UIViewController *vc = [CommonUtil getCurrentVC];
  [vc.view addSubview:self];
  
  // 刷新pickerview
  [self.pickerView reloadAllComponents];
  
  [self.overlayBtn setAlpha:1];
  [self updateView];
}

- (void)btnClick:(UIButton *)button {
 
  self.isPop = false;
  [self.overlayBtn setAlpha:0];
  [self updateView];
  [self removeFromSuperview];
  
  //  点击确定button时
  if (button.tag == 200) {
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewWithSelectedRow:selectedTitle:)]) {
      [_delegate pickerViewWithSelectedRow:self.selectedRow selectedTitle:self.selectedTitle];
    }
  }
}


- (void)updateView {
  [self setNeedsUpdateConstraints];
  [self updateConstraintsIfNeeded];
  [UIView animateWithDuration:0.3 animations:^{
    [self layoutIfNeeded];
  }];
}

#pragma mark pickerview function

// 返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  
  return 1;
}

// 返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  
  return [self.dataArray count];
}

// 返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

  return 40.0f;
}


// 显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
  
  NSString *str = [self.dataArray objectAtIndex:row];
  
  return str;
}

// 显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
  
  NSString *str = [self.dataArray objectAtIndex:row];
  
  NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
  
  [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:BASECOLOR_BLACK} range:NSMakeRange(0, [AttributedString  length])];
  
  return AttributedString;
}


// 被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
  
  self.selectedRow = row;
  self.selectedTitle = [self.dataArray objectAtIndex:row];
}



#pragma mark - getters
-(UIButton *)overlayBtn {
  if (!_overlayBtn) {
    _overlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_overlayBtn setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    [_overlayBtn setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
    [_overlayBtn setAlpha:0];
    [_overlayBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_overlayBtn];
  }
  return _overlayBtn;
}

-(UIView *)backView {
  if (!_backView) {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE*44+SCREEN_HEIGHT, SCREEN_WIDTH, SCALE_SIZE*244)];
    [_backView setBackgroundColor:[UIColor whiteColor]];
    [self.overlayBtn addSubview:_backView];
  }
  return _backView;
}

-(UIPickerView *)pickerView {
  if (!_pickerView) {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*200)];
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
    [self.backView addSubview:_pickerView];
  }
  return _pickerView;
}


-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_MIDDLEBLACK];
    [_titleLabel setFont:FONTSIZE(14)];
//    [_titleLabel setText:@"到货时间"];
    [self.topView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UIButton *)cancelBtn {
  if (!_cancelBtn) {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:BASECOLOR_BLACK forState:UIControlStateNormal];
    [[_cancelBtn titleLabel] setFont:FONTSIZE(14)];
    [_cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setTag:100];
    [self.topView addSubview:_cancelBtn];
  }
  return _cancelBtn;
}

-(UIButton *)doneBtn {
  if (!_doneBtn) {
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_doneBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_doneBtn setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [[_doneBtn titleLabel] setFont:FONTSIZE(14)];
    [_doneBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_doneBtn setTag:200];
    [self.topView addSubview:_doneBtn];
  }
  return _doneBtn;
}

-(UIView *)topView {
  if (!_topView) {
    _topView = [[UIView alloc] init];
    [_topView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
    [_topView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*44)];
    [self.backView addSubview:_topView];
  }
  return _topView;
}

-(void)updateConstraints {
  [super updateConstraints];
  
  [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self);
    make.height.mas_equalTo(SCALE_SIZE*244+SafeAreaBottomHeight);
    if (self.isPop) {
      make.bottom.equalTo(self.overlayBtn).offset(-NAVIGATIONBAR_HEIGHT);
    } else {
      make.bottom.equalTo(self).offset(SCALE_SIZE*244+SafeAreaBottomHeight);
    }
  }];
 
}

-(void)layoutSubviews {
  [super layoutSubviews];
  
  [self.overlayBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  
  [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.width.left.equalTo(self.backView);
    make.height.mas_equalTo(SCALE_SIZE*44);
  }];
  
  [self.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.width.left.equalTo(self);
    make.top.equalTo(self.topView.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*200);
  }];
  
 
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.centerY.equalTo(self.topView);
  }];
  
  [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.height.equalTo(self.topView);
    make.width.mas_equalTo(SCALE_SIZE*50);
  }];
  
  [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.top.height.equalTo(self.topView);
    make.width.mas_equalTo(SCALE_SIZE*50);
  }];
}


@end
