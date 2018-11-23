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

@property (nonatomic, strong) NSArray  *rowArray;
@property (nonatomic, assign) BOOL  isEdit;

@end

@implementation MyOrderListController

- (void)viewDidLoad {
    [super viewDidLoad];

  [self.tableView registerClass:[OrderHeaderCell class] forCellReuseIdentifier:@"OrderHeaderCell"];
  [self.tableView registerClass:[OrderTextCell class] forCellReuseIdentifier:@"OrderTextCell"];
   [self.tableView registerClass:[OrderFooterCell class] forCellReuseIdentifier:@"OrderFooterCell"];
  [self.tableView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  
  self.rowArray = @[@{@"title":@"精品卡盒方案一",@"price":@" ¥ 5.00",@"count":@"1"},@{@"title":@"EPE",@"price":@" ¥ 5.00",@"count":@"1"},@{@"title":@"精A款标签",@"price":@" ¥ 5.00",@"count":@"1"},@{@"title":@"塑料托盘",@"price":@" ¥ 5.00",@"count":@"1"}];
  // 初始化cell的编辑状态
  self.isEdit = NO;
}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OrderHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeaderCell" forIndexPath:indexPath];
    
    return [cell initWithTitle:@"苹果高档礼品包装方案" tag:@"打样订单" isEdit:self.isEdit];
  } else if (indexPath.row == self.rowArray.count + 1) {
    OrderFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderFooterCell" forIndexPath:indexPath];
    return [cell initWithDic:@{}];
  } else {
    OrderTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTextCell" forIndexPath:indexPath];
    return [cell initWithDic:self.rowArray[indexPath.row-1] bottomCorner:NO isEdit:self.isEdit];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.rowArray.count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return SCALE_SIZE*50;
  } else if (indexPath.row == self.rowArray.count + 1) {
    return SCALE_SIZE*94;
  } else {
    return SCALE_SIZE*46;
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
