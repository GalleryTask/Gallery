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

@interface OrderViewController ()

@property (nonatomic, strong) NSArray  *rowArray;
@property (nonatomic, assign) BOOL  isEdit;
@property (nonatomic, strong) UIView  *bottomView;
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
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row == 0) {
    
    OrderHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHeaderCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
      return [cell initWithTitle:@"苹果高档礼品包装方案" tag:@"" isEdit:self.isEdit];
    }
    return [cell initWithTitle:@"苹果高档礼品包装方案" tag:@"打样订单" isEdit:self.isEdit];
  } else {
    OrderTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTextCell" forIndexPath:indexPath];
    if (indexPath.row == self.rowArray.count) {
      
      return [cell initWithDic:self.rowArray[indexPath.row-1] bottomCorner:YES isEdit:self.isEdit];
    } else {
      return [cell initWithDic:self.rowArray[indexPath.row-1] bottomCorner:NO isEdit:self.isEdit];
    }
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.rowArray.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
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
  [self.tableView registerClass:[OrderHeaderCell class] forCellReuseIdentifier:@"OrderHeaderCell"];
  [self.tableView registerClass:[OrderTextCell class] forCellReuseIdentifier:@"OrderTextCell"];
  [self.tableView setBackgroundColor:[UIColor clearColor]];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, SCALE_SIZE*56, 0)];
  
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(SCALE_SIZE*30);
    make.height.equalTo(self.view).offset(-SCALE_SIZE*30);
    make.width.left.equalTo(self.view);
  }];
  
  self.rowArray = @[@{@"title":@"精品卡盒方案一",@"price":@" ¥ 5.00",@"count":@"1"},@{@"title":@"EPE",@"price":@" ¥ 5.00",@"count":@"1"},@{@"title":@"精A款标签",@"price":@" ¥ 5.00",@"count":@"1"},@{@"title":@"塑料托盘",@"price":@" ¥ 5.00",@"count":@"1"}];
  // 初始化cell的编辑状态
  self.isEdit = YES;
}

-(UIView *)bottomView {
  if (!_bottomView) {
    _bottomView = [[UIView alloc] init];
    [_bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:_bottomView];
    
    UIView *lineView = [[UIView alloc] init];
    [lineView setBackgroundColor:BASECOLOR_LINE];
    [_bottomView addSubview:lineView];
    
    UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectedBtn setImage:[UIImage imageNamed:@"btn_default"] forState:UIControlStateNormal];
    [selectedBtn setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    [_bottomView addSubview:selectedBtn];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.top.width.equalTo(_bottomView);
      make.height.mas_equalTo(0.5);
    }];
    
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(SCALE_SIZE*12);
      make.centerY.equalTo(_bottomView);
      make.width.height.mas_equalTo(SCALE_SIZE*30);
    }];
    
  }
  return _bottomView;
}

-(SettleView *)settleView {
  if (!_settleView) {
    _settleView = [[SettleView alloc] init];
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
