//
//  OrderSubmitController.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderSubmitController.h"
#import "SchemeCell.h"
#import "PreviewCell.h"
#import "DeliveryDateCell.h"
#import "SelectCountCell.h"
#import "BottomSelectBar.h"

@interface OrderSubmitController () <BottomSelectBarDelegate>

@property (nonatomic, strong) BottomSelectBar  *bottomBar;
@property (nonatomic, strong) UIView  *headerView;

@end

@implementation OrderSubmitController

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationItem.title = @"订单详情";
  
  [self.tableView registerClass:[SchemeCell class] forCellReuseIdentifier:@"SchemeCell"];
  [self.tableView registerClass:[PreviewCell class] forCellReuseIdentifier:@"PreviewCell"];
  [self.tableView registerClass:[DeliveryDateCell class] forCellReuseIdentifier:@"DeliveryDateCell"];
  [self.tableView registerClass:[SelectCountCell class] forCellReuseIdentifier:@"SelectCountCell"];
  self.dataSource = [NSMutableArray arrayWithObjects:
                     @{@"title":@"EPE",@"detail":@"结构一 / 规格18g/L",@"count":@"x 1个"},
                     @{@"title":@"标签",@"detail":@"A款标签/铜版纸",@"count":@"x 1个"},
                     @{@"title":@"托盘",@"detail":@"塑料托盘",@"count":@"x 1个"},
                     @{@"title":@"平面设计",@"detail":@"主位设计图,副位设计图",@"count":@""},
                     @{@"title":@"印刷工艺",@"detail":@"胶印亚膜",@"count":@""}, nil];
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SCALE_SIZE*50, 0);
  
  [self.tableView setTableHeaderView:self.headerView];
}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    
    SchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemeCell" forIndexPath:indexPath];
    return cell;
  } else if (indexPath.row == 6) {
    DeliveryDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeliveryDateCell" forIndexPath:indexPath];
    return cell;
  }
  
  PreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreviewCell" forIndexPath:indexPath];
  [cell setDic:self.dataSource[indexPath.row-1]];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return SCALE_SIZE*186;
  } else if (indexPath.row == 6) {
    return SCALE_SIZE*52;
  }
  else {
    return SCALE_SIZE*57;
  }
}

#pragma marks - BottomSelectBar delegate
-(void)bottomBarWithLeftBtnClick:(id)sender {
  
}

-(void)bottomBarWithRightBtnClick:(id)sender {
  
}

-(BottomSelectBar *)bottomBar {
  if (!_bottomBar) {
    _bottomBar = [[BottomSelectBar alloc] initWithLeftTitle:@"总金额：￥30.00" rightTitle:@"付款" delegate:self];
    [self.tableView addSubview:_bottomBar];
  }
  return _bottomBar;
}

-(UIView *)headerView {
  if (!_headerView) {
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*102)];
    [_headerView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
    
  }
  return _headerView;
}


-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}
@end
