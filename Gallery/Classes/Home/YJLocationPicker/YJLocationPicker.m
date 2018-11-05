//
//  YJLocationPicker.m
//  PickerDemo
//
//  Created by 安东 on 16/8/22.
//  Copyright © 2016年 sail. All rights reserved.
//

#import "YJLocationPicker.h"
#import "YJToolBar.h"

static CGFloat const PickerViewHeight = 240;
//static CGFloat const PickerViewLabelWeight = 32;

@interface YJLocationPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

//data
@property (strong, nonatomic) NSDictionary *pickerDic;
/** 当前省数组 */
@property (strong, nonatomic) NSArray *provinceArray;
/** 当前城市数组 */
@property (strong, nonatomic) NSArray *cityArray;
/** 当前地区数组 */
@property (strong, nonatomic) NSArray *townArray;
/** 当前选中数组 */
@property (strong, nonatomic) NSArray *selectedArray;

/** 选择器 */
@property (nonatomic, strong, nullable)UIPickerView *pickerView;
/** 工具器 */
@property (nonatomic, strong, nullable)YJToolBar *toolBar;
/** 边线 */
@property (nonatomic, strong, nullable)UIView *lineView;

@property (strong, nonatomic) DataRequest        *dataRequest;

@end

@implementation YJLocationPicker


- (instancetype)initWithSlectedLocation:(SelectedLocation)selectedLocation {
    self = [self init];
    self.selectedLocation = selectedLocation;
    return self;
    
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
        [self loadData];
    }
    return self;
}


- (void)setupUI {
    self.bounds = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
    [self.layer setOpaque:0.0];
    [self addSubview:self.pickerView];
    [self.pickerView addSubview:self.lineView];
    [self addSubview:self.toolbar];
    [self addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData {
  
  // 判断本地如果没有地址信息则从网络获取
//  if ([[UserInfoSingleton shareData] areaInfoArray]) {
//    [self getAreaDataWithArray:[[UserInfoSingleton shareData] areaInfoArray]];
//  } else {
  
    @weakify(self);
//    [self.dataRequest getAreaTree];
    [self.dataRequest setBlockWithReturnBlock:^(id returnValue) {
      @strongify(self);
//      [[UserInfoSingleton shareData] setAreaInfoArray:returnValue];
      [self getAreaDataWithArray:returnValue];
      [self.pickerView reloadAllComponents];
    } WithErrorBlock:^(id errorCode) {
      
    } WithFailureBlock:^{
      
    }];
//  }
}

- (void)getAreaDataWithArray:(NSArray *)array {
  self.provinceArray = array;
  self.selectedArray = self.provinceArray;
  
  if (self.selectedArray.count > 0) {
    self.cityArray = [self.selectedArray[0] children];
  }
  
  if (self.cityArray.count > 0) {
    self.townArray = [self.cityArray[0] children];
  }
}

#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
      return [self.provinceArray[row] name];
    } else if (component == 1) {
      return [self.cityArray[row] name];
    } else {
      return [self.townArray[row] name];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
      self.selectedArray = self.provinceArray;
        if (self.selectedArray.count > 0) {
          self.cityArray = [self.selectedArray[row] children];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
          self.townArray = [self.cityArray[0] children];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {

          self.townArray = [self.cityArray[row] children];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
    
    [self reloadata];

}

// 自定义pcierview显示
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    NSString *text;
    if (component == 0) {
        text =  [self.provinceArray[row] name];
    }else if (component == 1){
        text =  [self.cityArray[row] name];
    }else{
        if (self.townArray.count > 0) {
            text = [self.townArray[row] name];
        }else{
            text =  @"";
        }
    }
    UILabel *label = [[UILabel alloc]init];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setTextColor:BASECOLOR_BLACK];
    [label setText:text];
    return label;
}


- (void)cancelAction {
    [self remove];
}

- (void)confirmAction {
  
  NSString *province = [self.provinceArray[[self.pickerView selectedRowInComponent:0]] name];
  NSString *city = [self.cityArray[[self.pickerView selectedRowInComponent:1]] name];
    NSString *town;
    if (self.townArray.count != 0) {
        
        town = [self.townArray objectAtIndex:[self.pickerView selectedRowInComponent:2]];
        
    } else {
        
        town = @"";
    }
    if(province && city && town){
        self.selectedLocation(@[province, city, town]);
    }
    [self remove];
}

//选择的数组
- (void)reloadata {

  NSString *province = [self.provinceArray[[self.pickerView selectedRowInComponent:0]] name];
  NSString *city = [self.cityArray[[self.pickerView selectedRowInComponent:1]] name];
    NSString *town;
    if (self.townArray.count != 0) {
        
        town = [self.townArray[[self.pickerView selectedRowInComponent:2]] name];
        
    } else {
        
        town = @"";
    }
    self.toolBar.title = [[province stringByAppendingString:[NSString stringWithFormat:@" %@", city]] stringByAppendingString:[NSString stringWithFormat:@" %@", town]];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y -= PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y -= PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:1];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
    }];
}

- (void)remove {
    CGRect frameTool = self.toolbar.frame;
    frameTool.origin.y += PickerViewHeight;
    
    CGRect framePicker =  self.pickerView.frame;
    framePicker.origin.y += PickerViewHeight;
    [UIView animateWithDuration:0.33 animations:^{
        [self.layer setOpacity:0];
        self.toolbar.frame = frameTool;
        self.pickerView.frame = framePicker;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        CGFloat pickerW = [UIScreen mainScreen].bounds.size.width;
        CGFloat pickerH = PickerViewHeight - 44;
        CGFloat pickerX = 0;
        CGFloat pickerY = [UIScreen mainScreen].bounds.size.height + 44;
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(pickerX, pickerY, pickerW, pickerH)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        [_pickerView setDataSource:self];
        [_pickerView setDelegate:self];
    }
    return _pickerView;
}

- (YJToolBar *)toolbar {
    if (!_toolBar) {
        _toolBar = [[YJToolBar alloc]initWithTitle:@"选择城市地区"
                                 cancelButtonTitle:@"取消"
                                     confirmButtonTitle:@"确定"
                                         addTarget:self
                                      cancelAction:@selector(cancelAction)
                                          confirmAction:@selector(confirmAction)];
        _toolBar.x = 0;
        _toolBar.y = [UIScreen mainScreen].bounds.size.height;
    }
    return _toolBar;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        [_lineView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    return _lineView;
}

-(DataRequest *)dataRequest {
  if (!_dataRequest) {
    _dataRequest = [[DataRequest alloc] init];
  }
  return _dataRequest;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
