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

@interface HomeViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView; // 轮播图

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.navigationItem.title = @"首页";
  self.cycleScrollView.imageURLStringsGroup = @[@"",@""];
}

// SDCycleScrollView delegate 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  CategoryDetailController * detailVC = [[CategoryDetailController alloc] init];
  [self.navigationController pushViewController:detailVC animated:YES];
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
    [self.view addSubview:_cycleScrollView];
  }
  return _cycleScrollView;
}

@end
