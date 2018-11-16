//
//  OrderPreviewController.m
//  Gallery
//
//  Created by 安东 on 16/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "OrderPreviewController.h"
#import "SchemeCell.h"
#import "PreviewCell.h"
#import "DeliveryDateCell.h"
#import "SelectCountCell.h"
#import "BottomSelectBar.h"

@interface OrderPreviewController () <BottomSelectBarDelegate>

@property (nonatomic, strong) UIView  *footerView;
@property (nonatomic, strong) BottomSelectBar  *bottomBar;

@end

@implementation OrderPreviewController

-(void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"清单明细";
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
//  [self.tableView setContentSize:CGSizeMake(0, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT-SCALE_SIZE*50)];
  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, SCALE_SIZE*50, 0);
  [self.tableView setTableFooterView:self.footerView];
  
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*10)];
  [headerView setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
  [self.tableView setTableHeaderView:headerView];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  BaseNavigationController *nav = (BaseNavigationController *)self.navigationController;
  [nav setNavigationBarRightItemWithButtonTitle:@"保存"];
  [nav setNavigationBarRightItemWithImageName:@"" highlightImageName:@""];
}


#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    
    SchemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SchemeCell" forIndexPath:indexPath];
    return cell;
  } else if (indexPath.row == 6) {
    DeliveryDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeliveryDateCell" forIndexPath:indexPath];
    return cell;
  } else if (indexPath.row == 7) {
    SelectCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCountCell" forIndexPath:indexPath];
    return cell;
  }
  
  PreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreviewCell" forIndexPath:indexPath];
  [cell setDic:self.dataSource[indexPath.row-1]];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return SCALE_SIZE*186;
  } else if (indexPath.row == 6 || indexPath.row == 7) {
    return SCALE_SIZE*52;
  }
  else {
    return SCALE_SIZE*57;
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma marks - BottomSelectBar delegate
-(void)bottomBarWithLeftBtnClick:(id)sender {
  
}

-(void)bottomBarWithRightBtnClick:(id)sender {
  
}

#pragma marks - getters
-(UIView *)footerView {
  if (!_footerView) {
    _footerView = [[UIView alloc] init];
    [_footerView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*64)];
    
    UIView *lineView = [[UIView alloc] init];
    [lineView setFrame:CGRectMake(SCALE_SIZE*10, 0, SCREEN_WIDTH-SCALE_SIZE*20, 0.5)];
    [lineView setBackgroundColor:BASECOLOR_LINE];
    [_footerView addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(0, 0.5, SCREEN_WIDTH-SCALE_SIZE*10, SCALE_SIZE*63)];
    [label setTextColor:BASECOLOR_BLACK_333];
    [label setFont:FONTSIZE(14)];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setText:@"总金额：¥ 30.00"];
    [_footerView addSubview:label];
  }
  return _footerView;
}

-(BottomSelectBar *)bottomBar {
  if (!_bottomBar) {
    _bottomBar = [[BottomSelectBar alloc] initWithLeftTitle:@"加入订货单" rightTitle:@"提交打样" delegate:self];
    [self.tableView addSubview:_bottomBar];
  }
  return _bottomBar;
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
