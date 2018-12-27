//
//  HomeViewController.m
//  Gallery
//
//  Created by 安东 on 08/11/2018.
//  Copyright © 2018 安东. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "CategoryDetailController.h"
#import "HomeShowView.h"
#import "PageRoundScrollView.h"
#import "SceneViewController.h"

@interface HomeViewController () <SDCycleScrollViewDelegate, PageRoundScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView; // 轮播图
@property (nonatomic, strong) HomeShowView  *showView;
@property (nonatomic, strong) UIScrollView  *showScrollView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"首页";
  [self setupNavigationBarButton];
  self.cycleScrollView.localizationImageNamesGroup = @[@"home_1",@"home_1"];
  
  PageRoundScrollView *scrollView = [[PageRoundScrollView alloc] init];
  [scrollView setDelegate:self];
  [self.view addSubview:scrollView];
  
  [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.bottom.equalTo(self.view);
    make.top.equalTo(self.showView.mas_bottom);
  }];
  
  
}

// SDCycleScrollView delegate 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  SceneViewController *vc = [[SceneViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

// pageRoundScrolView delegate
-(void)pageRoundScrollWithPage:(int)page {
  [self.showView setCurrentCount:page];
}

- (void)setupNavigationBarButton {
  
  UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [scanBtn setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
  [scanBtn setFrame:CGRectMake(0, 0, 30, BASE_HEIGHT)];
  
  UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
  [searchBtn setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
  [searchBtn setFrame:CGRectMake(0, 0, 30, BASE_HEIGHT)];
  
  UIBarButtonItem *scanItem = [[UIBarButtonItem alloc] initWithCustomView:scanBtn];
  UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
  

  [self.navigationItem setRightBarButtonItems:@[searchItem,scanItem]];
}

#pragma marks - getters
-(SDCycleScrollView *)cycleScrollView {
  if (!_cycleScrollView) {
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*177)
                                                          delegate:self
                                                  placeholderImage:nil];
    _cycleScrollView.currentPageDotColor = BASECOLOR_BLACK_333;
    _cycleScrollView.pageDotColor = BASECOLOR_BLACK_999;
    _cycleScrollView.pageControlBottomOffset = -SCALE_SIZE*30;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    [self.view addSubview:_cycleScrollView];
  }
  return _cycleScrollView;
}

-(HomeShowView *)showView {
  if (!_showView) {
    _showView = [[HomeShowView alloc] init];
    [_showView setTitleString:@"产品展示"];
    [self.view addSubview:_showView];
  }
  return _showView;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.top.equalTo(self.cycleScrollView.mas_bottom).offset(SCALE_SIZE*30);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}

@end
