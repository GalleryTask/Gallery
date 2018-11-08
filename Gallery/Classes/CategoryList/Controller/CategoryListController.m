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

@end

@implementation CategoryListController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.view addSubview:self.productsVC.view];
  self.categoryArr = @[@"AF",@"是鬼地方",@"打断点",@"订单",@"从长春",@"吧v",@"撒气无",@"阿尔额",@"Dev",@"未付",@"未付",@"阿发电房",@"的法尔",@"恶女",@"嗯嗯嗯",@"22分"];
  [self.tableView registerClass:[CategoryCell class] forCellReuseIdentifier:@"CategoryCell"];
  [self.tableView setRowHeight:SCALE_SIZE*60];
  [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    make.width.mas_equalTo(SCREEN_WIDTH*0.2);
    make.height.equalTo(self.view);
  }];
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, SafeAreaBottomHeight+BASE_HEIGHT, 0)];
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

@end
