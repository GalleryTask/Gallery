//
//  OrderViewController.m
//  Gallery
//
//  Created by 安东 on 15/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderHeaderCell.h"
#import "OrderTextCell.h"
#import "SettleView.h"

@interface OrderViewController () <SettleViewDelegate, OrderHeaderCellDelegate>

@property (nonatomic, assign) BOOL  isEdit;
@property (nonatomic, assign) BOOL  isSelected;  // 订货单是否全选 默认为NO 
@property (nonatomic, strong) SettleView  *settleView; // 底部结算

@end

@implementation OrderViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.view setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self createNavigationbar];
  [self registerTableView];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.barTintColor = BASECOLOR_BLACK_333;
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OrderHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeaderCell" forIndexPath:indexPath];
    [cell setDelegate:self];
    [cell setIndexPath:indexPath];
    return [cell initWithData:self.dataSource[indexPath.section] isEdit:self.isEdit];
  } else {
    OrderTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTextCell" forIndexPath:indexPath];
    if (indexPath.row == [self.dataSource[indexPath.section] list].count) {
      
      return [cell initWithData:[self.dataSource[indexPath.section] list][indexPath.row-1] bottomCorner:YES isEdit:self.isEdit];
    } else {
      return [cell initWithData:[self.dataSource[indexPath.section] list][indexPath.row-1] bottomCorner:NO isEdit:self.isEdit];
    }
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return [self.dataSource[section] list].count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return SCALE_SIZE*50;
  } else {
    return SCALE_SIZE*46;
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

#pragma mark - 右侧item点击事件
- (void)rightNavigationBtnClick:(id)sender {
  
}

#pragma mark - settleView delegate
-(void)settleViewAllSelectedBtnClickWithSelected:(BOOL)selected {
  int i = 0;
  for (PlaceOrderResult *data in self.dataSource) {
    data.isSelected = selected;
    if (data.isSelected) {
      i++;
    }
  }
  [self.settleView settleViewWithSettleCount:i];
  [self.tableView reloadData];
}

#pragma mark - OrderHeaderCell delegate
-(void)orderHeaderCellWithSelected:(BOOL)selected index:(NSInteger)index {
  PlaceOrderResult *data = self.dataSource[index];
  data.isSelected = selected;
  
  int i = 0;
  for (PlaceOrderResult *data in self.dataSource) {
    if (data.isSelected) {
      i++;
    }
  }
  [self.settleView settleViewWithSettleCount:i];
  [self.tableView reloadData];
}

#pragma marks - 创建navigationbar
- (void)createNavigationbar {

  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
  [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
  [button addTarget:self
             action:@selector(rightNavigationBtnClick:)
   forControlEvents:UIControlEventTouchUpInside];
  [button setTitleColor:BASECOLOR_BLACK_333 forState:UIControlStateNormal];
  [[button titleLabel] setFont:FONTSIZE(14)];
  [button setTitle:@"管理" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  
  UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
  self.navigationItem.rightBarButtonItem = rightBtnItem;
  
  UILabel *titleLabel = [[UILabel alloc] init];
  [titleLabel setFrame:CGRectMake(0, 0, BASE_HEIGHT*2, BASE_HEIGHT)];
  [titleLabel setText:@"订货单"];
  [titleLabel setTextColor:[UIColor whiteColor]];
  [titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*18 weight:UIFontWeightBold]];
  
  UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
  
  self.navigationItem.leftBarButtonItem = leftBtnItem;

  
  UIView *backView = [[UIView alloc] init];
  [backView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*134)];
  [backView setBackgroundColor:BASECOLOR_BLACK_333];
  [self.view addSubview:backView];
  
  UILabel *textLabel = [[UILabel alloc] init];
  [textLabel setTextColor:[UIColor whiteColor]];
  [textLabel setFont:FONTSIZE(13)];
  [textLabel setText:@"共2件商品"];
  [backView addSubview:textLabel];
  
  [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view).offset(SCALE_SIZE*15);
    make.top.equalTo(self.view);
  }];
}

- (void)registerTableView {

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
  result.tag = @"0";
  
  PlaceOrderResult *result1 = [[PlaceOrderResult alloc] init];
  result1.title = @"苹果高档礼盒包装方案";
  result1.list = (NSArray <PlaceOrderArr> *)array;
  result1.isSelected = NO;
  result1.tag = @"1";
  
  PlaceOrderResult *result2 = [[PlaceOrderResult alloc] init];
  result2.title = @"至尊定制方案";
  result2.list = (NSArray <PlaceOrderArr> *)array;
  result2.isSelected = NO;
  result2.tag = @"2";
  
  [self.dataSource addObject:result];
  [self.dataSource addObject:result1];
  [self.dataSource addObject:result2];
  
  
  [self.tableView registerClass:[OrderHeaderCell class] forCellReuseIdentifier:@"OrderHeaderCell"];
  [self.tableView registerClass:[OrderTextCell class] forCellReuseIdentifier:@"OrderTextCell"];
  [self.tableView setBackgroundColor:[UIColor clearColor]];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, SCALE_SIZE*56, 0)];
  
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(SCALE_SIZE*30);
    make.height.equalTo(self.view).offset(-SCALE_SIZE*30);
    make.width.left.equalTo(self.view);
  }];
  

  // 初始化cell的编辑状态
  self.isEdit = YES;
}

-(SettleView *)settleView {
  if (!_settleView) {
    _settleView = [[SettleView alloc] init];
    [_settleView setDelegate:self];
    [self.tableView addSubview:_settleView];
  }
  return _settleView;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.settleView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.bottom.width.equalTo(self.view);
    make.height.mas_equalTo(SCALE_SIZE*56);
  }];
}
@end
