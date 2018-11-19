//
//  PickerView.m
//  Gallery
//
//  Created by 安东 on 2018/9/20.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "PickerView.h"
#import "SelectTableViewCell.h"
@interface PickerView () <UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource> {
  float height;
}

@property (nonatomic, strong) UIPickerView   *pickerView;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UIView         *topView;
@property (nonatomic, strong) UIButton       *cancelBtn;
@property (nonatomic, strong) UIButton       *doneBtn;
@property (nonatomic, strong) UILabel        *titleLabel;
@property (nonatomic, strong) UIButton       *overlayBtn;
@property (nonatomic, assign) BOOL           isPop;      // 是否是弹出状态 默认为否
@property (nonatomic, assign) NSInteger      row;
@property (nonatomic, copy)   NSString       *selectedTitle;
@property (nonatomic, copy)   NSString       *selectedId;
@property (nonatomic, strong) UIView         *backView;

@end

@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
      
  }
  return self;
}

- (void)pickerViewWithDelegate:(id<PickerViewDelegate>)delegate dataSource:(NSArray *)array title:(NSString *)title selectedRow:(NSInteger)selectedRow {
  // 初始化状态
  self.row = selectedRow;
  self.selectedTitle = array[self.row][@"name"];
  self.selectedId = array[self.row][@"id"];
  
  // 赋值
  self.isPop = true;
  _delegate = delegate;
  _dataArray = array;
  height = SCALE_SIZE*200;
  
  [self.titleLabel setText:title];
  
  UIViewController *vc = [CommonUtil getCurrentVC];
  [vc.view addSubview:self];
  
  // 创建pickerView
  [self.backView addSubview:self.pickerView];
  [self.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.width.left.equalTo(self);
    make.top.equalTo(self.topView.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*200);
  }];
  
  // 刷新pickerview
  [self.pickerView reloadAllComponents];
  
  [self.overlayBtn setAlpha:1];
  [self updateView];
  
  [self.pickerView selectRow:selectedRow inComponent:0 animated:YES];
}

- (void)tableViewWithDelegate:(id<PickerViewDelegate>)delegate dataSource:(NSArray *)array title:(NSString *)title {
  
  UIViewController *vc = [CommonUtil getCurrentVC];
  [vc.view addSubview:self];
  self.selectedTitle = @"";
  height = SCALE_SIZE*110;
  
  [self.backView addSubview:self.tableView];
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.width.left.equalTo(self);
    make.top.equalTo(self.topView.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*110);
  }];
  
  self.isPop = true;
  _delegate = delegate;
  _dataArray = array;
  [self.titleLabel setText:title];
  [self.overlayBtn setAlpha:1];
  [self updateView];
}



- (void)btnClick:(UIButton *)button {
 
  self.isPop = false;
  [self.overlayBtn setAlpha:0];
  [self updateView];
  [self removeFromSuperview];
  [self.pickerView removeFromSuperview];
  [self.tableView removeFromSuperview];
  
  //  点击确定button时
  if (button.tag == 200) {
    if ([self.selectedTitle isEqualToString:@""]) {
      
      for (NSIndexPath *indexPath in self.tableView.indexPathsForSelectedRows) {
        NSString *str = self.dataArray[indexPath.row][@"name"];
        self.selectedTitle = [self.selectedTitle stringByAppendingString:[NSString stringWithFormat:@"%@、",str]];
      }
      if (self.selectedTitle.length > 1) {
        
        self.selectedTitle = [self.selectedTitle stringByReplacingCharactersInRange:NSMakeRange(self.selectedTitle.length-1, 1) withString:@""];
      }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(pickerViewWithSelectedRow:selectedTitle:selectedId:)]) {
      [_delegate pickerViewWithSelectedRow:self.row selectedTitle:self.selectedTitle selectedId:self.selectedId];
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
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  
  NSString *str = [self.dataArray objectAtIndex:row][@"name"];
  
  return str;
}

// 显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
  
  NSString *str = [self.dataArray objectAtIndex:row][@"name"];
  
  NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
  
  [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:BASECOLOR_BLACK} range:NSMakeRange(0, [AttributedString  length])];
  
  return AttributedString;
}


// 被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  
  self.row = row;
  self.selectedTitle = [self.dataArray objectAtIndex:row][@"name"];
  self.selectedId = [self.dataArray objectAtIndex:row][@"id"];
}


#pragma mark - tableView delegate
#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  SelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectTableViewCell" forIndexPath:indexPath];
    cell.titleString = [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row][@"name"]];
  for (NSIndexPath *index in self.tableView.indexPathsForSelectedRows) {
    if (indexPath.row == index.row) {
      [tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
  }
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  SelectTableViewCell *cell = (SelectTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
  [cell setSelected:YES];
  
//  NSLog(@"%@",self.tableView.indexPathsForSelectedRows);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return SCALE_SIZE*55;
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
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCALE_SIZE*44+SCREEN_HEIGHT, SCREEN_WIDTH, SCALE_SIZE*44+height)];
    [_backView setBackgroundColor:[UIColor whiteColor]];
    [self.overlayBtn addSubview:_backView];
  }
  return _backView;
}

-(UIPickerView *)pickerView {
  if (!_pickerView) {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    [_pickerView setBackgroundColor:[UIColor whiteColor]];
    [_pickerView setDelegate:self];
    [_pickerView setDataSource:self];
//    [self.backView addSubview:_pickerView];
  }
  return _pickerView;
}


-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    [_titleLabel setTextColor:BASECOLOR_BLACK_666];
    [_titleLabel setFont:FONTSIZE(14)];
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

-(UITableView *)tableView {
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height) style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView registerClass:[SelectTableViewCell class] forCellReuseIdentifier:@"SelectTableViewCell"];
    _tableView.allowsMultipleSelection = YES;
  }
  return _tableView;
}

-(void)updateConstraints {
  [super updateConstraints];
  
  [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self);
    make.height.mas_equalTo(SCALE_SIZE*44+height+SafeAreaBottomHeight);
    if (self.isPop) {
      make.bottom.equalTo(self.overlayBtn).offset(-NAVIGATIONBAR_HEIGHT);
    } else {
      make.bottom.equalTo(self).offset(SCALE_SIZE*44+height+SafeAreaBottomHeight);
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
