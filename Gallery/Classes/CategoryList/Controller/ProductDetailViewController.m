//
//  ShopDetailViewController.m
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "SDCycleScrollView.h"
#import "HomeShowView.h"
#import "SceneViewController.h"

@interface ProductDetailViewController () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *exhibitionBtn;
@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView; // 轮播图
@property (nonatomic, strong) HomeShowView  *showView;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"高档礼盒包装方案";
  [self.view addSubview:self.exhibitionBtn];
  [self.view addSubview:self.scrollView];
  self.cycleScrollView.imageURLStringsGroup = @[@"",@""];

}

// SDCycleScrollView delegate 点击图片回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
  
}

// 3D展示按钮点击事件
-(void)exhibitionButtonAction:(UIButton *)sender {
  SceneViewController *vc = [[SceneViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma marks - getters
-(UIButton *)exhibitionBtn {
  if (!_exhibitionBtn) {
    _exhibitionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exhibitionBtn setFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight- 50 -NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 50)];
    [_exhibitionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_exhibitionBtn setTitle:@"3D展示" forState:UIControlStateNormal];
    [_exhibitionBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [_exhibitionBtn addTarget:self action:@selector(exhibitionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _exhibitionBtn;
}



-(HomeShowView *)showView {
  if (!_showView) {
    _showView = [[HomeShowView alloc] init];
    [self.view addSubview:_showView];
  }
  return _showView;
}

-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT -SafeAreaBottomHeight - 50)];
    AdjustsScrollViewInsetNever(self, _scrollView);
    [_scrollView setShowsVerticalScrollIndicator:NO];
  }
  return _scrollView;
}

-(SDCycleScrollView *)cycleScrollView {
  if (!_cycleScrollView) {
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_SIZE*388)
                                                          delegate:self
                                                  placeholderImage:nil];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    _cycleScrollView.autoScroll = NO;
    _cycleScrollView.backgroundColor = BASECOLOR_BACKGROUND_GRAY;
    [self.scrollView addSubview:_cycleScrollView];
  }
  return _cycleScrollView;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.top.equalTo(self.cycleScrollView.mas_bottom);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
