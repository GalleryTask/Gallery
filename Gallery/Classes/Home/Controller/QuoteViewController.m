//
//  QuoteViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "QuoteViewController.h"
#import "QuoteSectionView.h"
#import "QuoteCell.h"
#import "PickerView.h"

@interface QuoteViewController () <PickerViewDelegate>

@property (nonatomic, copy) NSString  *titleString;
@property (nonatomic, copy) NSString  *boxId;
@property (nonatomic, strong) QuoteSectionView  *sectionView;

@property (nonatomic, strong) NSMutableArray  *dataArray;
@property (nonatomic, strong) PickerView  *pickerView;
@property (nonatomic, strong) NSIndexPath  *didSelectedIndexPath;
@property (nonatomic, copy) NSString  *amountStr;
@property (nonatomic, copy) NSString  *amountId;  // 年度用量
@property (nonatomic, copy) NSString  *directionId; // 开口方向
@property (nonatomic, copy) NSString  *caliberId; // 口径
@property (nonatomic, copy) NSString  *printingMethodId; // 印刷方式
@property (nonatomic, copy) NSString  *printingColorId; // 印刷颜色
@property (nonatomic, copy) NSString  *printingAreaId; // 印刷面积
@property (nonatomic, copy) NSString  *wavyStripId; // 波浪胶条
@property (nonatomic, strong) UIView  *footerView;

@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.title = [NSString stringWithFormat:@"%@报价",self.titleString] ;
  
  [self.tableView registerClass:[QuoteCell class] forCellReuseIdentifier:@"quoteCell"];
  [self.tableView setSectionHeaderHeight:44];
  [self.tableView setTableFooterView:self.footerView];
}



#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.dataArray.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  self.sectionView = [[QuoteSectionView alloc] init];
  [self.sectionView setTitleStr:self.dataArray[section][@"group"]];
  return self.sectionView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.dataArray[section][@"rowArray"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  QuoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quoteCell" forIndexPath:indexPath];
  [cell setTitleString:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"title"]];
  [cell setDetailString:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"content"]];
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  

  self.didSelectedIndexPath = indexPath;
  if (indexPath.section == 1) {
    if (indexPath.row == 7) {
      // 弹出工艺
      [self.pickerView pickerViewWithDelegate:self dataSource:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"list"] title:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"title"]];
      return;
    } else if (indexPath.row != 8 && indexPath.row != 9 && indexPath.row != 10) {
      // 当不是长度，宽度，和高度时弹出pickerView
      [self.pickerView pickerViewWithDelegate:self
                                   dataSource:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"list"]
                                        title:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"title"]
                                  selectedRow:[self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"selectedRow"] integerValue]];
    } else {
      [self pushAlertViewWithIndexPath:indexPath];
    }

  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (([self.titleString isEqualToString:@"平口箱"] || [self.titleString isEqualToString:@"自锁底平口箱"] || [self.titleString isEqualToString:@"飞机盒"])
      && indexPath.section == 1 && indexPath.row == 6) {
    // 不是拉链箱隐藏波浪胶条
    return 0;
  }
  if (![self.dataArray[1][@"rowArray"][3][@"content"]isEqualToString:@"胶印"]
      && indexPath.section == 1 && indexPath.row == 7) {
    // 如果印刷方式为不为胶印隐藏工艺
    return 0;
  }
  return 60;
}

#pragma marks - pickerView delegate
-(void)pickerViewWithSelectedRow:(NSInteger)row selectedTitle:(NSString *)title selectedId:(nonnull NSString *)selectedId {

  if (self.didSelectedIndexPath.section == 1) {
    [self dataReplaceObjectWithRow:row indexPath:self.didSelectedIndexPath content:title];
    switch (self.didSelectedIndexPath.row) {
      case 0:
        self.amountId = selectedId;
        break;
      case 1:
        self.directionId = selectedId;
        break;
      case 2:
        self.caliberId = selectedId;
        break;
      case 3:
        self.printingMethodId = selectedId;
        break;
      case 4:
        self.printingColorId = selectedId;
        break;
      case 5:
        self.printingAreaId = selectedId;
        break;
      case 6:
        self.wavyStripId = selectedId;
        break;
        
      default:
        break;
    }
  }
  [self.tableView reloadData];
}


/**
 将缓存数据中数据进行修改

 @param row 当前pickerView选择的row
 @param indexPath 当前点击的indexPath
 @param content 提示内容
 */
- (void)dataReplaceObjectWithRow:(NSInteger)row indexPath:(NSIndexPath *)indexPath content:(NSString *)content {
  NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:self.dataArray[indexPath.section]];
  NSMutableArray *array =[NSMutableArray arrayWithArray:dic[@"rowArray"]] ;
  NSDictionary *item = [array objectAtIndex:indexPath.row];
  NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
  [mutableItem setObject:content forKey:@"content"];
  [mutableItem setObject:[NSNumber numberWithInteger:row] forKey:@"selectedRow"];
  [array setObject:mutableItem atIndexedSubscript:indexPath.row];
  [dic setValue:array forKey:@"rowArray"];
  [self.dataArray replaceObjectAtIndex:indexPath.section withObject:dic];
}


- (void)pushAlertViewWithIndexPath:(NSIndexPath *)indexPath {
  
  NSString *title;
  switch (indexPath.row) {
    case 8:
      title = @"长度";
      break;
    case 9:
      title = @"宽度";
      break;
    case 10:
      title = @"高度";
      break;
      
    default:
      break;
  }
  
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
  //增加取消按钮；
  [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
  //定义第一个输入框；
  [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.placeholder = [NSString stringWithFormat:@"输入%@(mm)",title];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    //    [textField setText:weakSelf.products.productCount];
  }];
  //增加确定按钮；
  [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //获取第1个输入框；
    UITextField *textField = alertController.textFields.firstObject;
    [self dataReplaceObjectWithRow:0 indexPath:indexPath content:textField.text];
    [self.tableView reloadData];
  }]];
  [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark - 报价点击
- (void)quoteBtnClick:(id)sender {
  
}

#pragma mark - getters
-(NSArray *)dataArray {
  if (!_dataArray) {
    _dataArray = [NSMutableArray arrayWithArray:[self readLocalFileWithName:@"quote"][@"list"]];
  }
  return _dataArray;
}

-(PickerView *)pickerView {
  if (!_pickerView) {
    _pickerView = [[PickerView alloc] init];
  }
  return _pickerView;
}

-(UIView *)footerView {
  if (!_footerView) {
    _footerView = [[UIView alloc] init];
    [_footerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*100)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:BASECOLOR_BLUE forState:UIControlStateNormal];
    [button setBackgroundImage:[CommonUtil imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[CommonUtil imageWithColor:BASECOLOR_BACKGROUND_GRAY] forState:UIControlStateHighlighted];
    [button setTitle:@"开始报价" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCALE_SIZE*50)];
    [button addTarget:self action:@selector(quoteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:SCALE_SIZE*18]];
    [_footerView addSubview:button];
  }
  return _footerView;
}

// 读取本地JSON文件
- (NSDictionary *)readLocalFileWithName:(NSString *)name {
  // 获取文件路径
  NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
  // 将文件数据化
  NSData *data = [[NSData alloc] initWithContentsOfFile:path];
  // 对数据进行JSON格式化并返回字典形式
  return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
