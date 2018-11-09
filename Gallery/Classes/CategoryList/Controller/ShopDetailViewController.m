//
//  ShopDetailViewController.m
//  Gallery
//
//  Created by admin on 2018/11/9.
//  Copyright © 2018 安东. All rights reserved.
//

#import "ShopDetailViewController.h"

@interface ShopDetailViewController ()
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIButton *exhibitionBtn;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"高档礼盒包装方案";
  [self.view addSubview:self.scrollView];
  [self.view addSubview:self.exhibitionBtn];
}

-(UIButton *)exhibitionBtn {
  if (_exhibitionBtn) {
    _exhibitionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exhibitionBtn setFrame:CGRectMake(0, SCREEN_HEIGHT - SafeAreaBottomHeight- 50, SCREEN_WIDTH, 50)];
    [_exhibitionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_exhibitionBtn setTitle:@"3D展示" forState:UIControlStateNormal];
    [_exhibitionBtn setBackgroundColor:BASECOLOR_BLACK_333];
    [_exhibitionBtn addTarget:self action:@selector(exhibitionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  }
  return _exhibitionBtn;
}
-(void)exhibitionButtonAction:(UIButton *)sender{
  
}

-(UIScrollView *)scrollView{
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT -SafeAreaBottomHeight - 50)];
    _scrollView.backgroundColor = [UIColor redColor];
    AdjustsScrollViewInsetNever(self, _scrollView);
    [_scrollView setShowsVerticalScrollIndicator:NO];
  }
  return _scrollView;
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
