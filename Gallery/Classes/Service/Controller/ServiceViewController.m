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

@interface ServiceViewController ()

@property (nonatomic, strong) UIButton *startBtn;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, copy) NSArray  *titleArr;
@property (nonatomic, strong) UIView  *footerView;

@end

@implementation ServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"至尊服务";
  
  [self.tableView registerClass:[ServiceCell class] forCellReuseIdentifier:@"ServiceCell"];
  [self.tableView setRowHeight:SCALE_SIZE*50];
  self.titleArr = @[@"所需行业",@"内容物",@"期望包装价格"];
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*10)];
  [headerView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self.tableView setTableHeaderView:headerView];
  [self.tableView setTableFooterView:self.footerView];
}



#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceCell" forIndexPath:indexPath];
  [cell setTitleString:self.titleArr[indexPath.row]];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 3;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  
}

-(void)startBtnAction:(UIButton *)sender{
  ServiceDetailController *detailVC = [[ServiceDetailController alloc] init];
  [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.bottom.equalTo(self.view);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
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
    
    [self.view layoutIfNeeded];
    [_footerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*500)];
    
  }
  
  return _footerView;
}
@end

