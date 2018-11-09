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
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"高档礼盒包装方案";
  [self.view addSubview:self.exhibitionBtn];
  [self.view addSubview:self.scrollView];
  self.cycleScrollView.imageURLStringsGroup = @[@"",@""];
  
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.left.equalTo(self.showView);
    make.left.mas_equalTo(SCALE_SIZE * 15);
    make.right.mas_equalTo(-SCALE_SIZE* 15);
    make.top.equalTo(self.showView.mas_bottom).offset(SCALE_SIZE*10);
  }];
  [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.right.equalTo(self.titleLabel);
    make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_SIZE*5);
  }];



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

-(UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel  = [[UILabel alloc] init];
    [_titleLabel setFont:[UIFont systemFontOfSize:SCALE_SIZE*16 weight:UIFontWeightBold]];
    [_titleLabel setTextColor:BASECOLOR_BLACK_333];
    [_titleLabel setText:@"与生俱来的艺术品，包装本该不同"];
    [_scrollView addSubview:_titleLabel];
  }
  return _titleLabel;
}

-(UILabel *)detailLabel{
  if (!_detailLabel) {
    _detailLabel  = [[UILabel alloc] init];
    [_detailLabel setFont:FONTSIZE(14)];
    [_detailLabel setTextColor:BASECOLOR_BLACK_999];
    [_detailLabel setNumberOfLines:1];
    [_detailLabel setText:@"我们从来不怀疑，“有趣”可能给产品带来巨大的价值。我们试图用略带夸张与戏虐的人物表情来呈现这三个与苹果有关联的人物。引发用户快速的认知和趣味的联系"];
    [_showView addSubview:_detailLabel];
  }
  return _detailLabel;
}

-(UIScrollView *)scrollView {
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT -SafeAreaBottomHeight - 50)];
    AdjustsScrollViewInsetNever(self, _scrollView);
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setContentSize:CGSizeMake(0, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT -SafeAreaBottomHeight - 50)];
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
