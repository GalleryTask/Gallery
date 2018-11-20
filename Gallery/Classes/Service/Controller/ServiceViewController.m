//
//  ServiceViewController.m
//  Gallery
//
//  Created by 安东 on 2018/9/19.
//  Copyright © 2018年 安东. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceDetailController.h"
#import "ServiceCell.h"
#import "PackagingCustomView.h"
#import "PickerView.h"

@interface ServiceViewController () <PickerViewDelegate>

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, copy)   NSArray  *titleArr;
@property (nonatomic, strong) UIView  *footerView;
@property (nonatomic, strong) PickerView  *pickerView;
@property (nonatomic, copy)  NSString *oneStr;
@property (nonatomic, copy)  NSString *twoStr;
@property (nonatomic, copy)  NSString *threeStr;
@property (nonatomic, strong) NSIndexPath  *indexPath;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"至尊服务";
  
  [self.tableView registerClass:[ServiceCell class] forCellReuseIdentifier:@"ServiceCell"];
  [self.tableView setRowHeight:SCALE_SIZE*50];
  self.titleArr = @[@"所需行业",@"内容物",@"期望包装价格"];
  self.dataSource = [NSMutableArray arrayWithObjects:@[@{@"name":@"美妆护理",@"id":@""},@{@"name":@"数码3C",@"id":@""},@{@"name":@"水果农特",@"id":@""},@{@"name":@"医药保健",@"id":@""},@{@"name":@"服装",@"id":@""},@{@"name":@"酒水饮料",@"id":@""},@{@"name":@"日化家纺",@"id":@""}
                                                      ],@[@{@"name":@"褚橙",@"id":@""},@{@"name":@"苹果",@"id":@""},@{@"name":@"水蜜桃",@"id":@""},@{@"name":@"猕猴桃",@"id":@""},@{@"name":@"柑橘",@"id":@""},@{@"name":@"香蕉",@"id":@""}],@[@{@"name":@"2~5元",@"id":@""},@{@"name":@"5~8元",@"id":@""},], nil];
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*10)];
  [headerView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self.tableView setTableHeaderView:headerView];
  [self.tableView setTableFooterView:self.footerView];
  
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav showLeftNavBtnWithClick:nil];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  
//  [nav setNavigationBarRightItemWithImageName:@"news" highlightImageName:@"news"];

}

#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell" forIndexPath:indexPath];
  [cell setTitleString:self.titleArr[indexPath.row]];
  switch (indexPath.row) {
    case 0:
      [cell setDetailString:self.oneStr];
      break;
    case 1:
      [cell setDetailString:self.twoStr];
      break;
    case 2:
      [cell setDetailString:self.threeStr];
      break;
      
    default:
      break;
  }
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 3;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  _indexPath = indexPath;
  [self.pickerView pickerViewWithDelegate:self dataSource:self.dataSource[indexPath.row] title:self.titleArr[indexPath.row] selectedRow:0];
  
}

-(void)startBtnAction:(UIButton *)sender {
  ServiceDetailController *detailVC = [[ServiceDetailController alloc] init];
  [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}

-(void)pickerViewWithSelectedRow:(NSInteger)row selectedTitle:(NSString *)title selectedId:(NSString *)selectedId {
  switch (_indexPath.row) {
    case 0:
      self.oneStr = title;
      break;
    case 1:
      self.twoStr = title;
      break;
    case 2:
      self.threeStr = title;
      break;
      
    default:
      break;
  }
  [self.tableView reloadData];
}

#pragma marks - getters
-(UIButton *)startBtn {
  if (!_startBtn) {
    _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_startBtn setFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight- 50 -NAVIGATIONBAR_HEIGHT-49, SCREEN_WIDTH, 50)];
    [_startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_startBtn setTitle:@"开始定制" forState:UIControlStateNormal];
    [[_startBtn titleLabel] setFont:FONTSIZE(16)];
    [_startBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [_startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];
  }
  return _startBtn;
}


#pragma marks - getters
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:self.view.frame];
    [self.view addSubview:_scrollView];
    
  }
  return _scrollView;
}

-(UIView *)footerView {
  if (!_footerView) {
    _footerView = [[UIView alloc] init];
    
    UIView *spitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*10)];
    [spitView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
    [_footerView addSubview:spitView];
    
    PackagingCustomView *customOne = [[PackagingCustomView alloc] init];
    NSInteger countRow = [customOne packagingCustomWithTitle:@"内容物规格"
                                                  itemsArray:@[@"5斤装",@"10斤装",@"20斤装"]
                                                selectedItem:0
                                           selectedItemBlock:^(id  _Nonnull sender) {
                                             
                                           }];
    [_footerView addSubview:customOne];
    
    
    
    PackagingCustomView *customTwo = [[PackagingCustomView alloc] init];
    NSInteger countRowTwo = [customTwo packagingCustomWithTitle:@"包装使用方向"
                                                     itemsArray:@[@"物流周转包装",@"产品售卖包装",@"礼品包装",@"快递包装"]
                                                   selectedItem:0
                                              selectedItemBlock:^(id  _Nonnull sender) {
                                                
                                              }];
    [_footerView addSubview:customTwo];
    
    
    
    PackagingCustomView *customThree = [[PackagingCustomView alloc] init];
    NSInteger countRowThree = [customThree packagingCustomWithTitle:@"是否需要标签"
                                                         itemsArray:@[@"是",@"否"]
                                                       selectedItem:0
                                                  selectedItemBlock:^(id  _Nonnull sender) {
                                                    
                                                    
                                                  }];
    [_footerView addSubview:customThree];
    
    PackagingCustomView *customFour = [[PackagingCustomView alloc] init];
    NSInteger countFour = [customFour packagingCustomWithTitle:@"是否需要托盘"
                                                     itemsArray:@[@"是",@"否"]
                                                   selectedItem:0
                                              selectedItemBlock:^(id  _Nonnull sender) {
                                                
                                              }];
    [_footerView addSubview:customFour];
    
    [customOne mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(spitView.mas_bottom);
      make.left.width.equalTo(_footerView);
      make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRow);
    }];
    
    [customTwo mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.width.equalTo(_footerView);
      make.top.equalTo(customOne.mas_bottom);
      make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRowTwo);
    }];
    
    [customThree mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.width.equalTo(_footerView);
      make.top.equalTo(customTwo.mas_bottom);
      make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countRowThree);
    }];
    
    [customFour mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.width.equalTo(_footerView);
      make.top.equalTo(customThree.mas_bottom);
      make.height.mas_equalTo(SCALE_SIZE*94+(SCALE_SIZE*44)*countFour);
    }];
    
//    [self.view layoutIfNeeded];
    [_footerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*500)];
    
  }
  
  return _footerView;
}

-(PickerView *)pickerView {
  if (!_pickerView) {
    _pickerView = [[PickerView alloc] init];
  }
  return _pickerView;
}
@end

