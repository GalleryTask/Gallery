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

@end

@implementation QuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  self.title = [NSString stringWithFormat:@"%@报价",self.titleString] ;
  
  [self.tableView registerClass:[QuoteCell class] forCellReuseIdentifier:@"quoteCell"];
  [self.tableView setSectionHeaderHeight:44];
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

    [self.pickerView pickerViewWithDelegate:self
                                 dataSource:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"list"]
                                      title:self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"title"]
                                selectedRow:[self.dataArray[indexPath.section][@"rowArray"][indexPath.row][@"selectedRow"] integerValue]];
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (([self.titleString isEqualToString:@"平口箱"] || [self.titleString isEqualToString:@"自锁底平口箱"] || [self.titleString isEqualToString:@"飞机盒"])
      && indexPath.section == 1 && indexPath.row == 6) {
    // 不是拉链箱隐藏波浪胶条
    return 0;
  }
  // 如果印刷方式为不为胶印隐藏工艺
  if (![self.dataArray[1][@"rowArray"][3][@"content"]isEqualToString:@"胶印"]
      && indexPath.section == 1 && indexPath.row == 7) {
    return 0;
  }
  return 60;
}

#pragma marks - pickerView delegate
-(void)pickerViewWithSelectedRow:(NSInteger)row selectedTitle:(NSString *)title selectedId:(nonnull NSString *)selectedId {

  if (self.didSelectedIndexPath.section == 1) {
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary:self.dataArray[self.didSelectedIndexPath.section]];
    NSMutableArray *array =[NSMutableArray arrayWithArray:dic[@"rowArray"]] ;
    NSDictionary *item = [array objectAtIndex:self.didSelectedIndexPath.row];
    NSMutableDictionary *mutableItem = [NSMutableDictionary dictionaryWithDictionary:item];
    [mutableItem setObject:title forKey:@"content"];
    [mutableItem setObject:[NSNumber numberWithInteger:row] forKey:@"selectedRow"];
    [array setObject:mutableItem atIndexedSubscript:self.didSelectedIndexPath.row];
    [dic setValue:array forKey:@"rowArray"];
    [self.dataArray replaceObjectAtIndex:self.didSelectedIndexPath.section withObject:dic];

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
