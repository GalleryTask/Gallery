//
//  QuoteViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "QuoteViewController.h"
#import "MateriaIInformationViewController.h"
#import "QuoteSectionView.h"
#import "QuoteCell.h"
#import "PickerView.h"

@interface QuoteViewController () <PickerViewDelegate>

@property (nonatomic, copy) NSString  *titleString;
@property (nonatomic, copy) NSString  *boxId;
@property (nonatomic, strong) QuoteSectionView  *sectionView;
@property (nonatomic, strong) NSArray  *sectionArray;
@property (nonatomic, strong) NSDictionary  *pickerList;
@property (nonatomic, strong) PickerView  *pickerView;
@property (nonatomic, strong) NSIndexPath  *didSelectedIndexPath;
@property (nonatomic, copy) NSString  *amountStr;    // 年度用量
@property (nonatomic, copy) NSString  *amountId;
@property (nonatomic, copy) NSString  *directionStr; // 开口方向
@property (nonatomic, copy) NSString  *directionId;
@property (nonatomic, copy) NSString  *caliberStr;   // 口径
@property (nonatomic, copy) NSString  *caliberId;
@property (nonatomic, copy) NSString  *printingMethodStr; // 印刷方式
@property (nonatomic, copy) NSString  *printingMethodId;
@property (nonatomic, copy) NSString  *printingColorStr; // 印刷颜色
@property (nonatomic, copy) NSString  *printingColorId;
@property (nonatomic, copy) NSString  *printingAreaStr; // 印刷面积
@property (nonatomic, copy) NSString  *printingAreaId;
@property (nonatomic, copy) NSString  *wavyStripStr; // 波浪胶条
@property (nonatomic, copy) NSString  *wavyStripId;

@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.title = [NSString stringWithFormat:@"%@报价",self.titleString] ;
  
  [self.tableView registerClass:[QuoteCell class] forCellReuseIdentifier:@"quoteCell"];
  [self.tableView setSectionHeaderHeight:44];
  [self initInfo];
}



#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.sectionArray.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  self.sectionView = [[QuoteSectionView alloc] init];
  [self.sectionView setTitleStr:self.sectionArray[section][@"sectionTitle"]];
  return self.sectionView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.sectionArray[section][@"rowArray"] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  QuoteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quoteCell" forIndexPath:indexPath];
  [cell setTitleString:self.sectionArray[indexPath.section][@"rowArray"][indexPath.row]];
  if (indexPath.section == 1) {
    switch (indexPath.row) {
      case 0:
        [cell setDetailString:self.amountStr];
        break;
      case 1:
        [cell setDetailString:self.directionStr];
        break;
      case 2:
        [cell setDetailString:self.caliberStr];
        break;
      case 3:
        [cell setDetailString:self.printingMethodStr];
        break;
      case 4:
        [cell setDetailString:self.printingColorStr];
        break;
      case 5:
        [cell setDetailString:self.printingAreaStr];
        break;
      case 6:
        [cell setDetailString:self.wavyStripStr];
        break;
        
      default:
        break;
    }
  }
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  self.didSelectedIndexPath = indexPath;
  if (indexPath.section == 1) {
    switch (indexPath.row) {
      case 0:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"年度用量"] title:@"年度用量"];
        break;
      case 1:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"开口方向"] title:@"开口方向"];
        break;
      case 2:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"口径"] title:@"口径"];
        break;
      case 3:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"印刷方式"] title:@"印刷方式"];
        break;
      case 4:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"印刷颜色"] title:@"印刷颜色"];
        break;
      case 5:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"印刷面积"] title:@"印刷面积"];
        break;
      case 6:
        [self.pickerView pickerViewWithDelegate:self dataSource:self.pickerList[@"波浪胶条"] title:@"波浪胶条"];
        break;
        
      default:
        break;
    }
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (([self.titleString isEqualToString:@"平口箱"] || [self.titleString isEqualToString:@"自锁底平口箱"]
      || [self.titleString isEqualToString:@"飞机盒"]) && indexPath.section == 1 && indexPath.row == 6) {
    // 不是拉链箱隐藏波浪胶条
    return 0;
  }
  // 如果印刷方式为不为胶印隐藏工艺
  if (![self.printingMethodStr isEqualToString:@"胶印"] && indexPath.section == 1 && indexPath.row == 7) {
    return 0;
  }
  return 60;
}

#pragma marks - pickerView delegate
-(void)pickerViewWithSelectedRow:(NSInteger)row selectedTitle:(NSString *)title selectedId:(nonnull NSString *)selectedId {

  if (self.didSelectedIndexPath.section == 1) {
    switch (self.didSelectedIndexPath.row) {
      case 0:
        self.amountStr = title;
        self.amountId = selectedId;
        break;
      case 1:
        self.directionStr = title;
        self.directionId = selectedId;
        break;
      case 2:
        self.caliberStr = title;
        self.caliberId = selectedId;
        break;
      case 3:
        self.printingMethodStr = title;
        self.printingMethodId = selectedId;
        break;
      case 4:
        self.printingColorStr = title;
        self.printingColorId = selectedId;
        break;
      case 5:
        self.printingAreaStr = title;
        self.printingAreaId = selectedId;
        break;
      case 6:
        self.wavyStripStr = title;
        self.wavyStripId = selectedId;
        break;
        
      default:
        break;
    }
  }
  [self.tableView reloadData];
}

#pragma mark - getters
-(NSArray *)sectionArray {
  if (!_sectionArray) {
    _sectionArray = [[[NSDictionary alloc] initWithContentsOfFile:
                 [[NSBundle mainBundle] pathForResource:@"DataList.plist"ofType:nil]]
                objectForKey:@"QuoteList"] ;
  }
  return _sectionArray;
}

-(NSDictionary *)pickerList {
  if (!_pickerList) {
    _pickerList = [[[NSDictionary alloc] initWithContentsOfFile:
                    [[NSBundle mainBundle] pathForResource:@"DataList.plist"ofType:nil]]
                   objectForKey:@"PickerViewList"];
  }
  return _pickerList;
}

-(PickerView *)pickerView {
  if (!_pickerView) {
    _pickerView = [[PickerView alloc] init];
  }
  return _pickerView;
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


- (void)initInfo {
  self.amountStr = @"请选择年度用量";
  self.directionStr = @"请选择开口方向";
  self.caliberStr = @"请选择口径";
  self.printingMethodStr = @"请选择方式";
  self.printingColorStr = @"请选择颜色";
  self.printingAreaStr = @"请选择面积";
  self.wavyStripStr = @"请选择波浪胶条";
}
@end
