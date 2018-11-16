//
//  PackagingBaseController.m
//  Gallery
//
//  Created by 安东 on 13/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "PackagingBaseController.h"
#import "OrderPreviewController.h"

@interface PackagingBaseController ()

@property (nonatomic, strong) UIButton  *createBtn; // 提交打样
@property (nonatomic, strong) UIButton  *placeOrderBtn; // 下生产单
@property (nonatomic, strong) UIView  *lineView;

@end

@implementation PackagingBaseController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

// 提交打样
- (void)samplePrepareBtnClick {
  OrderPreviewController *vc = [[OrderPreviewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

// 下生产单
- (void)placeOrderBtnClick {
  
}

#pragma marks - getters
-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
  }
  return _scrollView;
}


-(UIButton *)createBtn {
  if (!_createBtn) {
    _createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_createBtn setTitle:@"提交打样" forState:UIControlStateNormal];
    [_createBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [[_createBtn titleLabel] setFont:FONTSIZE(16)];
    [_createBtn addTarget:self action:@selector(samplePrepareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_createBtn];
  }
  return _createBtn;
}

-(UIButton *)placeOrderBtn {
  if (!_placeOrderBtn) {
    _placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_placeOrderBtn setTitle:@"下生产单" forState:UIControlStateNormal];
    [_placeOrderBtn setBackgroundColor:[UIColor whiteColor]];
    [_placeOrderBtn setTitleColor:BASECOLOR_BLACK_000 forState:UIControlStateNormal];
    [[_placeOrderBtn titleLabel] setFont:FONTSIZE(16)];
    [_placeOrderBtn addTarget:self action:@selector(placeOrderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:_placeOrderBtn];
  }
  return _placeOrderBtn;
}

-(UIView *)lineView {
  if (!_lineView) {
    _lineView = [[UIView alloc] init];
    [_lineView setBackgroundColor:BASECOLOR_LINE];
    [self.scrollView addSubview:_lineView];
  }
  return _lineView;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.top.equalTo(self.placeOrderBtn).offset(-0.5);
    make.height.mas_equalTo(0.5);
  }];
  
  [self.placeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.view);
    make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    make.width.mas_equalTo(SCREEN_WIDTH/2);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
  
  [self.createBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.mas_equalTo(SCREEN_WIDTH/2);
    make.bottom.equalTo(self.view).offset(-SafeAreaBottomHeight);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}

@end
