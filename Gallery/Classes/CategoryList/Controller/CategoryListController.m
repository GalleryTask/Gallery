//
//  CategoryListController.m
//  Gallery
//
//  Created by 安东 on 06/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "CategoryListController.h"
#import "ProductsViewController.h"
#import "CategoryCell.h"

@interface CategoryListController ()

@property (nonatomic, strong) ProductsViewController  *productsVC;
@property (nonatomic, strong) NSArray  *categoryArr;  // 商品列表数据源
@property (nonatomic, strong) UIView  *searchView;

@end

@implementation CategoryListController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.navigationItem.title = @"全部行业";
  [self createInterfaceBuilder];
}

- (void)createInterfaceBuilder {
  [self.view addSubview:self.productsVC.view];
  [self.view addSubview:self.searchView];
  self.categoryArr = @[@"美妆护理",@"数码3C",@"水果农特",@"医药保健",@"服装",@"酒水饮料",@"日化家纺",
                       @"家具",@"家用电器",@"玩具饰品",@"家装五金",@"日化家纺",@"工业防护",@"工业防护",
                       @"鞋袜箱包",@"鞋袜箱包",@"文化体育",@"仓储物流",@"汽车用品"];
  [self.tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
  [self.tableView setRowHeight:SCALE_SIZE*45];
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.searchView.mas_bottom);
    make.width.mas_equalTo(SCREEN_WIDTH*0.24);
    make.height.equalTo(self.view).offset(-40);
  }];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
  [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              animated:NO
                        scrollPosition:UITableViewScrollPositionTop];
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithImageName:@"news" highlightImageName:@""];
  [nav showRightNavBtnWithClick:^(id sender) {
  }];
  
//  UISearchBar *searchBar = [[UISearchBar alloc] init];
  
}

#pragma mark - tableview delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return self.categoryArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  CategoryCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
  [categoryCell setCategoryString:self.categoryArr[indexPath.row]];
  return categoryCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (_productsVC) {
    [_productsVC scrollToSelectedIndexPath:indexPath];
  }
}

#pragma mark - getters
-(ProductsViewController *)productsVC {
  if (!_productsVC) {
    _productsVC = [[ProductsViewController alloc] init];
    [self addChildViewController:_productsVC];
  }
  return _productsVC;
}

-(UIView *)searchView {
  if (!_searchView) {
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [_searchView setBackgroundColor:[UIColor whiteColor]];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, SCREEN_WIDTH, 0.5)];
    [lineView setBackgroundColor:[UIColor hexStringToColor:@"#E6E6E6"]];
    [_searchView addSubview:lineView];
  }
  return _searchView;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
}

@end
