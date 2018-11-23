//
//  MyOrderListController.m
//  Gallery
//
//  Created by 安东 on 22/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "MyOrderListController.h"
#import "OrderHeaderCell.h"
#import "OrderTextCell.h"
#import "OrderFooterCell.h"

@interface MyOrderListController ()

@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation MyOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self registerTableView];
}

- (void)registerTableView {
  
  [self.tableView registerClass:[OrderHeaderCell class] forCellReuseIdentifier:@"OrderHeaderCell"];
  [self.tableView registerClass:[OrderTextCell class] forCellReuseIdentifier:@"OrderTextCell"];
  [self.tableView registerClass:[OrderFooterCell class] forCellReuseIdentifier:@"OrderFooterCell"];
  [self.tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  
  // 初始化cell的编辑状态
  self.isEdit = NO;
  
  PlaceOrderArr *arr = [[PlaceOrderArr alloc]init];
  arr.title = @"精品卡盒方案一";
  arr.price = @"¥ 5.00";
  arr.count = @"1";
  
  PlaceOrderArr *arr1 = [[PlaceOrderArr alloc]init];
  arr1.title = @"EPE";
  arr1.price = @"¥ 5.00";
  arr1.count = @"1";
  
  PlaceOrderArr *arr2 = [[PlaceOrderArr alloc]init];
  arr2.title = @"A款标签";
  arr2.price = @"¥ 5.00";
  arr2.count = @"1";
  
  PlaceOrderArr *arr3 = [[PlaceOrderArr alloc]init];
  arr3.title = @"塑料托盘";
  arr3.price = @"¥ 8.00";
  arr3.count = @"1";
  
  NSArray *array = @[arr,arr1,arr2,arr3];
  PlaceOrderResult *result = [[PlaceOrderResult alloc] init];
  result.title = @"苹果高档礼盒包装方案";
  result.list = (NSArray <PlaceOrderArr> *)array;
  result.isSelected = NO;
  
  PlaceOrderResult *result1 = [[PlaceOrderResult alloc] init];
  result1.title = @"苹果高档礼盒包装方案";
  result1.list = (NSArray <PlaceOrderArr> *)array;
  result1.isSelected = NO;
  
  PlaceOrderResult *result2 = [[PlaceOrderResult alloc] init];
  result2.title = @"至尊定制方案";
  result2.list = (NSArray <PlaceOrderArr> *)array;
  result2.isSelected = NO;
  
  
  [self.dataSource addObject:result];
  [self.dataSource addObject:result1];
  [self.dataSource addObject:result2];
}
#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OrderHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeaderCell" forIndexPath:indexPath];
    
    return [cell initWithData:self.dataSource[indexPath.section] isEdit:self.isEdit];
  } else if (indexPath.row == [self.dataSource[indexPath.section] list].count + 1) {
    OrderFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderFooterCell" forIndexPath:indexPath];
    return [cell initWithDic:@{}];
  } else {
    OrderTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTextCell" forIndexPath:indexPath];
    return [cell initWithData:[self.dataSource[indexPath.section] list][indexPath.row-1] bottomCorner:NO isEdit:self.isEdit];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return [self.dataSource[section] list].count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return SCALE_SIZE*50;
  } else if (indexPath.row == [self.dataSource[indexPath.section] list].count + 1) {
    return SCALE_SIZE*94;
  } else {
    return SCALE_SIZE*46;
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
