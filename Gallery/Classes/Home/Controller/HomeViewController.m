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

@interface HomeViewController () <SDCycleScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView; // 轮播图
@property (nonatomic, strong) HomeShowView  *showView;
@property (nonatomic, strong) UIScrollView  *showScrollView;

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
  
}

// scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

  int page = floor(self.showScrollView.contentOffset.x / (SCALE_SIZE*327)) + 1;
  [self.showView setCurrentCount:page];
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

-(UIScrollView *)showScrollView {
  if (!_showScrollView) {
    _showScrollView = [[UIScrollView alloc] init];
    [_showScrollView setShowsHorizontalScrollIndicator:NO];
    [_showScrollView setDelegate:self];
    [_showScrollView setContentSize:CGSizeMake(SCALE_SIZE*327*8+SCALE_SIZE*70+SCALE_SIZE*58, 0)];
    [self.view addSubview:_showScrollView];
    
    for (int i = 0; i < 8; i++) {
      UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      [button setFrame:CGRectMake(SCALE_SIZE*24+SCALE_SIZE*337*i, 0, SCALE_SIZE*327, SCALE_SIZE*186)];
      [button setBackgroundColor:BASECOLOR_BACKGROUND_GRAY];
      [_showScrollView addSubview:button];
      
      UILabel *titleLabel = [[UILabel alloc] init];
      [titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*16 weight:UIFontWeightBold]];
      [titleLabel setTextColor:BASECOLOR_BLACK_333];
      [titleLabel setText:@"苹果包装"];
      [_showScrollView addSubview:titleLabel];
      
      [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button);
        make.top.equalTo(button.mas_bottom).offset(SCALE_SIZE*10);
      }];
      
      UILabel *detailLabel = [[UILabel alloc] init];
      [detailLabel setFont:FONTSIZE(14)];
      [detailLabel setTextColor:BASECOLOR_BLACK_999];
      [detailLabel setText:@"与生俱来的艺术品，包装本该不同"];
      [_showScrollView addSubview:detailLabel];
      
      [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button);
        make.top.equalTo(titleLabel.mas_bottom).offset(SCALE_SIZE*5);
      }];
    }
  }
  return _showScrollView;
}

-(void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  [self.showView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.equalTo(self.view);
    make.top.equalTo(self.cycleScrollView.mas_bottom).offset(SCALE_SIZE*30);
    make.height.mas_equalTo(SCALE_SIZE*50);
  }];
  
  [self.showScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.width.bottom.equalTo(self.view);
    make.top.equalTo(self.showView.mas_bottom);
  }];
}

@end
